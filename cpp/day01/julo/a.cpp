#include <iostream>
#include <fstream>
#include <vector>
#include <algorithm>
#include <cmath>

// Function to read the input file and parse the location IDs
void readInputFile(const std::string& filename, std::vector<int>& leftList, std::vector<int>& rightList) {
    std::ifstream inputFile(filename);
    if (!inputFile) {
        std::cerr << "Failed to open the file." << std::endl;
        exit(1);
    }

    int left, right;
    while (inputFile >> left >> right) {
        leftList.push_back(left);
        rightList.push_back(right);
    }

    inputFile.close();
}

// Function to calculate the total distance between two lists
int calculateTotalDistance(std::vector<int>& leftList, std::vector<int>& rightList) {
    // Sort both lists
    std::sort(leftList.begin(), leftList.end());
    std::sort(rightList.begin(), rightList.end());

    // Calculate the sum of absolute differences
    int totalDistance = 0;
    for (size_t i = 0; i < leftList.size(); ++i) {
        totalDistance += std::abs(leftList[i] - rightList[i]);
    }

    return totalDistance;
}

int main() {
    std::vector<int> leftList, rightList;
    
    // Read the input file
    std::string input_path = "../data/day01/input.txt";
    readInputFile(input_path, leftList, rightList);

    // Calculate the total distance
    int totalDistance = calculateTotalDistance(leftList, rightList);

    // Print the result
    std::cout << "Total distance: " << totalDistance << std::endl;

    return 0;
}