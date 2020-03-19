proc print data=pg1.np_traffic;
    var ParkName Location Count;
    where Count ne 0 and upcase(Location) like '%MAIN ENTRANCE%';
run;