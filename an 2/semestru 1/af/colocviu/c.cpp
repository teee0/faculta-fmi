#include <iostream>
#include <fstream>
#include <vector>
#include <queue>
#include <utility>
using namespace std;


vector<vector<int> > adiacente, transpus;
queue<int> q;
vector<bool> vizitat;
vector<bool> viz2;
vector<vector<int> > noduri;

int nr_componente = 0;


//c new start

//c end


void viziteaza(int nod, vector<bool>& viz)
{
    viz[nod] = true;
    q.push(nod);
    if(nr_componente!=-1)
        noduri[nr_componente].push_back(nod);
}

void print(vector<vector<int>> nr)
{
    for(vector<int>& x:nr) {for(int& y:x) cout << y << " ";
        cout<<endl;
    }
}


void bfs(int prim_nod, vector<vector<int> >& v, vector<bool>&viz)
{
    viziteaza(prim_nod,viz);
    
    while (!q.empty())
    {
        int nod = q.front();
        q.pop();
    
        for (int vecin : v[nod])
        {
            if(viz[vecin]==false)
                viziteaza(vecin,viz);
        }

    }
}

void bfs_mare(int nr_noduri)
{
    for (int i=1; i<=nr_noduri; i++){
        //if (vizitat[i]==false) 
        {
            noduri.push_back(vector<int>());
            bfs(i,adiacente,vizitat);
            nr_componente++;
        }
    }
}

void bfs_mare2(int nr_noduri)
{
    nr_componente=-1;
    for (int i: noduri[0]){
        //if (viz2[i]==false) 
        {
            //noduri.push_back(vector<int>());
            bfs(i,transpus,viz2);
            
        }
    }
}


int main()

{
    int n, m;
    cin >> n >> m;
    //if(m<=0) {cout<<0;return 0;}
    adiacente.resize(n+1);
    transpus.resize(n+1);
    vizitat.resize(n+1);
    
    int a,b;
    for(int i=0; i<m; i++)
    {
        cin >> a >> b;
        adiacente[a].push_back(b);
        transpus[b].push_back(a);
    }

    bfs_mare(n);
    bfs_mare2(n);
    //cout<<(long long)calc();
    //cout<<(long long)100000*100000;
    print(noduri);


}
