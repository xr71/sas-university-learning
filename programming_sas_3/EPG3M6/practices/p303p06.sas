**************************************************************;
*  LESSON 3, PRACTICE 6                                      *;
**************************************************************;

data work.warehouses;
    /* add code to create and load three-dimensional array */

    set pg3.product_list; 
    ProdID=put(ProductID,12.);
    ProductLine=input(substr(ProdID,1,2),2.);
    ProductCatID=input(substr(ProdID,3,2),2.);
    ProductLocID=input(substr(ProdID,12,1),1.);
    /* add code to use three-dimensional array */

run;

title 'Warehouse Location for Products';
proc print data=work.warehouses;
run;
title;

