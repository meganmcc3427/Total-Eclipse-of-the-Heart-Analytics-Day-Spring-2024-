*analytics day;

/* Generated Code (IMPORT) */
/* Source File: brfss2013.csv */
/* Source Path: /gpfs/user_home/os_home_dirs/mmccab12 */
/* Code generated on: 3/7/24, 7:11 PM */

%web_drop_table(WORK.brfss);


FILENAME REFFILE '/gpfs/user_home/os_home_dirs/mmccab12/brfss2013.csv';

PROC IMPORT DATAFILE=REFFILE	
	DBMS=CSV
	OUT=WORK.brfss;
	GETNAMES=YES;
RUN;

PROC CONTENTS DATA=WORK.brfss; RUN;


%web_open_table(WORK.brfss);

********************************************assigning permanent library;

libname aday "/gpfs/user_home/os_home_dirs/mmccab12/Analytics Day 2024";

data aday.brfss;
	set brfss;
	
proc contents data=aday.brfss;

*should stay categorical: genhlth hlthpln1 persdoc2 medcost checkup1 bphigh4 bloodcho
							cvdinfr4 cvdcrhd4 cvdstrk3 asthma3 chcscncr chcocncr
							chccopd1 havarth3 addepev2 chckidny diabete3 veteran
							marital children educa employ1 income2 renthom1 sex
							pregnant qlactlm2 useequip blind decide diffwalk
							diffdres diffalon smoke100 usenow3 exerany2 seatbelt
							flushot6;

*to be fixed + imputed: sleptim1 physhlth menthlth weight2 height3 alcday5 fruitjui1
						fruit1 fvbeans fvgreen fvorang vegetab1 strength;
						*verify units weight/height;
						*alcday5, fruitjui1, fruit1, fvbeans, fvgreen, 
						fvorang, vegetab1, strength formatting is strange;
											

%let complete = sleptim1 genhlth physhlth menthlth hlthpln1 persdoc2 medcost checkup1 
				bphigh4 bloodcho cvdinfr4 cvdcrhd4 cvdstrk3 asthma3 chcscncr chcscncr
				chccopd1 havarth3 addepev2 chckidny diabete3 veteran marital children educa
				employ1 income2 weight2 height3 renthom1 sex pregnant qlactlm2 useequip blind
				decide diffwalk diffdres diffalon smoke100 usenow3 alcday5 fruitjui1 fruit1
				fvbeans fvgreen fvorang vegetab1 exerany2 strength seatbelt flushot6;
				
************added age from x_age80;

proc sort data=aday.brfss;
	by dispcode;

data aday.complete;
	set aday.brfss;
	if dispcode = "Completed interview";
	
********************************************************************************fixing formatting;

***********************************************************sleptim1 to sleptim;

data aday.complete;
	set aday.complete;
	format sleptim 8.;  ***changes categorical to numerical, $. would change to categorical;
	if sleptim1 ne "NA" then sleptim = sleptim1;
	else sleptim = 7;
	drop sleptim1;
	
proc means data=aday.complete n mean median;
	var sleptim;

************************************************************physhlth to physhlth1;

proc freq data=aday.complete;
	tables physhlth;

data aday.complete;
	set aday.complete;
	format physhlth1 8.;  ***changes categorical to numerical, $. would change to categorical;
	if physhlth ne "NA" then physhlth1 = physhlth;
	else physhlth1 = 0;
	drop physhlth;

proc means data=aday.complete n mean median;
	var physhlth1;
	
proc univariate data=test;
	var physhlth1;
	histogram;

***************************************************************menthlth to menthlth1;

proc freq data=aday.complete;
	tables menthlth1;

data aday.complete;
	set aday.complete;
	format menthlth1 8.;  ***changes categorical to numerical, $. would change to categorical;
	if menthlth ne "NA" then menthlth1 = menthlth;
	else menthlth1 = 0;
	drop menthlth;

proc means data=aday.complete n mean median;
	var menthlth1;
	
