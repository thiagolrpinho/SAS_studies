***********************************************************;
*  Activity 5.06                                          *;
*    1) Add options to include N (count), MEAN, and MIN   *;
*       statistics. Round each statistic to the nearest   *;
*       integer.                                          *;
*    2) Add a CLASS statement to group the data by Season *;
*       and Ocean. Run the program.                       *;
*    3) Modify the program to add the WAYS statement so   *;
*       that separate reports are created for Season and  *;
*       Ocean statistics. Run the program.                *;
*       Which ocean had the lowest mean for minimum       *;
*       pressure?                                         *;
*       Which season had the lowest mean for minimum      *;
*       pressure?                                         *;
***********************************************************;


proc means data=pg1.storm_final maxdec=0 n mean min;
    var MinPressure;
    where Season >=2010;
    class Season Ocean;
    ways 0 1 2;
    output out=wind_stats mean=AvgWind max=MaxWind;
run;

proc means data=pg1.np_multiyr noprint;
    var Visitors;
    class Region Year;
    ways 2;
    output out=top3parks(drop=_freq_ _type_)
           sum=TotalVisitors /*sum total visitors*/
    	   idgroup(max(Visitors) /*find the max of visitors*/
    	   out[3] /*top 3*/
    	   (Visitors ParkName)=); /*output columns for top 3 parks*/ 
run;