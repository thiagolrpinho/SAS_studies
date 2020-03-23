***********************************************************;
*  Activity 6.02                                          *;
*    1) Complete the PROC EXPORT step to read the         *;
*       PG1.STORM_FINAL SAS table and create a            *;
*       comma-delimited file named STORM_FINAL.CSV. Use   *;
*       &outpath to substitute the path of the output     *;
*       folder.                                           *;
*    2) Run the program and view the text file:           *;
*                                                         *;
*       SAS Studio - Navigate to the output folder in the *;
*       Navigation pane, right-click on storm_final.csv,  *;
*       and select View File as Text.                     *;
*                                                         *;
*       Enterprise Guide - Select Open -> Other and       *;
*       navigate to the output folder. Select             *;
*       storm_final.csv and click Open. Click Cancel in   *;
*       the Import Data window.                           *;
***********************************************************;
*  Syntax                                                 *;
*                                                         *;
*    PROC EXPORT DATA=input-table                         *;
*                OUTFILE="output-file"                    *;
*                <DBMS=identifier> <REPLACE>;             *;
*    RUN;                                                 *; 
***********************************************************;
%let outpath=/folders/myfolders/EPG194/output/lesson_6;

proc export data=pg1.storm_final
    outfile="&outpath/storm_final.csv"
    dbms=csv replace;
run; 


libname xl_lib xlsx "&outpath/storm.xlsx";

data xl_lib.storm_final;
    set pg1.storm_final;
    drop Lat Lon Basin OceanCode;
run;

libname xl_lib clear;
