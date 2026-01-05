#include <iostream>
#include <fstream>
#include <sstream>
#include "clase.h"
using namespace std;

vector<Drum*> drumuri;
vector<Contract*> contracte;

int main()
{
    ifstream drum_in("drumurietc.in");
    ifstream con_in("contracte.in");
    
    citire_drumuri(drum_in, drumuri);
    return 0;


}
