title "Most Costly Storms";
proc sql;
select Event,
       Cost format=dollar16.,  
       year(Date) as Season
    from pg1.storm_damage
    where Cost>25000000000
    order by Cost desc;
quit;

proc sql;
create table top_damage as
select Event, 
       Date format=monyy7.,
       Cost format=dollar16.
       from pg1.storm_damage
       order by Cost desc;
title "Top 10 Storms by Damage Cost";
    select *
        from top_damage(obs=10);
quit;

proc sql;
select Season, Name, s.Basin, BasinName, MaxWindMPH 
    from pg1.storm_summary as s 
        inner join pg1.storm_basincodes as b 
        on upcase(s.basin)=b.basin 
    order by Season desc, Name;
quit; 