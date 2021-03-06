data insurance(drop=Type DepName Relation);
   length type $ 1 ID $ 6 DepName $ 20 Relation $ 1;
   retain ID;
   infile 'dependants2.dat' dlm=':' end=LastRec;
   input Type $ @;
   if Type='E' then do;
      if _N_>1 then output;
      input ID $;
      Deduct=0;
   end;
   else do;
      input DepName $ Relation $;
      if Relation='S' then Deduct+50;
      else if Relation='C' then Deduct+25;
   end;
   if LastRec then output;
run;

proc print data=insurance noobs;
   title 'Monthly Payroll Deductions';
run;
