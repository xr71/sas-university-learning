****************************************************************;
*  Specifying a Template for Large Numbers                     *;
****************************************************************;
 
proc freq data=pg3.tornado_2017 noprint;
    where PropertyDamage>0;
    tables State / out=work.tornado_2017_pct; 
run;

proc format;
    *picture mypct low-high='009.9%' (multiplier=10);
    picture mypct (round) low-high='009.9%' (multiplier=10);
run;

title1 '2017 US Tornadoes';
title2 'with Property Damage by State';
proc print data=work.tornado_2017_pct noobs;
    *format Percent percent8.2;
    format Percent mypct.;
run;
title;

data sample;
    input UnformattedValues Multiplier;
    MultiValues=UnformattedValues*Multiplier;
    MultiValuesRound=round(MultiValues);
    FormattedValues=UnformattedValues;
    label UnformattedValues='Unformatted Values'
          MultiValues='Multiplied Values'
          MultiValuesRound='Multiplied Values*with Round'
          FormattedValues='Formatted Values';
    datalines;
23 1
234 1
2345 .01
23456 .01
234567 .01
2345678 .00001
23456789 .00001
234567890 .00001
;
run;

proc format;
    picture dollar_KM (round default=7) 
                low-<1000='009' (prefix='$' mult=1)
               1000-<1000000='009.9K' (prefix='$' mult=.01)
            1000000-high='009.9M' (prefix='$' mult=.00001);
run;

proc print data=sample split='*' noobs style(data)={cellwidth=1.5in};
    var UnformattedValues Multiplier MultiValues 
        MultiValuesRound FormattedValues;
    format MultiValues 12.5  
           FormattedValues dollar_KM.;
run;

****************************************************************;
*  Demo                                                        *;
*  1) Highlight and run the PROC SORT and PROC PRINT steps.    *;
*     Notice the formatted value of  PropertyDamage.           *;
*  2) Notice the syntax of the PROC FORMAT step. The number of *;
*     digits for large numbers will be reduced.                *;
*  3) Modify the FORMAT statement in the PROC PRINT step to    *;
*     use the custom format created in the PROC FORMAT step.   *;
*       format PropertyDamage dollar_km.;                      *;
*  4) Highlight and run the demo program. Notice that the      *;
*     PropertyDamage value for the first row is being          *;
*     displayed without the dollar sign. A length of 6 is      *;
*     being used by default because that is the length of the  *;
*     longest template.                                        *;
*  5) Add the DEFAULT= option to the PICTURE statement after   *;
*     the name of the format.                                  *;
*       picture dollar_km (round default=7)                    *;
*              low-<1000='009' (prefix='$' mult=1)             *;
*             1000-<1000000='009.9K' (prefix='$' mult=.01)     *;
*          1000000-high='009.9M' (prefix='$' mult=.00001);     *;
*  6) Highlight and run the demo program. Verify the formatted *;
*     values of PropertyDamage.                                *;
*  7) Modify the PICTURE statement to eliminate digits after   *;
*     the decimal point.                                       *;
*       picture dollar_km (round default=7)                    *;
*              low-<1000='009' (prefix='$' mult=1)             *;
*             1000-<1000000='009K' (prefix='$' mult=.001)      *;
*          1000000-high='009M' (prefix='$' mult=.000001);      *;
*  8) Highlight and run the demo program. Verify the formatted *;
*     values of PropertyDamage.                                *;
****************************************************************; 

proc format;
    picture dollar_KM (round) 
                low-<1000='009' (prefix='$' mult=1)
               1000-<1000000='009.9K' (prefix='$' mult=.01)
            1000000-high='009.9M' (prefix='$' mult=.00001);
run;

proc sort data=pg3.tornado_2017 out=work.tornado_2017;
    by descending PropertyDamage;
run;

title1 '2017 US Tornadoes';
title2 'by Descending Property Damage';
proc print data=work.tornado_2017;
    var State BeginDate Scale Deaths Injuries PropertyDamage;
    format PropertyDamage dollar20.;
run;
title;