proc univariate data=aday.complete;
	var menthlth1;
	histogram;

***************************************************************weight2 to weight;

proc freq data=aday.complete;
	tables weight2;

data aday.complete;
	set aday.complete;
	format weight 8.; 
	if weight2 < 9000 then weight = weight2;
	else if weight2 > 9000 then weight = (weight2 - 9000)*2.205;
	else weight = 170;
	drop weight2;
	
data aday.complete;
	set aday.complete;
	if weight=. then weight=170;

proc freq data=aday.complete;
	tables weight;

proc means data=test n mean median;
	var weight;
	
proc univariate data=aday.complete;
	var weight;
	histogram;
	
*****************************************************************hlthpln1 to hlthpln;

proc freq data=aday.complete;
	tables hlthpln;

data aday.complete;
	set aday.complete;
	if hlthpln1 ne "NA" then hlthpln = hlthpln1;
	else hlthpln = "Yes";
	drop menthlth;

***************************************************************genhlth to genhlth1;
	
proc freq data=aday.complete;
	tables genhlth;

data aday.complete;
	set aday.complete;
	if genhlth ne "NA" then genhlth1 = genhlth;
	else genhlth1 = "Very good";
	
proc freq data=aday.complete;
	tables genhlth1;
	
*************************************************************persdoc2 to persdoc;

proc freq data=aday.complete;
	tables persdoc2;

data aday.complete;
	set aday.complete;
	if persdoc2 ne "NA" then persdoc = persdoc2;
	else persdoc = "Yes, only one";
	
proc freq data=aday.complete;
	tables persdoc;

*************************************************************medcost to medcost1;

proc freq data=aday.complete;
	tables medcost;

data aday.complete;
	set aday.complete;
	if medcost ne "NA" then medcost1 = medcost;
	else medcost1 = "No";
	
proc freq data=aday.complete;
	tables medcost1;
	
*********************************************************checkup1 to checkup;

proc freq data=aday.complete;
	tables checkup1;

data aday.complete;
	set aday.complete;
	if checkup1 ne "NA" then checkup = checkup1;
	else checkup = "Within past year";
	
proc freq data=aday.complete;
	tables checkup;

*********************************************************bphigh4 to bphigh;

proc freq data=aday.complete;
	tables bphigh4;


data aday.complete;
	set aday.complete;
	length bphigh $21.;
	if bphigh4 = "NA" then bphigh = "No";
	else if bphigh4 = "Told " then bphigh = "Yes, Borderline";
	else if bphigh4 = "Yes, " then bphigh = "Yes, During Pregnancy";
	else if bphigh4 = "Yes" then bphigh = "Yes";
	else if bphigh4 = "No" then bphigh = "No";

data test;
	set aday.complete;
	if bphigh4 ne "NA" then bphigh = bphigh4;
	else bphigh = "No";
	
proc freq data=aday.complete;
	tables bphigh;
	
********************************************************bloodcho to bloodcho1;

proc freq data=aday.complete;
	tables bloodcho;

data aday.complete;
	set aday.complete;
	if bloodcho ne "NA" then bloodcho1 = bloodcho;
	else bloodcho1 = "Yes";
	
proc freq data=aday.complete;
	tables bloodcho1;

*******************************************************chcscncr to skincanc;

proc freq data=aday.complete;
	tables chcscncr;

data aday.complete;
	set aday.complete;
	if chcscncr ne "NA" then skincanc = chcscncr;
	else skincanc = "No";
	
proc freq data=aday.complete;
	tables skincanc;

*******************************************************chcocncr to othercanc;

proc freq data=aday.complete;
	tables chcocncr;

data aday.complete;
	set aday.complete;
	if chcocncr ne "NA" then othercanc = chcocncr;
	else othercanc = "No";
	
proc freq data=aday.complete;
	tables othercanc;
	
*******************************************************cvdinfr4 to heartattack;

proc freq data=aday.complete;
	tables cvdinfr4;

