#include <iostream>
#include <vector>
#include <fstream>

using namespace std;

int mat[100][100];

void dfs(int l, int x, vector<vector<pair<int,int>>> &e, bool viz[100]){
    viz[x] = true;
    for(auto &p: e[x]){
        if(!viz[p.second]){
            mat[l][p.second] = max(mat[l][x], p.first); //inainte de apelul recursiv, nu dupa
            dfs(l, p.second, e, viz);

        }
    }
}

int main(){

    ifstream fin("in.txt");
    vector<vector<pair<int,int>>> e;
    int a,b,cost;
    int n;

    fin >> n;

    e.resize(n+1);

    while(fin >> a){
        fin >> b;
        fin >> cost;

        e[a].push_back({cost,b});
        e[b].push_back({cost,a});
    }

    //vector<vector<int>> mat;


    for(int i = 1; i <= n; i++){
        bool viz[100] = {0};
        dfs(i,i,e,viz);
    }

    for(int i = 1; i <= n; i++){
        for(int j = 1; j <= n; j++){
            cout << mat[i][j] << " ";
        }
        cout << endl;
    }


    return 0;
}
