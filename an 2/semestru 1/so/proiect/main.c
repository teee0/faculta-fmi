#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <semaphore.h>
#include <pthread.h>
#include <time.h>

#define loop(i, n) for(int i = 0; i < n; i++)

// valori arbitrare și schimbabile
// timpul e măsurat în secunde
#define TIMP_MAXIM_CONSULT 6
#define NR_DOCTORI 4
#define NR_PACIENTI 20
#define DECALAJ_VENIRE_PACIENTI 0

pthread_t pacienti[NR_PACIENTI];

typedef struct {
    int id;
    pthread_mutex_t mutex;
} Doctor;

typedef struct { //wrapper pt semafor
    Doctor doctori[NR_DOCTORI];
    sem_t semafor_intern;
} Cabinet;

Cabinet cabinet;

void deschide_cabinet()
{
    sem_init(& (cabinet.semafor_intern), 1, NR_DOCTORI);
    loop(i, NR_DOCTORI) {
        cabinet.doctori[i].id=i;
        pthread_mutex_init(&(cabinet.doctori[i].mutex), NULL);
    }
}
void inchide_cabinet(){
    //se așteaptă ca toate threadurile să-și fi terminat execuția
    loop(i,NR_PACIENTI) pthread_join(pacienti[i],NULL);
    //dezalocare propriu-zisă
    sem_destroy(&(cabinet.semafor_intern));
    loop(i, NR_DOCTORI) pthread_mutex_destroy(&cabinet.doctori[i].mutex);
}
void asteapta(){
    sem_wait(&cabinet.semafor_intern);
}
void pleaca(){
    sem_post(&cabinet.semafor_intern);
}


void* f_pacient(void*) 
{
    //pacientul așteaptă
    int t = time(NULL);
    asteapta();
    int cat_a_asteptat = difftime (time(NULL), t);
    //pacientul a fost anunțat că (cel puțin) un doctor e liber

    //căutarea și blocarea doctorului liber
    Doctor* doctor;
    loop(i, NR_DOCTORI) {
        if (pthread_mutex_trylock(&cabinet.doctori[i].mutex) == 0 ) {
            doctor = &cabinet.doctori[i];
            //printf("Doctorul %d e ocupat.\n", doctor->id)
            break;
        }
    }
    //simularea consultării
    int cat_ia_consultul = 1 + rand() % TIMP_MAXIM_CONSULT;
    sleep(cat_ia_consultul);

    //eliberare doctor și afișare
    pleaca();
    pthread_mutex_unlock(&(doctor->mutex));
    printf("Pacientul a plecat de la doctorul %d. A așteptat ~ %d sec. A fost consultat %d sec.\n",
            doctor->id, cat_a_asteptat, cat_ia_consultul);
    return NULL;
}

void gestioneaza_pacienti() 
{ 
    loop(i,NR_PACIENTI) {
        pthread_create(&pacienti[i], NULL, f_pacient, NULL );
        
        sleep(rand() % (DECALAJ_VENIRE_PACIENTI +1)); //da sleep numai programului principal, care se ocupa cu generarea pacientilor
    }
}



int main()
{
    srand(time(NULL));
    deschide_cabinet();

    gestioneaza_pacienti();

    inchide_cabinet();
    return 0;
}