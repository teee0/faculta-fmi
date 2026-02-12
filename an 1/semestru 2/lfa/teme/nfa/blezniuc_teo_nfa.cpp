#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <map>
#include <sstream>
#include <utility>
using namespace std;
//g++ -std=c++20 blezniuc_teo_nfa.cpp

struct Stare
{
    vector<pair<string,char>> urmatoare;
            //urmatoarea stare, litera din tranzitie
    bool efinala;
};
map<string, Stare> stari;


/*bool tranz(stare* s)
{
    string cuvant_posibil="";
    for(auto next: s->urmatoare)
    {
        cuvant_posibil+=next.second;
        if(next.first->efinala)
        {
            cout<<cuvant_posibil;
            return true;
        }
        tranz(next.first);
    }

    }*/

void fa_nfa(ifstream& fin)
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


            getline(ss, next_q, ';');
            if(ss.peek()==' ') ss.ignore(1);
            next_q=next_q.substr(1);//pt ca ramanea spatiu in fata cumva de undeva
            stringstream s3(next_q);
            while(getline(s3, next_q, ','))
            {
                if(next_q[0]==' ') next_q=next_q.substr(1);
                stari[q].urmatoare.push_back(make_pair(next_q, litera));
                stari[q].efinala = false;
            }
        }
    }

    stringstream sf(stari_finale);
    for (string s; sf>>s ;)
        stari[s].efinala = true;
}
void print_nfa()
{
    for (auto stare : stari) {
        cout << "Stare: " << stare.first <<(stare.second.efinala?" finala":"") << endl;
        for (auto next : stare.second.urmatoare)
            cout << "--" << next.second << "--> " << next.first << endl;
    }
}

bool validare_cuvant(const string& cuvant)
{
    vector<string> stari_curente = {"q0"};

    for (char litera : cuvant) {
        vector<string> stari_urmatoare;

        for (auto stare_curenta : stari_curente) {
            for (auto stare_urmatoare : stari[stare_curenta].urmatoare) {
                if (stare_urmatoare.second == litera) {
                    stari_urmatoare.push_back(stare_urmatoare.first);
                }
            }
        }

        if (stari_urmatoare.empty()) {
            return false;
        }

        stari_curente = stari_urmatoare;
    }

    for (auto stare_curenta : stari_curente) {
        if (stari[stare_curenta].efinala) {
            return true;
        }
    }

    return false;
}
int main()
{
    ifstream fin("blezniuc_teo_nfa.in");
    fa_nfa(fin);
    print_nfa();
    string cuvant;
    cout<<"cuvant:", cin>>cuvant;
    cout << "Cuvant "<< (validare_cuvant(cuvant)?"acceptat":"neacceptat")<<"!"<<endl;
    return 0;
}