data aday.complete;
	set aday.complete;
	if cvdinfr4 ne "NA" then heartattack = cvdinfr4;
	else heartattack = "No";
	
proc freq data=aday.complete;
	tables heartattack;
	
*****************************************************cvdcrhd4 to corodis;

proc freq data=aday.complete;
	tables cvdcrhd4;

data aday.complete;
	set aday.complete;
	if cvdcrhd4 ne "NA" then corodis = cvdcrhd4;
	else corodis = "No";
	
proc freq data=aday.complete;
	tables corodis;
	
*****************************************************cvdstrk3 to stroke;

proc freq data=aday.complete;
	tables cvdstrk3;

data aday.complete;
	set aday.complete;
	if cvdstrk3 ne "NA" then stroke = cvdstrk3;
	else stroke = "No";
	
proc freq data=aday.complete;
	tables stroke;
	
*****************************************************asthma3 to asthma;

proc freq data=aday.complete;
	tables asthma3;

data aday.complete;
	set aday.complete;
	if asthma3 ne "NA" then asthma = asthma3;
	else asthma = "No";
	
proc freq data=aday.complete;
	tables asthma;
	
****************************************************chccopd1 to copd;

proc freq data=aday.complete;
	tables chccopd1;

data aday.complete;
	set aday.complete;
	if chccopd1 ne "NA" then copd = chccopd1;
	else copd = "No";
	
proc freq data=aday.complete;
	tables copd;
	
****************************************************havarth3 to arthritis;

proc freq data=aday.complete;
	tables havarth3;

data aday.complete;
	set aday.complete;
	if havarth3 ne "NA" then arthritis = havarth3;
	else arthritis = "No";
	
proc freq data=aday.complete;
	tables arthritis;
	
***************************************************addepev2 to depress;

proc freq data=aday.complete;
	tables addepev2;

data aday.complete;
	set aday.complete;
	if addepev2 ne "NA" then depress = addepev2;
	else depress = "No";
	
proc freq data=aday.complete;
	tables depress;
	
***************************************************chckidny to kiddis;

proc freq data=aday.complete;
	tables chckidny;

data aday.complete;
	set aday.complete;
	if chckidny ne "NA" then kiddis = chckidny;
	else kiddis = "No";
	
proc freq data=aday.complete;
	tables kiddis;
	
*****************************************************diabete3 to diabetes;

proc freq data=aday.complete;
	tables diabete3;
	
data aday.complete;	
	set aday.complete;
	drop diabetes;

data aday.complete;
	set aday.complete;
	length diabetes $25.;
	if diabete3 = "Yes, " then diabetes = "Yes, During Pregnancy";
	else if diabete3 = "Yes" then diabetes = "Yes";
	else if diabete3 = "No" then diabetes = "No";
	else if diabete3 = "No, p" then diabetes = "Borderline or Prediabetes";
	else diabetes = "No";
	
proc freq data=aday.complete;
	tables diabetes;
	
proc sgplot data=test;
	vbar diabetes;
	
****************************************************seatbelt to beltcomp;

proc freq data=aday.complete;
	tables seatbelt;

data aday.complete;
	set aday.complete;
	if seatbelt ne "NA" then beltcomp = seatbelt;
	else beltcomp = "Always";
	
proc freq data=aday.complete;
	tables beltcomp;

*****************************************************veteran3 to veteran;

proc freq data=aday.complete;
	tables veteran3;

data aday.complete;
	set aday.complete;
	if veteran3 ne "NA" then veteran = veteran3;
	else veteran = "No";
	
proc freq data=aday.complete;
	tables veteran;
	
***************************************************marital to married;

proc freq data=aday.complete;
	tables marital;

data aday.complete;
	set aday.complete;
	if marital ne "NA" then married = marital;
	else married = "Married";
	
proc freq data=aday.complete;
	tables married;
	
*******************************************************children to kids;

proc freq data=aday.complete;
	tables children;
	
