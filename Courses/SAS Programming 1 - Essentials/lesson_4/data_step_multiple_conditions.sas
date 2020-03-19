data fox;
    set pg1.np_species;
    where Category='Mammal' and upcase(Common_Names) like '%FOX%' 
        and upcase(Common_Names) not like '%SQUIRREL%';    
    drop Category Record_Status Occurrence Nativeness;
run;

proc sort data=fox;
    by Common_Names;
run;