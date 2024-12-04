#include <iostream>
#include <fstream>
#include <vector>
#include <unordered_map>

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

// Function to calculate the total similarity score
int calculateSimilarityScore(const std::vector<int>& leftList, const std::vector<int>& rightList) {
    // Count the occurrences of each number in the right list
    std::unordered_map<int, int> rightCount;
    for (int num : rightList) {
        rightCount[num]++;
    }

    // Calculate the similarity score
    int similarityScore = 0;
    for (int num : leftList) {
        similarityScore += num * rightCount[num];
    }

    return similarityScore;
}

int main() {
    std::vector<int> leftList, rightList;
    
    // Read the input file
    std::string input_path = "./data/day01/input.txt";
    readInputFile(input_path, leftList, rightList);

    // Calculate the similarity score
    int similarityScore = calculateSimilarityScore(leftList, rightList);

    // Print the result
    std::cout << "Total similarity score: " << similarityScore << std::endl;

    return 0;
}
