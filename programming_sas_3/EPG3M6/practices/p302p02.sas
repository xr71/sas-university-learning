**************************************************************;
*  LESSON 2, PRACTICE 2                                      *;
**************************************************************;
  
data work.SouthRim;
    set pg3.np_grandcanyon;
	numSouth = count(comments, 'South', 'i');
	
	southWordPos = findw(comments, 'South', ' .', 'ei');
	
	if numSouth>0 then do;
		southWord = scan(comments, southWordPos, ' .');
		aftersouthWord = scan(comments, southWordPos+1, ' .');
		output;
	end;
run;

title 'Grand Canyon Comments Regarding South Rim';
proc print data=work.SouthRim;
run;
title;


