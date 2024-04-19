***********************************data labels;

data work.complete;
	set aday.complete;

proc datasets; *changes data labels;
	contents data=complete;
		modify complete;
			label cvd="Cardiovascular Disease" genhlth1="General Health" bphigh="High Blood Pressure" 
				  gender="Gender" ordage="Age Category";
run;
quit;

proc sgplot data=complete;
	vbar qlactlm2;
	
***********************************for heat maps;

proc freq data=aday.complete;
	tables x_state*bphigh / nocol nofreq nopercent;
	*where x_state ne ("Guam" "District" "Puerto Ri");
	
proc freq data=aday.complete;
	tables bphigh;
	
proc freq data=aday.complete;
	tables x_state*copd / nocol nofreq nopercent;

***********************************100% stacked;

**********cvd and genhtlh1;

proc freq data=complete;
	tables genhlth1*cvd;
	ods output CrossTabFreqs = CT;

*100% stacked bar chart;
data CT2; 
	set CT (drop = TABLE _TYPE_ _TABLE_ MISSING);
	if not MISSING (ROWPERCENT);
run;

proc sgplot data = CT2;  
	vbar genhlth1 / group = cvd response=ROWPERCENT categoryorder=respasc outlineattrs=(color=black);
	xaxis values=("Excellent" "Very good" "Good" "Fair" "Poor") label = 'General Health';
	styleattrs datacolors=(stlg lilg);
	yaxis label = "Incidence of Cardiovascular Disease";
	*yaxis display=(nolabel) values=("No" "Yes");
	*xaxis label = 'Birth Weight Category';
	*yaxis label = 'Percent';
run;


**********cvd and bphigh;

proc freq data=complete;
	tables bphigh*cvd;
	ods output CrossTabFreqs = CT;

*100% stacked bar chart;
data CT2; 
	set CT (drop = TABLE _TYPE_ _TABLE_ MISSING);
	if not MISSING (ROWPERCENT);
run;

proc sgplot data = CT2;  
	vbar bphigh / group = cvd response=ROWPERCENT categoryorder=respasc outlineattrs=(color=black);
	xaxis values=("No" "Yes, During Pregnancy" "Yes, Borderline" "Yes")
		  label = 'High Blood Pressure';
	styleattrs datacolors=(bioy paoy);
	yaxis label = "Incidence of Cardiovascular Disease";
	*yaxis display=(nolabel) values=("Yes" "No");
	*yaxis label = 'Percent';
run;

**********cvd and copd;

proc freq data=complete;
	tables copd*cvd;
	ods output CrossTabFreqs = CT;

*100% stacked bar chart;
data CT2; 
	set CT (drop = TABLE _TYPE_ _TABLE_ MISSING);
	if not MISSING (ROWPERCENT);
run;

proc sgplot data = CT2;  
	vbar copd / group = cvd response=ROWPERCENT categoryorder=respasc outlineattrs=(color=black);
	xaxis values=("No" "Yes")
		  label = 'Chronic Obstructive Pulmonary Disease';
	styleattrs datacolors=(stlg lilg);
	yaxis label = "Incidence of Cardiovascular Disease";
	*yaxis display=(nolabel) values=("Yes" "No");
	*yaxis label = 'Percent';
run;

***********************************discretization and line chart; 

proc univariate data=aday.complete;
	var age;
	histogram;

Data cvdage;
set aday.complete;
if age <30 then ordage = "20s";
else if age < 40 then ordage = "30s";
else if AGE <50 then ordage = "40s";
else if AGE <60 then ordage = "50s";
else if AGE <70 then ordage = "60s";
else if AGE <80 then ordage = "70s";
*else if PRAGE <140 then ordprage = 7;
*else if PRAGE <160 then ordprage = 8;
*else if PRAGE <180 then ordprage = 9;
else ordage = "80+";
Run;

Proc means data = cvdage;
var age;
class ordage;
run;

proc freq data=cvdage;
	tables ordage;

data cvdage;
	set cvdage;
	if cvd = "Yes" then cvdq = 1;
	else cvdq = 0;

Proc means data=cvdage;
Var cvdq;
class ordage;
output out=test mean=meancvdq;
Run;

ods graphics on / height = 1in width = 1in;
symbol v=square color = str i=join width=4 bwidth=4;
Proc gplot data = test;
plot meancvdq*ordage;
axis major=(width=0.05) minor=(width=0.025);
run;
quit;

ods graphics off;






