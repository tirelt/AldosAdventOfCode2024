#include <fstream>
#include <iostream>
#include <sstream>
#include <vector>
#include <string>

using std::cout;
using std::endl;
using std::vector;
using std::string;
using std::istringstream;

bool is_safe(vector<int>& report,unsigned tolerance){ //not going to work for tolerance >1
    unsigned i=0,j=1;

    //check if we need to exclude first value
    vector<int> diff{report[1]-report[0],report[2]-report[1],report[3]-report[2]};
    bool exclude_first = false;
    if(tolerance>0 && diff[1]>0 && diff[1]<4 && diff[2]>0 && diff[2]<4){
        exclude_first = !(diff[0]>0 && diff[0]<4);
    } else if(tolerance>0 && diff[1]<0 && diff[1]>-4 && diff[2]<0 && diff[2]>-4){
        exclude_first = !(diff[0]<0 && diff[0]>-4);
    } 
    if(exclude_first){
        --tolerance;
        i=j++;
    }
    //check increasing or decreasing
    int sign_diff=0;
    for(int const& d: diff){
        if(d>0)
            ++sign_diff;
        else
            --sign_diff;
    }
    bool increasing = sign_diff>=0;

    // normal loop
    while(j<report.size()){
        bool fail = false;
        unsigned diff = abs(report[i]-report[j]);
        if( diff > 0 && diff < 4 ){
            if(increasing){
                if(report[j]<report[i]){
                    if(!tolerance){
                        return false;
                    } else{
                        fail = true;                        
                    }
                }
            } else{
                if(report[j]>report[i]){
                    if(!tolerance){
                        return false;
                    } else{
                        fail = true;                        
                    }
                }
            }
        } else {
            if(!tolerance){
                return false;
            } else{
                fail = true;                        
            }
        }
        if(fail){
            ++j;
            --tolerance;
        } else {
            i=j++;
        }
    }
    return true;
}

int main(){
    std::ifstream file("../data/day01/input.txt");
    string line;
    vector<int> report;
    string entry;
    unsigned res = 0;
    while(getline(file,line)){
        report.clear();
        istringstream entries(line,' ');
        while (entries >> entry){
            report.push_back(stoi(entry));
        }
        if(is_safe(report,1)){ //tolerance=0 for part 1, tolerance=1 for part 2 
            ++res;
        }  
    }
    file.close();
    cout<< "The number of safe report is: " << res << endl;  
    return 0;
}