proc means data=aday.complete n mean median;
	var children;

data aday.complete;
	set aday.complete;
	format kids 8.;
	if children=. then kids = 0;
	else if children = 47 then kids = 0;
	else kids = children;
	
proc freq data=aday.complete;
	tables kids;
	
proc means data=aday.complete n mean median;
	var kids;
	
********************************************************educa to education;

proc freq data=aday.complete;
	tables educa;

data aday.complete;
	set aday.complete;
	if educa ne "NA" then education = educa;
	else education = "College 4 years or more (College graduate)";
	
proc freq data=aday.complete;
	tables education;
	
******************************************************employ1 to employed;

proc freq data=aday.complete;
	tables employ1;

data aday.complete;
	set aday.complete;
	if employ1 ne "NA" then employed = employ1;
	else employed = "Employed for wages";
	
proc freq data=aday.complete;
	tables employed;

*****************************************************renthom1 to home;

proc freq data=aday.complete;
	tables renthom1;

data aday.complete;
	set aday.complete;
	if renthom1 ne "NA" then home = renthom1;
	else home = "Own";
	
proc freq data=aday.complete;
	tables home;
	
****************************************************sex to gender;

proc freq data=aday.complete;
	tables sex;

data aday.complete;
	set aday.complete;
	if sex ne "NA" then gender = sex;
	else gender = "Female";
	
proc freq data=aday.complete;
	tables gender;

*****************************************************x_age80 to age;

proc freq data=aday.complete;
	tables x_age80;
	
proc means data=aday.complete n mean median; *median = 57;
	var x_age80;
	
data aday.complete;
	set aday.complete;
	if x_age80=. then age=57;
	else if x_age80 < 18 then age = 18;
	else age = x_age80;
	
proc freq data=aday.complete;
	tables age;

******************************************************qlactlm2 to limited;

proc freq data=aday.complete;
	tables qlactlm2;

data aday.complete;
	set aday.complete;
	if qlactlm2 ne "NA" then limited = qlactlm2;
	else limited = "No";
	
proc freq data=aday.complete;
	tables limited;
	
*******************************************************useequip to equip;

proc freq data=aday.complete;
	tables useequip;

data aday.complete;
	set aday.complete;
	if useequip ne "NA" then equip = useequip;
	else equip = "No";
	
proc freq data=aday.complete;
	tables equip;

******************************************************blind to blind1;

proc freq data=aday.complete;
	tables blind;

data aday.complete;
	set aday.complete;
	if blind ne "NA" then blind1 = blind;
	else blind1 = "No";
	
proc freq data=aday.complete;
	tables blind1;
	
******************************************************decide to decision;

proc freq data=aday.complete;
	tables decide;

data aday.complete;
	set aday.complete;
	if decide ne "NA" then decision = decide;
	else decision = "No";
	
proc freq data=aday.complete;
	tables decision;

****************************************************diffwalk to diffwalk1;

proc freq data=aday.complete;
	tables diffwalk;

data aday.complete;
	set aday.complete;
	if diffwalk ne "NA" then diffwalk1 = diffwalk;
	else diffwalk1 = "No";
	
proc freq data=aday.complete;
	tables diffwalk1;

****************************************************diffdres to diffdres1;

proc freq data=aday.complete;
	tables diffdres;

data aday.complete;
	set aday.complete;
	if diffdres ne "NA" then diffdres1 = diffdres;
	else diffdres1 = "No";
	
proc freq data=aday.complete;
	tables diffdres1;
	
****************************************************diffalon to diffalon1;

proc freq data=aday.complete;
	tables diffalon;

data aday.complete;
	set aday.complete;
	if diffalon ne "NA" then diffalon1 = diffalon;
	else diffalon1 = "No";
	
proc freq data=aday.complete;
	tables diffalon1;
	
****************************************************smoke100 to smoker;

proc freq data=aday.complete;
	tables smoke100;

data aday.complete;
	set aday.complete;
	if smoke100 ne "NA" then smoker = smoke100;
	else smoker = "No";
	
