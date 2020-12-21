#include <stdio.h>
#include <stdlib.h>

typedef struct STAMMBAUM{
char person_Name_Vorname[60];
char person_Geschlecht[1];
char person_Geburstdatum[8];
char person_Todestag[8];

struct STAMMBAUM* pnextStammbaum;
}STAMMBAUM;


