#!/bin/bash

echo "===================="
echo "Building Assignment 3 (C++ Version)"
echo "===================="

mkdir -p bin input_files output_files

# ----------- Compile Schedulers -----------
echo ""
echo "Compiling schedulers..."

g++ -Wall -Wextra -g -std=c++17 -I. -o bin/interrupts_EP interrupts_101246652_101299749_EP.cpp
g++ -Wall -Wextra -g -std=c++17 -I. -o bin/interrupts_RR interrupts_101246652_101299749_RR.cpp
g++ -Wall -Wextra -g -std=c++17 -I. -o bin/interrupts_EP_RR interrupts_101246652_101299749_EP_RR.cpp

echo "✓ Schedulers compiled"


# ----------- Generate Input Files ----------
echo ""
echo "Generating input files..."
bash generate_inputs.sh

# ----------- Run All Tests ----------
echo ""
echo "Running all 22 tests on all schedulers..."
#!/bin/bash

echo "===================="
echo "Building Assignment 3 (C++ Version)"
echo "===================="

mkdir -p bin input_files output_files

# ----------- Compile Schedulers -----------
echo ""
echo "Compiling schedulers..."

g++ -Wall -Wextra -g -std=c++17 -I. -o bin/interrupts_EP interrupts_101246652_101299749_EP.cpp
g++ -Wall -Wextra -g -std=c++17 -I. -o bin/interrupts_RR interrupts_101246652_101299749_RR.cpp
g++ -Wall -Wextra -g -std=c++17 -I. -o bin/interrupts_EP_RR interrupts_101246652_101299749_EP_RR.cpp

echo "✓ Schedulers compiled"


# ----------- Generate Input Files ----------
echo ""
echo "Generating input files..."
bash generate_inputs.sh

# ----------- Run All Tests ----------
echo ""
echo "Running all 22 tests on all schedulers..."
bash run_tests.sh

echo ""
echo "===================="
echo "Build + Test Complete!"
echo "===================="
echo "Outputs saved in: output_files/"
bash run_tests.sh

echo ""
echo "===================="
echo "Build + Test Complete!"
echo "===================="
echo "Outputs saved in: output_files/"
