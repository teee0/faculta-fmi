#ifndef _CLASE
#define _CLASE
#include <vector>
#include <iostream>
#include <sstream>
#include <string>
using namespace std;

class Drum
{
    protected:
    string nume;
    int lungime;
    int nr_tronsoane;
    vector<bool> tronsoane_contractate;

    public:
    Drum(string nume, int lungime, int nr_tronsoane)
    : nume(nume), lungime(lungime), nr_tronsoane(nr_tronsoane), tronsoane_contractate(nr_tronsoane)
    { }
    virtual ~Drum(){}

    virtual void citire(istream& in)
    {
        in>>nume>>lungime>>nr_tronsoane;
        tronsoane_contractate.resize(nr_tronsoane);
    }
    friend istream& operator>> (istream& in, Drum& ob)
    {
        ob.citire(in);
        return in;
    }
    virtual void afisare(ostream& out)
    {
        out<<nume<<" lungime: "<<lungime<<" nr. tronsoane: "<<nr_tronsoane;
    }
    friend ostream& operator<< (ostream& out, Drum& ob)
    {
        ob.afisare(out);
        return out;
    }
};

class DrumNational : public Drum
{
    private:
    int nr_judete_traversate;
    public:
    DrumNational(string nume, int lungime, int nr_tronsoane, int nr_judete_traversate)
        : Drum(nume, lungime, nr_tronsoane), nr_judete_traversate(nr_judete_traversate)
    { }
    void citire(istream& in)
    {
        Drum::citire(in);
        in>>nr_judete_traversate;
    }
    void afisare(ostream& out)
    {
        Drum::afisare(out);
        out<<" nr. județe traversate: "<<nr_judete_traversate;
    }
};

class DrumEuropean : virtual public Drum
{
    protected:
    int nr_tari_traversate;
    public:
    DrumEuropean(string nume, int lungime, int nr_tronsoane, int nr_tari_traversate)
        : Drum(nume, lungime, nr_tronsoane), nr_tari_traversate(nr_tari_traversate)
    { }
    void citire(istream& in)
    {
        Drum::citire(in);
        in>>nr_tari_traversate;
    }
    void afisare(ostream& out)
    {
        Drum::afisare(out);
        out<<" nr. țări traversate: "<<nr_tari_traversate;
    }
};

class Autostrada : virtual public Drum
{
    protected:
    int nr_benzi;
    public:
    Autostrada(string nume, int lungime, int nr_tronsoane, int nr_benzi)
        : Drum(nume, lungime, nr_tronsoane), nr_benzi(nr_benzi)
    { }
    void citire(istream& in)
    {
        Drum::citire(in);
        in>>nr_benzi;
    }
    void afisare(ostream& out)
    {
        Drum::afisare(out);
        out<<" nr. benzi: "<<nr_benzi;
    }
};

class AutostradaEuropeana: public Autostrada, public DrumEuropean
{
    private:
    public:
    AutostradaEuropeana(string nume, int lungime, int nr_tronsoane, int nr_benzi, int nr_tari_traversate)
        : Drum(nume, lungime, nr_tronsoane),
          Autostrada(nume, lungime, nr_tronsoane, nr_benzi),
          DrumEuropean(nume, lungime, nr_tronsoane, nr_tari_traversate)
    { 
        this->nr_tari_traversate=nr_tari_traversate;
        this->nr_benzi = nr_benzi;
        this->nr_tari_traversate = nr_tari_traversate;
    }
    void citire(istream& in)
    {
        Autostrada::citire(in);
        in>>nr_tari_traversate;
    }
    void afisare(ostream& out)
    {
        Drum::afisare(out);
        out<<" nr. benzi: "<<nr_benzi<<" nr. țări traversate: "<< nr_tari_traversate;
    }
};

class Contract
{
    private:
    static int contor;
    int id;
    Drum* drum;
    int id_tronson;// de la 0 la nr_tronsoane-1
    string nume_firma, cif;
    public:
    Contract(Drum* drum, int id_tronson, string nume_firma, string cif)
            : drum(drum), id_tronson(id_tronson), nume_firma(nume_firma), cif(cif)
    {
        id = contor;
        contor++;
    }
};
int Contract::contor = 0;

void afisare_drumuri(vector<Drum*>& drumuri);
void citire_drumuri(istream& in, vector<Drum*>& drumuri);
void afisare_contracte(vector<Contract*>& contracte);

#endif
