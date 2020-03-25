proc sort data=pg2.np_acres 
          out=sortedAcres(keep=Region ParkName State GrossAcres);
    by Region ParkName;
run;
	
data multiState singleState;
    set sortedAcres;
    by Region ParkName;
    if First.ParkName=1 and Last.ParkName=1 
        then output singleState;
    else output multiState;
    format GrossAcres comma15.;
run;