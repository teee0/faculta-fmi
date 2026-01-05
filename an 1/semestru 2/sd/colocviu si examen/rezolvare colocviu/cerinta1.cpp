#include <iostream>
#include <set>

using namespace std;

int main()
{
    set <int> s;

    int n, k;
    cin >> n >> k;

    for (int i=0; i<n; i++)
    {
        int mostra; cin >> mostra;
        s.insert(mostra);
        if(s.size() > k) 
            s.erase(s.begin());//eliminarea imediata a celui mai mic element
    }

    for (auto x : s) //afisarea in oridine crescatoare
        cout<<x<<" ";

    return 0;
}