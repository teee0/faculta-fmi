#include <iostream>
#include <map>
#include<unordered_map>
using namespace std;



class Ruta
{
    string _plecare, _sosire;
public:
    string plecare() const {return _plecare;}
    string sosire()  const {return _sosire;}
    Ruta(string p,string s) : _plecare(p), _sosire(s) {}
    friend bool operator<(const Ruta& r1, const Ruta& r2){return r1.plecare()<r2.plecare();}
    friend ostream& operator<< (ostream& out, const Ruta& r)
    {
        out<<r._plecare<<" - "<<r._sosire;
        return out;
    }
};

class Cursa
{
private:
    Ruta ruta;
    string data_inceput;
public:
};

class Cursa_temp: public Cursa
{
private:
    int disponibilitate;
public:

};

class Zbor
{
private:
    string id;
    Ruta* ruta;
    string ora_plecare, ora_sosire;
public:

};

class Aplicatie
{
private:
    map<Ruta,string> mersul_avioanelor = {
        { {"Iași",         "Bacău"}, "a" },
        { {"Paris, Texas", "Paris"}, "b" },
        { {"Bacău",        "Paris"}, "c" }
    };
public:
    void afisare_rute() const;
};

void Aplicatie::afisare_rute() const
{
    for(auto & ruta: mersul_avioanelor) cout<<ruta.first <<endl;
}

int main()
{
    Aplicatie aplicatie;
    aplicatie.afisare_rute();

    return 0;
}
