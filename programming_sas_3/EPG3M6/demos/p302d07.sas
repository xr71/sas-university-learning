****************************************************************;
*  PRX Functions (5) and CALL Routines (6)                     *;
****************************************************************;
 
*PRXCHANGE Function;
*Performs a pattern-matching replacement.;
data work.weather_stations;
    set pg3.weather_usstationshourly;
    Name_New=prxchange('s/ AP / AIRPORT /',-1,Name);
    Name_New=prxchange('s/ INT( |L |L. )/ INTERNATIONAL /i',-1,Name_New);
    LatLong=prxchange('s/(-*\d+\.\d*)(@)(-*\d+\.\d*)/$3$2$1/',-1,LongLat);
run;

title 'US Weather Stations with Hourly Readings';
proc print data=work.weather_stations(obs=20);
    var Code State Name Name_New LongLat LatLong; 
run;
title;

*PRXMATCH Function;
*Searches for a pattern match and returns the position at which the pattern is found.; 
data work.ValidPhoneNumbers;
    set pg3.phonenumbers_us;
    Exp='/([2-9]\d\d)-([2-9]\d\d)-(\d{4})/o';
    Loc=prxmatch(Exp,Phone);
run;

title 'Pattern Matching Phone Numbers';
proc print data=work.ValidPhoneNumbers;
run;
title;

*PRXPARSE Function;
*Compiles a Perl regular expression that can be used for pattern matching of a character value.; 
*PRXPAREN Function;
*Returns the last bracket match for which there is a match (first) in a pattern.; 
data work.weather_stations;
    set pg3.weather_usstationshourly;
    Exp='/(\sINT\s)|(\sINTL\s)|(\sINTL.\s)/io';
    PatternID=prxparse(Exp);
    Position=prxmatch(PatternID,Name);
    WhichGroup=prxparen(PatternID);
run;

title 'US Weather Stations with Hourly Readings';
proc print data=work.weather_stations(obs=20);
run;
title;

*PRXPOSN Function;
*Returns a character string that contains the value for a capture buffer.; 
data work.FlipNames;
    length FlipName $ 20;
    set sashelp.baseball(keep=Name);	
    Exp='/(\w+\D*\w*), (\w+\s*\w*)/o';
    PatternID=prxparse(Exp);
    if prxmatch(PatternID, Name)>0 then 
     FlipName=catx(' ',prxposn(PatternID,2,Name),prxposn(PatternID,1,Name));
run;

title 'Baseball Players';
proc print data=work.FlipNames(obs=20);
run;
title;

*CALL PRXCHANGE Routine;
*Performs a pattern-matching replacement.;
data work.weather_stations;
    set pg3.weather_usstationshourly;
    length LatLong $ 25;
    Exp='s/(-*\d+\.\d*)(@)(-*\d+\.\d*)/$3$2$1/o';
    PatternID=prxparse(Exp);
    call prxchange(PatternID,-1,LongLat,LatLong);
run;

title 'US Weather Stations with Hourly Readings';
proc print data=work.weather_stations(obs=20);
    var Code State Name LongLat LatLong; 
run;
title;

*CALL PRXDEBUG Routine;
*Enables Perl regular expressions in a DATA step to send debugging output to the SAS log.; 
data work.ValidPhoneNumbers;
    set pg3.phonenumbers_us;
    putlog 'Iteration: ' _N_=;
    call prxdebug(1); 
    Exp='/([2-9]\d\d)-([2-9]\d\d)-(\d{4})/o';
    Loc=prxmatch(Exp,Phone);
run;

*CALL PRXFREE Routine;
*Frees memory that was allocated for a Perl regular expression.; 
data work.ValidPhoneNumbers;
    set pg3.phonenumbers_us;
    putlog 'Iteration: ' _N_=;
    call prxdebug(1); 
    Exp='/([2-9]\d\d)-([2-9]\d\d)-(\d{4})/o';
    PatternID=prxparse(Exp);
    Loc=prxmatch(Exp,Phone);
    call prxfree(PatternID);
run;

*CALL PRXPOSN Routine;
*Returns the start position and length for a capture buffer.; 
data work.FirstNames;
    set sashelp.baseball(keep=Name);	
    Exp='/(\w+\D*\w*), (\w+\s*\w*)/o';
    PatternID=prxparse(Exp);
    if prxmatch(PatternID, Name)>0 then do;
	   call prxposn(PatternID,2,Start,Length);
	   Firstname=substr(Name,Start,Length);
    end;
run;

title 'Baseball Players';
proc print data=work.FirstNames(obs=20);
run;
title;

*CALL PRXSUBSTR Routine;
*Returns the position and length of a substring that matches a pattern.; 
data work.MultiStateDamage;
    set pg3.storm_damage;
    Exp='/[A-Z][A-Z](, [A-Z][A-Z])+(,? and [A-Z][A-Z])?/o';
    Pid=prxparse(Exp);
    call prxsubstr(Pid,Summary,MyStart,MyLength);
    if MyStart>0; 
    MultiState=substr(Summary,MyStart,MyLength);
run;

title 'Storms Causing Damages in Multiple States';
proc print data=work.MultiStateDamage;
    var Event Date Summary MyStart MyLength MultiState;
    format Date date9.;
run;
title;

*CALL PRXNEXT;
*Returns the position and length of a substring that matches a pattern, 
 and iterates over multiple matches within one string.;
data work.MultiStateDamage;
    set pg3.storm_damage;
    Exp='/[A-Z][A-Z](, [A-Z][A-Z])+(,? and [A-Z][A-Z])?/o';
    Pid=prxparse(Exp);
    Start=1;
    call prxnext(Pid,Start,length(Summary),Summary,MyStart,MyLength);
    do while (MyStart>0);
       MultiState=substr(Summary,MyStart,MyLength);
       output;
       call prxnext(Pid,Start,length(Summary),Summary,MyStart,MyLength);
    end;
run;

title 'Storms Causing Damages in Multiple States';
proc print data=work.MultiStateDamage;
    var Event Date Summary Start MyStart MyLength MultiState;
    format Date date9.;
run;
title;