proc freq data=aday.complete;
	tables smoker;
	
************************************************************usenow3 to usenow;

proc freq data=aday.complete;
	tables usenow3;

data aday.complete;
	set aday.complete;
	if usenow3 ne "NA" then usenow = usenow3;
	else usenow = "Not at all";
	
proc freq data=aday.complete;
	tables usenow;
	
****************************************************************exerany2 to exercise;

proc freq data=aday.complete;
	tables exerany2;

data aday.complete;
	set aday.complete;
	if exerany2 ne "NA" then exercise = exerany2;
	else exercise = "Yes";
	
proc freq data=aday.complete;
	tables exercise;
	
***************************************************************flushot6 to flushot;

proc freq data=aday.complete;
	tables flushot6;

data aday.complete;
	set aday.complete;
	if flushot6 ne "NA" then flushot = flushot6;
	else flushot = "No";
	
proc freq data=aday.complete;
	tables flushot;

***************************************************************alcday5 to daysdrink;

proc freq data=aday.complete;
	tables alcday5;
	
data aday.complete;
	set aday.complete;
	format daysdrink 8.;
	if 100 < alcday5 < 200 then daysdrink = (alcday5-100)*4.3; **days/week into days/month;
	else if alcday5 > 200 then daysdrink = (alcday5-200);
	else daysdrink = 0;
	
data test;
	set aday.complete;
	format daysdrink1 8.;
	daysdrink1 = daysdrink;
	
proc freq data=test;
	tables daysdrink;
	
proc means data=test n mean median;
	var daysdrink1;

**************************************************heightin and bmi;

proc freq data=aday.complete;
	tables height3;
	
data test2;
	set aday.complete;
	if 400<=height3<=900;
	
data aday.complete;
	set aday.complete;
	if 400 < height3 < 900 then height_feet = int(height3/100);
	if 400 < height3 < 900 then height_inch = (height3/100 - int(height3/100))*100;
	if 400 < height3 < 900 then heightin = 12*height_feet+height_inch;
	else heightin = 64;

proc freq data=aday.complete;
	tables height_feet height_inch heightin;
	
data aday.complete;
	set aday.complete;
	bmi = 703*(weight/(heightin**2)); *****************creating bmi var;
	
proc univariate data=aday.complete;
	var bmi;
	histogram;
	
********************************************************************fruitju1 to juice;

proc freq data=aday.complete;
	tables fruitju1;
	
data aday.complete;
	set aday.complete;
	if fruitju1 = 300 then juice = 0;
	else if 100 < fruitju1 < 200 then juice = (fruitju1-100)*30;
	else if 200 < fruitju1 < 300 then juice = (fruitju1-200)*4.3;
	else if 300 < fruitju1 < 400 then juice = (fruitju1-300);
	else juice = 0;
	
proc freq data=aday.complete;
	tables juice;
	
*******************************************************************fruit1 to fruit;

proc freq data=aday.complete;
	tables fruit1;
	
data aday.complete;
	set aday.complete;
	if fruit1 = 300 then fruit = 0;
	else if 100 < fruit1 < 200 then fruit = (fruit1-100)*30;
	else if 200 < fruit1 < 300 then fruit = (fruit1-200)*4.3;
	else if 300 < fruit1 < 400 then fruit = (fruit1-300);
	else fruit = 0;
	
proc freq data=aday.complete;
	tables fruit;

*****************************************************************fvbeans to beans;

proc freq data=aday.complete;
	tables fvbeans;
	
data aday.complete;
	set aday.complete;
	if fvbeans = 300 then beans = 0;
	else if 100 < fvbeans < 200 then beans = (fvbeans-100)*30;
	else if 200 < fvbeans < 300 then beans = (fvbeans-200)*4.3;
	else if 300 < fvbeans < 400 then beans = (fvbeans-300);
	else beans = 0;
	
proc freq data=aday.complete;
	tables beans;
	
