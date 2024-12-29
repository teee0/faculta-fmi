#ifndef GET_H
#define GET_H

#include "variabile.h"
#include <utility>
#include <iostream>
#include <cstdio>

using std::pair;
using std::make_pair;

pair<int,int> get_intern (int descriptor, int& ret_linie);

pair<int,int> get_intern_linie (int descriptor, int linie);

pair<int,int> get0_linie (int descriptor, int linie);

void get();


#endif // GET_H
