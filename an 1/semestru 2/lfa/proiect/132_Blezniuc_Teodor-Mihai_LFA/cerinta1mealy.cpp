#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <map>
#include <sstream>
#include <utility>

using namespace std;

struct Stare
{
    vector<pair<string,pair<char,char>> > urmatoare;
            //urmatoarea stare, litera_input din tranzitie, litera_output
};

map<string, Stare> stari;

void fa_mealy(ifstream& fin)
{

    string line;
    while (getline(fin, line)) {
    string q, next_q;
    char litera_input, litera_output;

    stringstream ss(line);
        while (ss)
        {
            getline(ss, q, ' ');

            ss.ignore(2);
            ss >> litera_input;
            ss.ignore(1);
            ss >> litera_output;
            ss.ignore(3);

            getline(ss, next_q, ',');
            if(ss.peek()==' ') ss.ignore(1);
            next_q=next_q.substr(1);//pt ca ramanea spatiu in fata cumva de undeva
            stari[q].urmatoare.push_back(make_pair(next_q, make_pair(litera_input,litera_output)));
        }
    }

}

void print_mealy()
{
    for (auto stare : stari) {
        cout << "Stare: " << stare.first << endl;
        for (auto next : stare.second.urmatoare)
            cout << "--" << next.second.first << "/" << next.second.second <<  "--> " << next.first << endl;
    }
}

string output_cuvant(string cuvant)
{
    string output;
    string stare_curenta = "q0";
    for (int i=0; i<cuvant.length(); i++)
    {
        for(auto stare_urmatoare : stari[stare_curenta].urmatoare)
        {
            if(stare_urmatoare.second.first==cuvant[i]){
                stare_curenta=stare_urmatoare.first;
                output += stare_urmatoare.second.second;
                if(i==cuvant.length()-1){
                    return output;
                }
                else goto se_continua;
            }
        }
        cerr<< "cuvant invalid\n";
        throw 1;
        se_continua: //am realizat ca nu exista for else in cpp da e cam tarziu
        continue;
    }
    return output;
}

int main()
{
    ifstream fin("c1_ex1.in");
    fa_mealy(fin);
    //print_mealy();
    string cuvant;
    cout<<"cuvant:", cin>>cuvant;
    cout << "output "<< output_cuvant(cuvant) << endl;
    return 0;
}
