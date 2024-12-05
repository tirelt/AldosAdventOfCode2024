#include <fstream>
#include <iostream>
#include <string>
#include <vector>

using std::cout;
using std::endl;
using std::string;
using std::vector;

bool is_on_x(vector<vector<char>> const & words,int const & i, int const & j ){
    bool ret=false;
    if(i-1>=0&&j-1>=0&&i+1<words.size()&&j+1<words[0].size()){
        string word_1{words[i-1][j-1],words[i][j],words[i+1][j+1]};
        string word_2{words[i+1][j-1],words[i][j],words[i-1][j+1]};
        ret = (word_1 == "MAS" || word_1 == "SAM") && (word_2 == "MAS" || word_2 == "SAM");
    }
    return ret;
}
int main(){
    std::ifstream file("./data/day04/input.txt");
    vector<vector<char>> words;
    string line;
    string target = "XMAS";
    unsigned ret_1 = 0;
    unsigned ret_2 = 0;
    while(getline(file,line)){
        vector<char> temp;
        for(char const &c: line){
            temp.push_back(c);
        }
        words.push_back(temp);
    }
    file.close();

    for(int i=0; i<words.size();++i){
        for(int j=0; j<words[0].size();++j){
            if(words[i][j]=='A'){
                if(is_on_x(words,i,j)){
                    ++ret_2;
                }
            }
        }
    }

    // cout<< "Part 1: " << ret_1 << endl;  
    cout<< "Part 2: " << ret_2 << endl;  
    return 0;
}