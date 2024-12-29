#include "get.h"

pair<int,int> get_intern_linie(int descriptor,int linie)
{
    int start=0, end=0;

    bool gasit_start = false;

    for(int i=0; i<= 1023; i++)
    {
        if(!gasit_start && v[linie][i] == descriptor)//gresit (idk dc tf)
        {
            start = i;
            gasit_start=true;
        }

        if (gasit_start && v[linie][i]==descriptor)
            end = i;
        //if (end!=0 && v[linie][i]!=descriptor)break;//ca sa mearga get_intern(0) ca e singuru necontiguu
    }

    return make_pair(start,end);
}

pair<int,int> get_intern(int descriptor, int& ret_linie)
{
    for (ret_linie=0;ret_linie<=1023;ret_linie++)
    {
        auto rez = get_intern_linie(descriptor,ret_linie);
        if(rez.second != 0)
        {
            return rez;
        }
    }
    ret_linie=0;
    return make_pair(0,0);
}

pair<int,int> get0_linie(int minim, int linie)//pe linie
{
    int start=0, end=0;

    bool gasit_start = false;// as in cel putin gasit nu neaparat mai si incape

    for(int i=0; i<=1023; i++)
    {
        if(v[linie][i]==0)
        {
            if(!gasit_start)//gresit (idk dc tf)
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




    }//vezi daca chiar trb sa returneze 0,1023

    return make_pair(start,end);
}

void get()
{
    int descriptor = input("get: ");
    int linie_rez;
    auto rez = get_intern(descriptor,linie_rez);
    printf("((%d, %d), (%d, %d))\n",linie_rez,rez.first,linie_rez,rez.second);
}
