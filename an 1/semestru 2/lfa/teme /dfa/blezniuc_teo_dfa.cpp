#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <map>
#include <sstream>
#include <utility>
using namespace std;
//g++ -std=c++20 blezniuc_teo_dfa.cpp

struct Stare
{
    vector<pair<string,char>> urmatoare;
            //urmatoarea stare, litera din tranzitie
    bool efinala;
};
map<string, Stare> stari;


void fa_dfa(ifstream& fin)
{
    string stari_finale;
    //pe prima linie sunt stările finale
    getline(fin, stari_finale);

    string line;
    while (getline(fin, line)) {
    string q, next_q;
    char litera;

    stringstream ss(line);
        while (ss)
        {
            getline(ss, q, ' ');

            ss.ignore(2);
            ss >> litera;
            ss.ignore(3);


            getline(ss, next_q, ',');
            if(ss.peek()==' ') ss.ignore(1);
            next_q=next_q.substr(1);//pt ca ramanea spatiu in fata cumva de undeva
            stari[q].urmatoare.push_back(make_pair(next_q, litera));
            stari[q].efinala = false;
        }
    }

    stringstream sf(stari_finale);
    for (string s; sf>>s ;)
        stari[s].efinala = true;
}
void print_dfa()
{
    for (auto stare : stari) {
        cout << "Stare: " << stare.first <<(stare.second.efinala?" finala":"") << endl;
        for (auto next : stare.second.urmatoare)
            cout << "--" << next.second << "--> " << next.first << endl;
    }
}
bool validare_cuvant(string cuvant)
{
    string stare_curenta = "q0";
    for (int i=0; i<cuvant.length(); i++)
    {
        for(auto stare_urmatoare :stari[stare_curenta].urmatoare)
        {
            if(stare_urmatoare.second==cuvant[i]){
                stare_curenta=stare_urmatoare.first;
                if(i==cuvant.length()-1){
                    return stari[stare_curenta].efinala;
                }
                else goto se_continua;
            }
        }
        return false;
        se_continua: //am realizat ca nu exista for else in cpp da e cam tarziu
        continue;
    }
    return true;
}
int main()
{
    ifstream fin("blezniuc_teo_dfa.in");
    fa_dfa(fin);
    print_dfa();
    string cuvant;
    cout<<"cuvant:", cin>>cuvant;
    cout << "Cuvant "<< (validare_cuvant(cuvant)?"acceptat":"neacceptat")<<"!"<<endl;
    return 0;
}
