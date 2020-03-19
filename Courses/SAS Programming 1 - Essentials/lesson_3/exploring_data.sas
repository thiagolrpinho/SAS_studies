/* Level 2 Practice: Using Procedures to Validate Data
The pg1.np_summary table contains information about US national parks, monuments, preserves, rivers, and seashores. Valid values and descriptions for the columns Reg and Type are as follows:

Write a PROC FREQ step to produce frequency tables for the Reg and Type columns in the pg1.np_summary table.
Submit the step and look for invalid values.


What invalid values exist for Reg?


What invalid values exist for Type?


Write a PROC UNIVARIATE step to generate statistics for the Acres column in the pg1.np_summary table. Submit the step.


What are the observation numbers for the smallest park and the largest park?


View the pg1.np_summary table to identify the name and size of the smallest and largest parks. */

/* Generating some frequencies*/
proc freq data=PG1.NP_SUMMARY;
    Tables Reg Type;
run;

/* Generating some frequencies*/
proc univariate data=PG1.NP_SUMMARY;
    var Acres;
run;