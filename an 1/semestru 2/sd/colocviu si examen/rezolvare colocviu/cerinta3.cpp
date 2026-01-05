#include <iostream>
#include <string>
#include <unordered_map>

using namespace std;

unordered_map <string, unordered_map<string, int>> depozit;

void add(string n, string t, int q)
{
    for(auto& [tip, comp_si_nr] : depozit)
    {
        if (comp_si_nr.find(n) != comp_si_nr.end()) 
        {
            if(tip!= t) //verificare daca exista deja un tip diferit
            {
                cout << "INVALID\n";
                return;
            }
        }
    }
    //adaugare in depozit sau crestere cantitate


    if(depozit.find(t) == depozit.end()) //daca tipul nu exista
    {
       depozit[t] = {{n, q}};  
    }
    
    else 
    {    
        if(depozit[t].find(n) != depozit[t].end()) 
        {
            depozit[t][n] += q;
        }
        else depozit[t][n] = q;
    }
    
     
}

int main()
{
    int nr_comenzi; cin >> nr_comenzi;

    for (int i=0; i<nr_comenzi; i++)
    {
        string comanda; cin >> comanda;

        if(comanda=="ADD") //adaugare
        {
            string n,t;
            int q;
            cin >> n >> t >> q;
            //verificare validitate
            add(n,t,q);
        }
        if(comanda=="REMOVE")
        {
            string n;
            int q;
            cin >> n >> q;
            for(auto& [tip, comp_si_nr] : depozit)
            {
                if (comp_si_nr.find(n) != comp_si_nr.end()) 
                {
                    comp_si_nr[n] -= q;
                    if(comp_si_nr[n] <= 0)
                        comp_si_nr.erase(n);
                    break;
                }
            }
        }
        if(comanda == "CHECK")
        {
            string n; cin >>n;
            bool gasit=false;
            for(auto& [tip, comp_si_nr] : depozit)
            {
                if (comp_si_nr.find(n) != comp_si_nr.end()) 
                {
                    cout << tip <<"\n";
                    gasit=true;
                    break;
                }
            }
            if(!gasit) cout<< "NU\n";
        }
        if(comanda == "COUNT")
        {
            string t; cin >> t;
            int suma=0;

            for(auto& [n, q] : depozit[t])
            {
                suma += q;
            }
            cout << suma << "\n";
        }

    }

    return 0;
}