*****************************************************************fvgreen to greens;

proc freq data=aday.complete;
	tables fvgreen;
	
data aday.complete;
	set aday.complete;
	if fvgreen = 300 then greens = 0;
	else if fvgreen = 0 then greens = 0;
	else if 100 < fvgreen < 200 then greens = (fvgreen-100)*30;
	else if 200 < fvgreen < 300 then greens = (fvgreen-200)*4.3;
	else if 300 < fvgreen < 400 then greens = (fvgreen-300);
	else greens = 30;
	
proc freq data=aday.complete;
	tables greens;
	
****************************************************************fvorang to orangeveg;

proc freq data=aday.complete;
	tables fvorang;
	
data aday.complete;
	set aday.complete;
	if fvorang = 300 then orangeveg = 0;
	else if 100 < fvorang < 200 then orangeveg = (fvorang-100)*30;
	else if 200 < fvorang < 300 then orangeveg = (fvorang-200)*4.3;
	else if 300 < fvorang < 400 then orangeveg = (fvorang-300);
	else orangeveg = 0;
	
proc freq data=aday.complete;
	tables orangeveg;

****************************************************************vegetab1 to veggies;

proc freq data=aday.complete;
	tables vegetab1;
	
data aday.complete;
	set aday.complete;
	if vegetab1 = 300 then veggies = 0;
	else if vegetab1 = 0 then veggies = 0;
	else if 100 < vegetab1 < 200 then veggies = (vegetab1-100)*30;
	else if 200 < vegetab1 < 300 then veggies = (vegetab1-200)*4.3;
	else if 300 < vegetab1 < 400 then veggies = (vegetab1-300);
	else veggies = 30;
	
proc freq data=aday.complete;
	tables veggies;
	
proc means data=aday.complete n mean median;
	var veggies;

**************************************************************strength to strength1;

proc freq data=aday.complete;
	tables strength;

data aday.complete;
	set aday.complete;
	if 100 < strength < 200 then strength1 = (strength-100)*4.3;
	else if 200 < strength < 300 then strength1 = (strength-200);
	else strength1 = 0;
	
proc freq data=test;
	tables strength1;
	
proc univariate data=test;
	hist;
	var strength1;


*************************************************************binary var;

data aday.complete;
	set aday.complete;
	if heartattack = "Yes" then cvd = "Yes";
	else if stroke = "Yes" then cvd = "Yes";
	else if corodis = "Yes" then cvd = "Yes";
	else cvd = "No";
	
proc freq data=test;
	tables cvd heartattack stroke corodis;
	
************************************************************fixing quant vars that are bad;

proc univariate data=aday.complete;
	var daysdrink bmi juice fruit beans greens orangeveg veggies strength1;

***daysdrink is fine;
***cutoff bmi @ 50 (27), juice @ 90 (3), fruit @ 120 (30), beans @ 60 (4.3), greens @ 90 (12.9), 
	orangeveg @ 60 (5), veggies @ 90 (21.5), strength1 @ 30 (0);
	
data aday.complete;
	set aday.complete;
	if bmi > 50 then bmi1 = 27;
	else if bmi < 15 then bmi1 = 27;
	else bmi1 = bmi;
	if juice > 90 then juice1 = 3;
	else juice1 = juice;
	if fruit > 120 then fruit1 = 30;
	else fruit1 = fruit;
	if beans > 60 then beans1 = 4.3;
	else beans1 = beans;
	if greens > 90 then greens1 = 12.9;
	else greens1 = greens;
	if orangeveg > 60 then orangeveg1 = 5;
	else orangeveg1 = orangeveg;
	if veggies > 90 then veggies1 = 21.5;
	else veggies1 = veggies;
	if strength1 > 30 then strength2 = 0;
	else strength2 = strength1;
	
proc univariate data=aday.complete;
	var daysdrink bmi1 juice1 fruit1 beans1 greens1 orangeveg1 veggies1 strength2;
	histogram;







