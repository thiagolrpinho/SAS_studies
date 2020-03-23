title1 'Selected Park Types by Region';
ods graphics on;
proc freq data=pg1.np_codelookup order=freq;
    tables Type*Region /  nocol crosslist 
           plots=freqplot(groupby=row scale=grouppercent orient=horizontal);
    where Type in ('National Historic Site', 'National Monument', 'National Park');
run;
title;

proc sgplot data=pg1.np_codelookup;
    where Type in ('National Historic Site', 'National Monument',
                   'National Park');
    hbar region / group=type seglabel
                  fillattrs=(transparency=0.5) dataskin=crisp;
    keylegend / opaque across=1 position=bottomright
                location=inside;
    xaxis grid;
run;
title;