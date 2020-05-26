****************************************************************;
*  Finding Multiple Occurences of a Value                      *;
****************************************************************;
  
/* Using FIND function to find multiple occurences */
data work.narrative_multipleEF;
    set pg3.tornado_2017narrative;  
    NumEF=count(Narrative,'EF');
    /* Zero or First Occurence */
    EFWordPos=find(Narrative,'EF');
    output;
    /* Multiple Occurences */
    do while(EFWordPos>0);
      EFWordPos=find(Narrative,'EF',EFWordPos+1);
      if EFWordPos>0 then output; 
    end;
run;
 
proc print data=work.narrative_multipleEF;
run;

/* Using FIND and FINDW functions to find multiple occurences */
data work.narrative_multipleEF(drop=PrevEFWordNum);
    set pg3.tornado_2017narrative;  
    NumEF=count(Narrative,'EF');
    /* Zero or First Occurence */
    EFWordNum=findw(Narrative,'EF','012345- .,','e');
    EFWordPos=find(Narrative,'EF');
    if EFWordNum>0 then AfterEF=scan(Narrative,EFWordNum+1,'012345- .,');
    output;
    /* Multiple Occurences */
    do while(EFWordPos>0);
      PrevEFWordNum=EFWordNum;
      EFWordNum=findw(Narrative,'EF','012345- .,',EFWordPos+1,'e')+PrevEFWordNum;
      EFWordPos=find(Narrative,'EF',EFWordPos+1);
      if EFWordPos>0 then do;
         AfterEF=scan(Narrative,EFWordNum+1,'012345- .,');
         output;
      end; 
    end;
run;

proc print data=work.narrative_multipleEF;
run;






