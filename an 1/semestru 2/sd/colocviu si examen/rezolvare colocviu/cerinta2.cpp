#include <iostream>
#include <set>

using namespace std;

int main()
{
    set <int> s;

    int nr_instructiuni; cin >> nr_instructiuni;

    for (int i=0; i<nr_instructiuni; i++)
    {
        int comanda; cin >> comanda;
        int cristal; 
        switch(comanda)
        {

            case 0: //adaugare
                cin >> cristal;
                s.insert(cristal);
                break;
            case 1: //verificarea existenta
                cin >> cristal;
                cout<<((s.find(cristal)!=s.end())? "DA\n" : "NU\n");
                break;
            case 2: //afisare
                for (auto c: s) cout<<c<<" ";
                cout<<"\n";
                break;
        }

    }

    return 0;
}