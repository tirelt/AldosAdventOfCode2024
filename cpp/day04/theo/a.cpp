#include <fstream>
#include <iostream>
#include <string>
#include <vector>

using std::cout;
using std::endl;
using std::string;
using std::vector;

vector<string> find_surrounding_words(vector<vector<char>> const & words,int const & i, int const & j ){
    vector<string> ret;
    string temp;
    if(i+3<words.size()){
        temp.clear();
        for(unsigned k=0; k < 4;++k){
            temp.push_back(words[i+k][j]);
        }
        ret.push_back(temp);
    }
    if(i-3>=0){
        temp.clear();
        for(unsigned k=0; k < 4;++k){
            temp.push_back(words[i-k][j]);
        }
        ret.push_back(temp);
    }
    if(j+3<words[0].size()){
        temp.clear();
        for(unsigned k=0; k < 4;++k){
            temp.push_back(words[i][j+k]);
        }
        ret.push_back(temp);
    }
    if(j-3>=0){
        temp.clear();
        for(unsigned k=0; k < 4;++k){
            temp.push_back(words[i][j-k]);
        }
        ret.push_back(temp);
    }
    if(i+3<words.size()&&j+3<words[0].size()){
        temp.clear();
        for(unsigned k=0; k < 4;++k){
            temp.push_back(words[i+k][j+k]);
        }
        ret.push_back(temp);
    }
    if(i+3<words.size()&&j-3>=0){
        temp.clear();
        for(unsigned k=0; k < 4;++k){
            temp.push_back(words[i+k][j-k]);
        }
        ret.push_back(temp);
    }
    if(i-3>=0&&+3<words[0].size()){
        temp.clear();
        for(unsigned k=0; k < 4;++k){
            temp.push_back(words[i-k][j+k]);
        }
        ret.push_back(temp);
    }
    if(i-3>=0&&j-3>=0){
        temp.clear();
        for(unsigned k=0; k < 4;++k){
            temp.push_back(words[i-k][j-k]);
        }
        ret.push_back(temp);
    }
    return ret;
}

int main(){
    std::ifstream file("input");
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
            if(words[i][j]=='X'){
                vector<string> surrounding_words = find_surrounding_words(words, i, j);
                for(string const& w:surrounding_words){
                    if(w==target){
                        ++ret_1;
                    }
                }
            }
        }
    }
    cout<< "Part 1: " << ret_1 << endl;   
    return 0;
}