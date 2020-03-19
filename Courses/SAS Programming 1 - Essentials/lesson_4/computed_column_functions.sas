data storm_windavg;
    set pg1.storm_range;
    WindAvg=mean(wind1, wind2, wind3, wind4);
    WindRange=range(of wind1-wind4);
run;  

/* Note: you can use the shorthand notation OF col1 - coln to list a range of columns when the columns have the same name and end in a consecutive number. */

data pacific;
    set pg1.storm_summary;
    drop type Hem_EW Hem_NS MinPressure Lat Lon;
    where substr(Basin,2,1)="P";
run;

data np_summary2;
    set pg1.np_summary;
    ParkType=scan(parkname,-1);
    keep Reg Type ParkName ParkType;
run;

/* SCAN function is used to create a new column named ParkType that is the last word in the ParkName column.
    A negative number is used for the second argument to count words from right to left in the character string. */