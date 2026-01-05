#include <iostream>
#include <fstream>
#include <string>
#include <vector>
#include <map>
#include <sstream>
#include <utility>

using namespace std;

//dau outputu per stare separat in exemplu ca ar fii prea complicat sa fie pe ambele parti

struct Stare
{
    vector<pair<string, char> > urmatoare;
            //urmatoarea stare, litera_input din tranzitie, litera_output
    char litera_output;
};

map<string, Stare> stari;

void print_moore()
{
    for (auto stare : stari) {
        cout << "Stare: " << stare.first << "/" << stare.second.litera_output << endl;
        for (auto next : stare.second.urmatoare)
            cout << "--" << next.second <<  "--> " << next.first << endl;
    }
}

void fa_moore(ifstream& fin)
{
    //cititre output per stare
    string stari_toate,           output_toate;
    getline (fin, stari_toate);   getline (fin, output_toate);
    stringstream st(stari_toate), ot(output_toate);
    string s_temp;                char o_temp;
    while(st>>s_temp)
    {
        ot>>o_temp;
        stari[s_temp].litera_output = o_temp;
    }


    string line;
    while (getline(fin, line)) 
    {
        string q, next_q;
        char litera_input, litera_output;

        stringstream ss(line);
        if(line!="") while (ss)
        {
            getline(ss, q, ' ');

            ss.ignore(2);
            ss >> litera_input;
            ss.ignore(3);

            getline(ss, next_q, ',');
            if(ss.peek()==' ') ss.ignore(1);
            next_q=next_q.substr(1);//pt ca ramanea spatiu in fata cumva de undeva
            stari[q].urmatoare.push_back(make_pair(next_q, litera_input));
            print_moore();
        }
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
            if(stare_urmatoare.second==cuvant[i]){
                output+=stari[stare_urmatoare.first].litera_output;
                stare_curenta=stare_urmatoare.first;
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
    ifstream fin("c2_ex1.in");
    fa_moore(fin);
    print_moore();
    string cuvant;
    cout<<"cuvant:", cin>>cuvant;
    cout << "output "<< output_cuvant(cuvant) << endl;
    return 0;
}
