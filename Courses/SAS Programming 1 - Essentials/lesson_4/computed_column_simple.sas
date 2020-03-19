data storm_length;
    set pg1.storm_summary;
    drop Hem_EW Hem_NS lat lon;
    StormLength = EndDate-StartDate;
run;