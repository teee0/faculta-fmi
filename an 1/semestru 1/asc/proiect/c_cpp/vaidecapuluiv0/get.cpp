#include "get.h"

pair<int,int> get_intern(int descriptor)
{
    int start=0, end=0;

    bool gasit_start = false;// as in cel putin gasit nu neaparat mai si incape

    for(int i=0; i<= 1023; i++)
    {
        if(!gasit_start && v[i] == descriptor)
        {
            start = i;
            gasit_start=true;
        }

        if (gasit_start && v[i]==descriptor)
            end = i;
    }//vezi daca chiar trb sa returneze 0,1023

    return make_pair(start,end);
}

pair<int,int> get0(int minim)//pe linie
{
    int start=0, end=0;

    bool gasit_start = false;// as in cel putin gasit nu neaparat mai si incape

    for(int i=0; i<=1023; i++)
    {
        if(v[i]==0)
        {
            if(!gasit_start)
            {
                start = i;
                gasit_start=true;
            }
            end = i;
        }
        else
        {
            if (gasit_start)
            {
                if( minim <= end-start+1 )
                {
                    break;
                }
                else
                {
                    gasit_start = false;
                    start=0;
                    end=0;
                }
            }//ca sa mearga get_intern(0) ca e singuru necontiguu
        }


    }

    return make_pair(start,end);
}

void get()
{
    int descriptor= input("get: ");

    auto rez = get_intern(descriptor);

    printf("(%d, %d)\n",rez.first,rez.second);
}

