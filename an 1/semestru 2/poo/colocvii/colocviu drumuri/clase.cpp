#include "clase.h"

void afisare_drumuri(vector<Drum*>& drumuri)
{
    for(auto drum: drumuri)
    {
        drum->afisare(cout);
        cout<<endl;
    }
}

void citire_drumuri(istream& in, vector<Drum*>& drumuri)
{
    for(string linie; getline(in, linie); )
    {
        stringstream s(linie);
        string tip, nume;
        int               lungime, nr_tronsoane, extra;
        s >> tip >> nume >> lungime >> nr_tronsoane;
        if(tip!="0") s >> extra;

        Drum* drum;

        if     (tip == "n")  drum = new DrumNational       (nume, lungime, nr_tronsoane, extra);
        else if(tip == "e")  drum = new DrumEuropean       (nume, lungime, nr_tronsoane, extra);
        else if(tip == "a")  drum = new Autostrada         (nume, lungime, nr_tronsoane, extra);
        else if(tip == "ae") {
            int nr_tari_traversate; s>>nr_tari_traversate;
            drum = new AutostradaEuropeana(nume, lungime, nr_tronsoane, extra, nr_tari_traversate);
        }
        else if(tip == "0")  drum = new Drum               (nume, lungime, nr_tronsoane);
        else throw 1;

        drumuri.push_back(drum);
    }
}

void afisare_contracte(vector<Contract*> contracte)
{

}