data monument(drop=ParkType) park(drop=ParkType) other;
    set pg2.np_yearlytraffic;
    select (ParkType);
        when ('National Monument') output monument;
        when ('National Park') output park;
        otherwise output other;
    end;
    drop Region;
run;