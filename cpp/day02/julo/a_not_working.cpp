#include <iostream>
#include <fstream>
#include <vector>
#include <sstream>
#include <string>

bool isSafeReport(const std::vector<int>& levels) {
    bool is_increasing = true;
    bool is_decreasing = true;

    for (size_t i = 1; i < levels.size(); ++i) {
        int diff = levels[i] - levels[i - 1];

        // Check if the difference is between 1 and 3
        if (diff < 1 && diff > -3) {
            return false;
        }

        // Check if the sequence is not strictly increasing
        if (diff <= 0) {
            is_increasing = false;
        }

        // Check if the sequence is not strictly decreasing
        if (diff >= 0) {
            is_decreasing = false;
        }

        // If neither increasing nor decreasing, it's unsafe
        if (!is_increasing && !is_decreasing) {
            return false;
        }
    }

    return true;
}

int main() {
    std::ifstream inputFile("../data/day02/input.txt");
    if (!inputFile.is_open()) {
        std::cerr << "Error: Could not open the file 'input.txt'" << std::endl;
        return 1;
    }

    std::string line;
    int safeReportCount = 0;

    while (std::getline(inputFile, line)) {
        std::istringstream iss(line);
        std::vector<int> levels;
        int level;

        while (iss >> level) {
            levels.push_back(level);
        }

        if (isSafeReport(levels)) {
            ++safeReportCount;
        }
    }

    inputFile.close();
    std::cout << "Number of safe reports: " << safeReportCount << std::endl;
    return 0;
}
