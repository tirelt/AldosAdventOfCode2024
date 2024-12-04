#include <fstream>
#include <iostream>
#include <vector>
#include <string>
#include <algorithm>
#include <map>

using std::cout;
using std::endl;
using std::vector;
using std::string;
using std::map;
using std::sort;

int main(){
    std::string input_path = "../data/day01/input.txt";
    std::ifstream file(input_path);
    string line;
    vector<int> list_1;
    vector<int> list_2;
    map<int,int> count_map;
    while(getline(file,line)){
        list_1.push_back(stoi(line.substr(0,5))); 
        list_2.push_back(stoi(line.substr(8,5))); 
        count_map[list_2.back()] += 1;
    }
    file.close();
    sort(list_1.begin(),list_1.end());
    sort(list_2.begin(),list_2.end());

    int res_2 = 0;
    for(int const& i : list_1){
        res_2 += i*count_map[i];
    }
    cout<< "The similarity score is: " << res_2 << endl;  
    return 0;
}