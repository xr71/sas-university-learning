****************************************************************;
*  Standardizing Data with the PRXCHANGE Function              *;
****************************************************************;
   
data work.AKstations;
    set pg3.weather_usstationshourly;
    where State='AK';
    Name_New=prxchange('s/ AP/ AIRPORT/',-1,Name);
    Name_New=prxchange('s/ INT( |L |L. )/ INTERNATIONAL /i',-1,Name_New);
    LatLong=prxchange('s/(-?\d+\.\d*)(@)(-?\d+\.\d*)/$3$2$1/',-1,LongLat);
run;

proc print data=work.AKstations;
    where prxmatch('/(JUNEAU|KETCHIKAN|FAIRBANKS|ANCHORAGE i)/',Name);
run;

****************************************************************;
*  Demo                                                        *;
*  1) In the DATA step, notice the incomplete syntax for the   *;
*     first assignment statement for Name_New and the complete *;
*     syntax for the second assignment statement for Name_New. *;
*       Name_New=prxchange('s/ / /',-1,Name);                  *;
*       Name_New=prxchange                                     *;
*                ('s/ INT( |L |L. )/ INTERNATIONAL /i',        *;
*                 -1,Name_New);                                *;
*  2) In the first assignment statement for Name_New, modify   *;
*     the Perl regular expression to replace the letters AP    *;
*     with the word AIRPORT for all occurrences.               *;
*       Name_New=prxchange('s/ AP / AIRPORT /',-1,Name);       *;
*     Alternatively, you could use \b (word boundary) in place *;
*     of the leading and trailing spaces around the string AP. *;
*       Name_New=prxchange('s/\bAP\b/AIRPORT/',-1,Name);       *;
*  3) Run the DATA step and the PROC step. View the results    *;
*     and verify that the Name_New column contains the         *;
*     standardized values of AIRPORT and INTERNATIONAL.        *;
*  4) Uncomment the LatLong assignment statement in the DATA   *;
*     step and the VAR statement in the PROC PRINT step.       *;
*     Modify the expression in the assignment statement to     *;
*     specify the substitution of the third capture buffer     *;
*     followed by the second and first buffers.                *;
*       LatLong=prxchange                                      *;
*               ('s/(-*\d+\.\d*)(@)(-*\d+\.\d*)/$3$2$1/',      *;
*                -1,LongLat);                                  *;
*  5) Run the DATA step and the PROC step. View the results    *;
*     and verify that the latitude value now appears before    *;
*     the longitude value in the LatLong column.               *;
****************************************************************;

data work.weather_stations;
    set pg3.weather_usstationshourly;
    Name_New=prxchange('s/ / /',-1,Name);
    Name_New=prxchange('s/ INT( |L |L. )/ INTERNATIONAL /i',
                       -1,Name_New);
    *LatLong=prxchange('s/(-*\d+\.\d*)(@)(-*\d+\.\d*)/ /',
                      -1,LongLat);
run;

title 'US Weather Stations with Hourly Readings';
proc print data=work.weather_stations;
    *var Code State Name Name_New LongLat LatLong; 
run;
title;
