/**
 * @file interrupts.cpp
 * @author Sasisekhar Govind
 * @brief template main.cpp file for Assignment 3 Part 1 of SYSC4001
 * 
 */

#include "interrupts_student1_student2.hpp"

#define TIME_QUANTUM 100

std::tuple<std::string> run_simulation(std::vector<PCB> list_processes) {
    std::vector<PCB> ready_queue;
    std::vector<PCB> wait_queue;
    std::vector<PCB> job_list;

    unsigned int current_time = 0;
    PCB running;
    idle_CPU(running);

    std::string execution_status = print_exec_header();
    
    int next_io_time = -1;
    int quantum_remaining = TIME_QUANTUM;

    while(true) {
        // 1. Handle new arrivals
        for(auto &process : list_processes) {
            if(process.arrival_time == current_time && process.state == NOT_ASSIGNED) {
                if(assign_memory(process)) {
                    execution_status += print_exec_status(current_time, process.PID, NOT_ASSIGNED, READY);
                    process.state = READY;
                    ready_queue.push_back(process);
                    job_list.push_back(process);
                }
            }
        }

        // 2. Handle I/O completions
        std::vector<PCB> still_waiting;
        for(auto &waiting_process : wait_queue) {
            bool io_complete = false;
            
            for(auto &job : job_list) {
                if(job.PID == waiting_process.PID && job.start_time == (int)current_time) {
                    io_complete = true;
                    execution_status += print_exec_status(current_time, job.PID, WAITING, READY);
                    job.state = READY;
                    ready_queue.push_back(job);
                    break;
                }
            }
            
            if(!io_complete) {
                still_waiting.push_back(waiting_process);
            }
        }
        wait_queue = still_waiting;

        // 3. Handle running process
        if(running.state == RUNNING) {
            // Check for I/O first
            if(running.io_freq > 0 && next_io_time == (int)current_time) {
                execution_status += print_exec_status(current_time, running.PID, RUNNING, WAITING);
                running.state = WAITING;
                running.start_time = current_time + running.io_duration;
                wait_queue.push_back(running);
                sync_queue(job_list, running);
                idle_CPU(running);
                next_io_time = -1;
                quantum_remaining = TIME_QUANTUM;
            }
            // Check for completion
            else if(running.remaining_time == 0) {
                execution_status += print_exec_status(current_time, running.PID, RUNNING, TERMINATED);
                terminate_process(running, job_list);
                idle_CPU(running);
                next_io_time = -1;
                quantum_remaining = TIME_QUANTUM;
            }
            // Check for timeout (preemption)
            else if(quantum_remaining == 0) {
                execution_status += print_exec_status(current_time, running.PID, RUNNING, READY);
                running.state = READY;
                ready_queue.push_back(running);
                sync_queue(job_list, running);
                idle_CPU(running);
                next_io_time = -1;
                quantum_remaining = TIME_QUANTUM;
            }
            // Execute
            else {
                running.remaining_time--;
                quantum_remaining--;
                sync_queue(job_list, running);
            }
        }

        // 4. Schedule next process (FIFO from ready queue)
        if(running.state != RUNNING && !ready_queue.empty()) {
            running = ready_queue.front();
            ready_queue.erase(ready_queue.begin());
            
            execution_status += print_exec_status(current_time, running.PID, READY, RUNNING);
            running.state = RUNNING;
            quantum_remaining = TIME_QUANTUM;
            
            if(running.io_freq > 0) {
                if(running.start_time == -1) {
                    running.start_time = current_time;
                }
                next_io_time = current_time + running.io_freq;
            }
            
            sync_queue(job_list, running);
        }

        current_time++;

        if(all_process_terminated(job_list) && ready_queue.empty() && 
           wait_queue.empty() && running.state != RUNNING) {
            break;
        }
        
        if(current_time > 100000) {
            std::cout << "Simulation timeout!" << std::endl;
            break;
        }
    }
    
    execution_status += print_exec_footer();
    return std::make_tuple(execution_status);
}

int main(int argc, char** argv) {
    if(argc != 2) {
        std::cout << "ERROR!\nExpected 1 argument" << std::endl;
        return -1;
    }

    std::ifstream input_file(argv[1]);
    if (!input_file.is_open()) {
        std::cerr << "Error opening file" << std::endl;
        return -1;
    }

    std::string line;
    std::vector<PCB> list_process;
    while(std::getline(input_file, line)) {
        auto input_tokens = split_delim(line, ", ");
        auto new_process = add_process(input_tokens);
        list_process.push_back(new_process);
    }
    input_file.close();

    auto [exec] = run_simulation(list_process);
    write_output(exec, "execution.txt");

    return 0;
}