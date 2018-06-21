#include <iostream>

#include "src/lib/lib.hpp"

int main(int argc, const char** argv) {
    std::cout << "got " << argc << " arguments starting at " << (std::size_t)argv << std::endl;
    std::cout << "magic is: " << MAGIC << std::endl;
    return 0;
}
