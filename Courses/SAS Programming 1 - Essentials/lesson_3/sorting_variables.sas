proc sort data=pg1.storm_summary out=storm_sort;
    where Basin in("NA" "na");
    by descending MaxWindMPH;
run; 