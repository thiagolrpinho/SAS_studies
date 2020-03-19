/* This access the xlsx file directly */
libname np xlsx "&path/np_info.xlsx"; 

options validvarname=v7;
proc contents data=np.parks;
run;

libname np clear;

/* This imports a single sheet from a xlsx file and creates a copy of it. */
proc import datafile="&path/eu_sport_trade.xlsx"
            dbms=xlsx
            out=eu_sport_trade
            replace;
run;