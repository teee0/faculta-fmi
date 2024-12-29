#ifndef ADD_H
#define ADD_H

#include "variabile.h"
#include <iostream>
#include <utility>
#include <cstdio>
#include "get.h"
//get.h temporar
using std::pair;

pair<int,int> add_intern(int descriptor, int dimensiune);//n + pe urmatoarele 2N linii veti primi, succesiv,
        //descriptorul de fisier, respectiv dimensiunea in kB
void add();

#endif // ADD_H
