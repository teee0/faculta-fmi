#include <fstream>
#include<vector>
using namespace std;

ifstream fin("disjoint.in");
ofstream fout("disjoint.out");

int N, Comp, Nop, Max = 1;
vector<int> tata;
vector<int> s;

int Find(int node){
    if(tata[node]==0)
        return node;

    tata[node]=Find(tata[node]);

    return tata[node];
}

void Union(int x, int y){
    int radX=Find(x);
    int radY=Find(y);

    // daca sunt in aceeasi multime
    if(radX == radY)
        return;

    if(s[radX] < s[radY]){
        s[radY] += s[radX];
        tata[radX]=radY;
    }
    else if(s[radX] > s[radY]){
        s[radX] += s[radY];
        tata[radY]=radX;
    }
    else{
        s[radX] += s[radY];
        tata[radY]=radX;
    }

    Max = max(Max, max(s[radY], s[radX]));
}



int main(){
    fin >> N >> Comp;
    tata.assign(N+1, 0);
    s.assign(N+1, 1);

    for (int i = 0; i < Comp; i++)
    {
        int sizeComp; fin >> sizeComp;

        int x; fin >> x;
        for (int j = 1; j < sizeComp; j++) {
            int y; fin >> y;
            Union(x, y);
        }

    }

    fin >> Nop;

    for (int op = 0; op < Nop; op++) {
        int x, y; fin >> x >> y;

        if (Find(x) != Find(y)){
            Comp--;
            Union(x, y);
        }

        fout << "(" << x << "," << y << ")\n";
        fout << "Size Maxim: " << Max << "\n";
        fout << "Componente ramase: " << Comp << "\n";
        fout << "\n";
    }

    return 0;
}
