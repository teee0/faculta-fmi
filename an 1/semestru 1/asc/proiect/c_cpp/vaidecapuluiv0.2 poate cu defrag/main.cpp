#include <iostream>
#include "add.h"
#include "get.h"
#include "del.h"
#include "defrag.h"
#include "variabile.h"
int nr_op=0;

enum t_op { t_add=1,t_get,t_del,t_defrag };

int v[1024][1024];

int main()
{
  nr_op=input("Numărul de operații: ");
  for (int i=0; i < nr_op; i++)
  {
    int t;
    t=input("Tipul operației: ");
    switch(t){
        case t_add: add(); break;
        case t_get: get(); break;
        case t_del: del(); break;
        case t_defrag: defrag(); break;
    }
  }

  return 0;
}
