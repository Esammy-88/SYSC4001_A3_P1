# ==================== Makefile ====================

CXX = g++
CXXFLAGS = -Wall -Wextra -g -std=c++17 -pthread

BINDIR = bin
INPUTDIR = input_files
OUTPUTDIR = output_files

SCHEDULERS = $(BINDIR)/interrupts_EP \
             $(BINDIR)/interrupts_RR \
             $(BINDIR)/interrupts_EP_RR

.PHONY: all part1 part2 clean dirs test \
        test_ep test_rr test_ep_rr test_ta generate_inputs

# ==================== Build Everything ====================

all: dirs part1 part2

dirs:
	@mkdir -p $(BINDIR) $(INPUTDIR) $(OUTPUTDIR)

# ==================== Part 1: Schedulers ====================

part1: $(SCHEDULERS)

$(BINDIR)/interrupts_EP: interrupts_student1_student2_EP.cpp interrupts_student1_student2.hpp
	$(CXX) $(CXXFLAGS) -I. -o $@ $<

$(BINDIR)/interrupts_RR: interrupts_student1_student2_RR.cpp interrupts_student1_student2.hpp
	$(CXX) $(CXXFLAGS) -I. -o $@ $<

$(BINDIR)/interrupts_EP_RR: interrupts_student1_student2_EP_RR.cpp interrupts_student1_student2.hpp
	$(CXX) $(CXXFLAGS) -I. -o $@ $<


# ==================== Testing (All 22 Tests) ====================

test: test_ep test_rr test_ep_rr
	@echo "All tests complete! Check $(OUTPUTDIR)/"

test_ep: $(BINDIR)/interrupts_EP
	@echo "Testing External Priority Scheduler..."
	@for i in $$(seq 1 22); do \
		if [ -f $(INPUTDIR)/test$$i.txt ]; then \
			echo "Running EP on test$$i..."; \
			./$(BINDIR)/interrupts_EP $(INPUTDIR)/test$$i.txt > /dev/null; \
			mv execution.txt $(OUTPUTDIR)/execution_EP_test$$i.txt; \
		fi; \
	done

test_rr: $(BINDIR)/interrupts_RR
	@echo "Testing Round Robin Scheduler..."
	@for i in $$(seq 1 22); do \
		if [ -f $(INPUTDIR)/test$$i.txt ]; then \
			echo "Running RR on test$$i..."; \
			./$(BINDIR)/interrupts_RR $(INPUTDIR)/test$$i.txt > /dev/null; \
			mv execution.txt $(OUTPUTDIR)/execution_RR_test$$i.txt; \
		fi; \
	done

test_ep_rr: $(BINDIR)/interrupts_EP_RR
	@echo "Testing Combined EP+RR Scheduler..."
	@for i in $$(seq 1 22); do \
		if [ -f $(INPUTDIR)/test$$i.txt ]; then \
			echo "Running EP+RR on test$$i..."; \
			./$(BINDIR)/interrupts_EP_RR $(INPUTDIR)/test$$i.txt > /dev/null; \
			mv execution.txt $(OUTPUTDIR)/execution_EP_RR_test$$i.txt; \
		fi; \
	done

# ==================== Generate Input Files ====================

generate_inputs:
	@bash generate_inputs.sh

# ==================== Clean ====================

clean:
	rm -rf $(BINDIR)/* $(OUTPUTDIR)/*
	rm -f execution.txt rubric.txt exam_*.txt
	@echo "Clean complete"
