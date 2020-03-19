proc import datafile="&path/arquivo_csv.csv"
    dbms=csv out='datatable_csv' replace;
run;

/* This one is used to choose arbitrary delimiters */
proc import datafile="&path//np_traffic.dat"
            dbms=dlm
            out=traffic2
            replace;
    guessingrows=3000;
    delimiter="|";
run;