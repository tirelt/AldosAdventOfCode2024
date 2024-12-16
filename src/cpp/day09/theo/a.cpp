#include <fstream>
#include <iostream>
#include <string>
#include <vector>
#include <list>

using std::cout;
using std::endl;
using std::string;
using std::vector;
using std::list;

struct Block{
    Block(int i,unsigned s):id(i),size(s){}
    int id;
    unsigned size;
};

int main(){
    std::ifstream file("./data/day09/input.txt");
    string line;
    long long ret_1 = 0;
    long long ret_2 = 0;
    getline(file,line);
    unsigned counter=0;
    vector<int> IDs;
    list<Block> blocks;
    unsigned n;
    for(const char& c:line){   
        n = c - '0';
        if(!(counter++%2)){
            blocks.emplace_back(counter/2,n);
            for(unsigned i=0;i<n;++i){
                IDs.push_back(counter/2);
            }
        } else {
            blocks.emplace_back(-1,n);
            for(unsigned i=0;i<n;++i){
                IDs.push_back(-1);
            }
        }
    }
    //Part 1 
    unsigned i=0;
    while(i<IDs.size()){
        if(IDs[i]==-1){
            while(IDs.back()==-1){
                IDs.pop_back();
            }
            IDs[i] = IDs.back();
            IDs.pop_back();
        }
        ++i;
    }
    for(size_t i=0;i<IDs.size();++i){
        ret_1 += i*IDs[i];
    }
    cout << "Part 1: " << ret_1 << endl;  
    return 0;
}