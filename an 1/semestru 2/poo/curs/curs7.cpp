#include <iostream>
#include <memory>
#include <vector>

using namespace std;

/***** smart pointers *****/

class Persoana
{
protected:
    string nume;
public:
    Persoana(string s = "") : nume(s){}
    virtual void citire();
    virtual void afisare();
    virtual ~Persoana(){}
};

class Elev : public Persoana
{
    int clasa;
public:
    Elev(string s="", int c=0):Persoana(s),clasa(c){}
    void citire();
    void afisare();
    ~Elev(){}
};

int main()
{
    /*
    Persoana* p = new Elev();
    p->citire();
    p->afisare();
    delete p;

    shared_ptr<Persoana> p2 = make_shared<Persoana>("AAA");
    p2->afisare();

    p2 = make_shared<Elev>("BBB",5); /// upcasting
    p2->afisare();
    */
/*
    vector<Persoana*> v;
    v.push_back(new Persoana());
    v.back()->citire();
    v.push_back(new Elev());
    v.back()->citire();

    for(auto p = v.begin(); p != v.end(); p++)
        (*p)->afisare();
*/
    vector<shared_ptr<Persoana>> v2;
    v2.push_back(make_shared<Persoana>());
    v2.back()->citire();
    v2.push_back(make_shared<Elev>());
    v2.back()->citire();

    for(auto p = v2.begin(); p != v2.end(); p++)
        (*p)->afisare();
    return 0;
}

void Persoana::citire(){cout<<"Nume "; cin>>nume;}
void Persoana::afisare(){cout<<nume<<" ";}
void Elev::citire(){Persoana::citire(); cout<<"Clasa "; cin>>clasa;}
void Elev::afisare(){Persoana::afisare(); cout<<clasa<<"\n";}

/***** destructori virtuali *****/
/*
class Persoana
{
protected:
    string nume;
public:
    Persoana(string s = "") : nume(s){cout<<"constr Persoana ";}
    virtual void citire();
    virtual void afisare();
    virtual ~Persoana(){cout<<"destr Persoana";}
};

class Elev : public Persoana
{
    int clasa;
public:
    Elev(string s="", int c=0):Persoana(s),clasa(c){cout<<" constr Elev";}
    void citire();
    void afisare();
    ~Elev(){cout<<" destr Elev";}
};

int main()
{
    Persoana* p = new Elev(); /// upcast
    delete p;
    return 0;
}

void Persoana::citire(){cout<<"Nume "; cin>>nume;}
void Persoana::afisare(){cout<<nume<<" ";}
void Elev::citire(){Persoana::citire(); cout<<"Clasa "; cin>>clasa;}
void Elev::afisare(){Persoana::afisare(); cout<<clasa<<"\n";}
*/

/***** covariance exemplu *****/
/*
class Persoana
{
protected:
    string nume;
public:
    Persoana(string s = "") : nume(s){}
    virtual void citire();
    virtual void afisare();
    virtual Persoana* concatenare(){ return new Persoana(nume+="Popescu");}
};

class Elev : public Persoana
{
    int clasa;
public:
    Elev(string s="", int c=0):Persoana(s),clasa(c){}
    void citire();
    void afisare();
///    Persoana* concatenare(){ return new Elev(nume+="Popescu", clasa+=1);}
    Elev* concatenare(){ return new Elev(nume+="Popescu", clasa+=1);}   /// covarianta tipurilor
};

int main()
{
    Persoana *p = new Persoana("Ana");
    p->afisare();
    p = p->concatenare();
    p->afisare();
    cout<<"\n";
    p = new Elev("Ion",11);
    p->afisare();
    p = p->concatenare();
    p->afisare();

    Elev A("anonim",0);
    Elev *B = A.concatenare();
    B->afisare();
    return 0;
}

void Persoana::citire(){cout<<"Nume "; cin>>nume;}
void Persoana::afisare(){cout<<nume<<" ";}
void Elev::citire(){Persoana::citire(); cout<<"Clasa "; cin>>clasa;}
void Elev::afisare(){Persoana::afisare(); cout<<clasa<<"\n";}
*/

/**** clase abstracte ****/
/*
class Persoana /// clasa abstracta (are cel putin o functie virtuala pura) / interfata
{
protected:
    string nume;
public:
    virtual void citire() = 0; /// functie virtuala pura
    virtual void afisare();
};

class Elev : public Persoana
{
    int clasa;
public:
    void citire();
    void afisare();
};

class Pensionar : public Persoana
{
public:
    void citire(){}
};

int main()
{
///    Persoana ob;
    Elev ob1;
    Pensionar ob2;
///    cout << sizeof(Persoana) << endl; /// aparitia vptr daca virtual
    Persoana *p = new Elev();
    p->citire();
    p->afisare();
    return 0;
}

void Persoana::citire(){cout<<"Nume "; cin>>nume;}
void Persoana::afisare(){cout<<nume<<" ";}
void Elev::citire(){Persoana::citire(); cout<<"Clasa "; cin>>clasa;}
void Elev::afisare(){Persoana::afisare(); cout<<clasa<<"\n";}
*/
