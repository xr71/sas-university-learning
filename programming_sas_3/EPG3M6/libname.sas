
%let path=/folders/myfolders/programming_sas_3/EPG3M6/;
%let pathout=&path/output;

libname pg3 "&path/data" filelockwait=20;

/* FILELOCKWAIT=20 specifies SAS will wait up to 20 seconds
   for a locked file to become available. Use this option
   to avoid a lock error when using the FCMP procedure.     */


