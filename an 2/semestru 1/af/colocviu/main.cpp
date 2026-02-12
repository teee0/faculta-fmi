#include <iostream>
#include <fstream>
#include <vector>
#include <queue>
#include <utility>
using namespace std;

#define pq priority_queue<int,vector<int>,greater<int>>

vector<vector<int> > adiacente;
queue<int> q;
vector<bool> vizitat;
vector<pq > noduri;

int nr_componente = 0;

void viziteaza(int nod)
{
    vizitat[nod] = true;
    q.push(nod);
    noduri[nr_componente].push(nod);
}

void print(vector<pq> nr)
{
    for(pq& x:nr) cout << x.top() << " ";
}
long long calc()
{
    int min = noduri[0].top();
    for(pq& x:noduri) 
    {
        if(min > x.top())
            min = x.top();
    }
    long long rez = (long long)min * (long long)(nr_componente-2);
    for(pq& x:noduri) 
    {
        rez+=x.top();
    }
    
   return rez;
}

void bfs(int prim_nod)
{
    viziteaza(prim_nod);
    
    while (!q.empty())
    {
        int nod = q.front();
        q.pop();
    
        for (int vecin : adiacente[nod])
        {
            if(vizitat[vecin]==false)
                viziteaza(vecin);
        }

    }
}

void bfs_mare(int nr_noduri)
{
    for (int i=1; i<=nr_noduri; i++){
        if (vizitat[i]==false) 
        {
            noduri.push_back(pq());
            bfs(i);
            nr_componente++;
        }
    }
}

int main()

{
    int n, m;
    cin >> n >> m;
    //if(m<=0) {cout<<0;return 0;}
    adiacente.resize(n+1);
    vizitat.resize(n+1);
    
    int a,b;
    for(int i=0; i<m; i++)
    {
        cin >> a >> b;
        adiacente[a].push_back(b);
        adiacente[b].push_back(a);
    }

    bfs_mare(n);

    cout<<(long long)calc();
    //cout<<(long long)100000*100000;
    //print(noduri);


}