/* Windows/UNIX */
 
/* STEP 1: Notice the default values for the %LET statements. */

/* STEP 2: If your files are not to be located in S:/workshop */
/* change the value of PATH= in the %LET statement to */
/* reflect your data location. */

/* STEP 3:	Submit the program to create the course data files. */

/* STEP 4: View the Results and verify the CONTENTS procedure */
/* report lists the names of the SAS data sets that were created.*/

/* NOTE: Edit and run LIBNAME.SAS before running this program */



 /*+++++++++++++++++++++++++++++++++++++++++++++*/
/* Alternate Data Locations                     */
/* DO NOT CHANGE THE FOLLOWING CODE UNLESS     */
/* DIRECTED TO DO SO BY YOUR INSTRUCTOR.       */
 /*+++++++++++++++++++++++++++++++++++++++++++++*/
 
/* %let path=s:/workshop/LWPG3M6;    */
*%let path=s:/workshop/pg3m6;
*%let path=c:/workshop/pg3m6;
*%let path=c:/SAS_Education/pg3m6;
*%let path=c:/SAS_Education/lwpg3m6;

/*+++++++++++++++++++++++++++++++++++++++++++++*/
/* WARNING: DO NOT ALTER CODE BELOW THIS LINE */
/* UNLESS DIRECTED TO DO SO BY YOUR INSTURCTOR.*/
/*+++++++++++++++++++++++++++++++++++++++++++++*/

%include "&path/data/pg3m6.sas";
