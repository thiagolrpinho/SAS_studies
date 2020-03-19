proc sort data=pg1.eu_occ(keep=geo country) out=countryList 
        nodupkey;
    by Geo Country;
run;

proc sort data=pg1.np_largeparks
        out=park_clean
        dupout=park_dups
        noduprecs;
    by _all_;
run;