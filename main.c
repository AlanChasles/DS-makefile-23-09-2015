#include "journal.h"
#include <time.h>
int main(){
ouvrir_journal(4,"journal.log",NULL,1);



JOURNAL(4,"un message de DEBUG");
sleep(1);
JOURNAL(3,"une INFO 1 seconde plus tard");
sleep(2);
JOURNAL(2,"un WARNING 2 secondes plus tard");
sleep(3);
JOURNAL(1,"une ERROR 3 secondes plus tard");
sleep(4);
JOURNAL(4,"un DEBUG 4 secondes plus tard");





return 0;
}
