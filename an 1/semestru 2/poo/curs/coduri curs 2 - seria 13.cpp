#include <iostream>

using namespace std;

class serie
{
    int nr;
public:
    serie(int x) : nr(x){cout<<"constructor "<<nr<<'\n';}
    ~serie(){cout<<"destructor "<<nr<<'\n';}
    void afisare(){cout<<nr<<'\n';}
};

class student{};

int main()
{
    serie A(13); /// se apeleaza automat contr si, la final, destructor
    serie* p;
    p = new serie(14);
    student* q;
    /// q = p;
    q = (student*)p;
    /// q = &A;
    q = (student*)&A;
    delete p;
}

/**** referinta ca data membra intr-o clasa ****/
/*
class serie
{
    int& nr;
    int aaa;
public:
///    serie(int x){nr = x; aaa = 67;}
    serie(int x) : nr(x), aaa(67){} /// lista de initializare a constructorilor
    void afisare(){cout<<nr<<'\n';}
};

int main()
{
    int x = 9;
    int y(10);
    serie A(13);
    A.afisare();
    serie B(14);
    B.afisare();
    A.afisare(); /// atentie la nr, acum are 14
}
*/
/***** curatenie *****/
/*
int x = 166;

void f(int x)
{
cout<<"x preluat / copiat din main: "<<x<<'\n';
    x = x + 425;
cout<<"x modificat in functie: "<<x<<'\n';
    ::x = x + 789;
cout<<"x global modificat in functie: "<<::x<<'\n';
}

int main()
{
    cout<<"x global (inaintea <aparitiei> x din main): "<<x<<'\n';
    int x = 20;
    cout<<"x din main: "<<x<<'\n';
    f(x);
    cout<<"x din main dupa apel de functie: "<<x<<'\n';  /// atentie, depinde daca e transmis in functie prin valoare sau prin referinta
    cout<<"x global dupa apel de functie: "<<::x<<'\n';
    ::x += 2000;
    cout<<"x global dupa modificare in main: "<<::x<<'\n';
}
*/

/*
int x = 166;

void f(int& x)
{
///    cout<<&x<<endl; /// adresa variabilei x
    x = ::x + 425;
cout<<"in functie: "<<x<<'\n';
    ::x = x + 789;
cout<<::x;
}
int main()
{
    cout<<x<<endl;
    int x = 20;
    cout<<x<<endl;
///    cout<<&x<<endl;
    f(x);
    cout<<"in main "<<x;
}
*/

/*
class serie
{
    int nr;
public:
    serie();
    serie(int);
    void citire(); ///declarare
    void afisare(){ cout<<nr<<'\n';} ///declarae + definire ===> implicit inline
};

int main()
{
    serie A(13);
    A.afisare();
}

serie::serie(){nr = 1234;}
serie::serie(int nr){this->nr = nr;}
void serie::citire(){ cin>>this->nr;} ///definire
*/

/*
class serie
{
    int nr;
public:
    serie(){nr = 1234;}
    serie(int nr){this->nr = nr;}
///    serie(int nr = 1000){nr = nr;}
///    void citire(){ cin>>nr;}
    void citire(){ cin>>this->nr;}
    void afisare(){ cout<<nr<<'\n';}
};

int main()
{
    serie A;
///    citire(A);
///    afisare(A);
///    A.citire();
    A.afisare();
    serie B(13);
    B.afisare();
 ///   serie *p = new serie;
}

/// void citire(serie& ob){ cin>>ob.nr;}  /// nr e inaccesibil
/// void afisare(serie ob){ cout<<ob.nr<<'\n';}
*/

/*
int main()
{
///    cout<<"Hello world!";
    operator<<(cout,"Hello world!");
    serie A;
    serie B;
///    B = A;
    B.operator=(A);
    return 0;
}
*/
