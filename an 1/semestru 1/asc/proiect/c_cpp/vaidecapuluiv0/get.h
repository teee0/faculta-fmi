#ifndef GET_H
#define GET_H

#include "variabile.h"
#include <utility>
#include <iostream>
#include <cstdio>

using std::pair;
using std::make_pair;

pair<int,int> get_intern(int descriptor);
void get();
pair<int,int> get0(int minim=0);//returneaza intervalu in care se gaseste prima secventa de 0 de lungime minima data

#endif // GET_H
