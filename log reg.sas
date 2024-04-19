
libname aday "/gpfs/user_home/os_home_dirs/mmccab12/Analytics Day 2024";

*************************************************************************************;
*************************FINAL MODEL*************************************************;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") bphigh (ref="No") copd (ref="No") 
		  kiddis (ref="No") diabetes (ref="No") employed (ref="Employed for wages") gender (ref="Female") 
		  limited (ref="No") decision (ref="No") smoker (ref="No");
	model cvd = genhlth1 persdoc bphigh copd kiddis diabetes age employed gender limited decision
				smoker
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

** c = 0.839, 51694/433222 yes;

*****proc logistic;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class hlthpln genhlth1 (ref="Poor") persdoc medcost1 checkup bphigh bloodcho1 skincanc othercanc asthma (ref="No") 
		  copd arthritis depress kiddis beltcomp diabetes veteran married education employed home gender
		  limited equip blind1 decision diffwalk1 diffdres1 diffalon1 smoker usenow exercise flushot6;
	model cvd = sleptim physhlth1 menthlth1 hlthpln genhlth1 persdoc medcost1 checkup bphigh bloodcho1 
				skincanc othercanc asthma copd arthritis depress kiddis beltcomp diabetes age veteran married 
				kids education employed home gender limited equip blind1 decision diffwalk1 diffdres1 
				diffalon1 smoker usenow exercise flushot6 daysdrink bmi1 juice1 fruit1 beans1 greens1 
				orangeveg1 veggies1 strength2;
				*/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

*********************out in first run for p > 0.05: orangeveg physhlth1 strength1 hlthpln othercanc kids
													usenow sleptim;
	
Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No") checkup (ref="Never") 
		  bphigh (ref="No") bloodcho1 (ref="No") skincanc (ref="No") asthma (ref="No") 
		  copd (ref="No") arthritis (ref="No") depress (ref="No") kiddis (ref="No") beltcomp (ref="Always")
		  diabetes (ref="No") veteran (ref="No") married (ref="Never marr") education 
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No") diffwalk1 (ref="No")
		  diffdres1 (ref="No") diffalon1 (ref="No") smoker (ref="No") exercise (ref="No") flushot (ref="No");
	model cvd = menthlth1 genhlth1 persdoc medcost1 checkup bphigh bloodcho1 
				skincanc asthma copd arthritis depress kiddis beltcomp diabetes age veteran married 
				education employed home gender limited equip blind1 decision diffwalk1 diffdres1 
				diffalon1 smoker exercise flushot daysdrink bmi1 juice1 fruit1 beans1 greens1
				veggies1
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

****c = 0.843;

****take out greens, caused removal of beans and vice versa, so take out both;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No") checkup (ref="Never") 
		  bphigh (ref="No") bloodcho1 (ref="No") skincanc (ref="No") asthma (ref="No") 
		  copd (ref="No") arthritis (ref="No") depress (ref="No") kiddis (ref="No") beltcomp (ref="Always")
		  diabetes (ref="No") veteran (ref="No") married (ref="Never marr") education 
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No") diffwalk1 (ref="No")
		  diffdres1 (ref="No") diffalon1 (ref="No") smoker (ref="No") exercise (ref="No") flushot (ref="No");
	model cvd = menthlth1 genhlth1 persdoc medcost1 checkup bphigh bloodcho1 
				skincanc asthma copd arthritis depress kiddis beltcomp diabetes age veteran married 
				education employed home gender limited equip blind1 decision diffwalk1 diffdres1 
				diffalon1 smoker exercise flushot daysdrink bmi1 juice1 fruit1 veggies1
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;			

***c still = 0.843;	

***take out veggies1;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No") checkup (ref="Never") 
		  bphigh (ref="No") bloodcho1 (ref="No") skincanc (ref="No") asthma (ref="No") 
		  copd (ref="No") arthritis (ref="No") depress (ref="No") kiddis (ref="No") beltcomp (ref="Always")
		  diabetes (ref="No") veteran (ref="No") married (ref="Never marr") education 
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No") diffwalk1 (ref="No")
		  diffdres1 (ref="No") diffalon1 (ref="No") smoker (ref="No") exercise (ref="No") flushot (ref="No");
	model cvd = menthlth1 genhlth1 persdoc medcost1 checkup bphigh bloodcho1 
				skincanc asthma copd arthritis depress kiddis beltcomp diabetes age veteran married 
				education employed home gender limited equip blind1 decision diffwalk1 diffdres1 
				diffalon1 smoker exercise flushot daysdrink bmi1 juice1 fruit1
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***c STILL = 0.843 >:(;

***take out diffalon1;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No") checkup (ref="Never") 
		  bphigh (ref="No") bloodcho1 (ref="No") skincanc (ref="No") asthma (ref="No") 
		  copd (ref="No") arthritis (ref="No") depress (ref="No") kiddis (ref="No") beltcomp (ref="Always")
		  diabetes (ref="No") veteran (ref="No") married (ref="Never marr") education 
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No") diffwalk1 (ref="No")
		  diffdres1 (ref="No") smoker (ref="No") exercise (ref="No") flushot (ref="No");
	model cvd = menthlth1 genhlth1 persdoc medcost1 checkup bphigh bloodcho1 
				skincanc asthma copd arthritis depress kiddis beltcomp diabetes age veteran married 
				education employed home gender limited equip blind1 decision diffwalk1 diffdres1 
				smoker exercise flushot daysdrink bmi1 juice1 fruit1
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***still 0.843;

***take out menthlth1;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No") checkup (ref="Never") 
		  bphigh (ref="No") bloodcho1 (ref="No") skincanc (ref="No") asthma (ref="No") 
		  copd (ref="No") arthritis (ref="No") depress (ref="No") kiddis (ref="No") beltcomp (ref="Always")
		  diabetes (ref="No") veteran (ref="No") married (ref="Never marr") education 
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No") diffwalk1 (ref="No")
		  diffdres1 (ref="No") smoker (ref="No") exercise (ref="No") flushot (ref="No");
	model cvd = genhlth1 persdoc medcost1 checkup bphigh bloodcho1 
				skincanc asthma copd arthritis depress kiddis beltcomp diabetes age veteran married 
				education employed home gender limited equip blind1 decision diffwalk1 diffdres1 
				smoker exercise flushot daysdrink bmi1 juice1 fruit1
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***still 0.843, take out skincanc;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No") checkup (ref="Never") 
		  bphigh (ref="No") bloodcho1 (ref="No") asthma (ref="No") 
		  copd (ref="No") arthritis (ref="No") depress (ref="No") kiddis (ref="No") beltcomp (ref="Always")
		  diabetes (ref="No") veteran (ref="No") married (ref="Never marr") education 
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No") diffwalk1 (ref="No")
		  diffdres1 (ref="No") smoker (ref="No") exercise (ref="No") flushot (ref="No");
	model cvd = genhlth1 persdoc medcost1 checkup bphigh bloodcho1 
				asthma copd arthritis depress kiddis beltcomp diabetes age veteran married 
				education employed home gender limited equip blind1 decision diffwalk1 diffdres1 
				smoker exercise flushot daysdrink bmi1 juice1 fruit1
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***still 0.843, take out exercise;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No") checkup (ref="Never") 
		  bphigh (ref="No") bloodcho1 (ref="No") asthma (ref="No") 
		  copd (ref="No") arthritis (ref="No") depress (ref="No") kiddis (ref="No") beltcomp (ref="Always")
		  diabetes (ref="No") veteran (ref="No") married (ref="Never marr") education 
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No") diffwalk1 (ref="No")
		  diffdres1 (ref="No") smoker (ref="No") flushot (ref="No");
	model cvd = genhlth1 persdoc medcost1 checkup bphigh bloodcho1 
				asthma copd arthritis depress kiddis beltcomp diabetes age veteran married 
				education employed home gender limited equip blind1 decision diffwalk1 diffdres1 
				smoker flushot daysdrink bmi1 juice1 fruit1
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***still 0.843, take out fruit1;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No") checkup (ref="Never") 
		  bphigh (ref="No") bloodcho1 (ref="No") asthma (ref="No") 
		  copd (ref="No") arthritis (ref="No") depress (ref="No") kiddis (ref="No") beltcomp (ref="Always")
		  diabetes (ref="No") veteran (ref="No") married (ref="Never marr") education 
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No") diffwalk1 (ref="No")
		  diffdres1 (ref="No") smoker (ref="No") flushot (ref="No");
	model cvd = genhlth1 persdoc medcost1 checkup bphigh bloodcho1 
				asthma copd arthritis depress kiddis beltcomp diabetes age veteran married 
				education employed home gender limited equip blind1 decision diffwalk1 diffdres1 
				smoker flushot daysdrink bmi1 juice1
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***all <0.001, still 0.843, take out diffdres1;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No") checkup (ref="Never") 
		  bphigh (ref="No") bloodcho1 (ref="No") asthma (ref="No") 
		  copd (ref="No") arthritis (ref="No") depress (ref="No") kiddis (ref="No") beltcomp (ref="Always")
		  diabetes (ref="No") veteran (ref="No") married (ref="Never marr") education 
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No") diffwalk1 (ref="No")
		  smoker (ref="No") flushot (ref="No");
	model cvd = genhlth1 persdoc medcost1 checkup bphigh bloodcho1 
				asthma copd arthritis depress kiddis beltcomp diabetes age veteran married 
				education employed home gender limited equip blind1 decision diffwalk1
				smoker flushot daysdrink bmi1 juice1
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***still 0.843, take out flushot;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No") checkup (ref="Never") 
		  bphigh (ref="No") bloodcho1 (ref="No") asthma (ref="No") 
		  copd (ref="No") arthritis (ref="No") depress (ref="No") kiddis (ref="No") beltcomp (ref="Always")
		  diabetes (ref="No") veteran (ref="No") married (ref="Never marr") education 
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No") diffwalk1 (ref="No")
		  smoker (ref="No");
	model cvd = genhlth1 persdoc medcost1 checkup bphigh bloodcho1 
				asthma copd arthritis depress kiddis beltcomp diabetes age veteran married 
				education employed home gender limited equip blind1 decision diffwalk1
				smoker daysdrink bmi1 juice1
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***still 0.843, TAKE OUT BMI????????;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No") checkup (ref="Never") 
		  bphigh (ref="No") bloodcho1 (ref="No") asthma (ref="No") 
		  copd (ref="No") arthritis (ref="No") depress (ref="No") kiddis (ref="No") beltcomp (ref="Always")
		  diabetes (ref="No") veteran (ref="No") married (ref="Never marr") education 
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No") diffwalk1 (ref="No")
		  smoker (ref="No") flushot (ref="No");
	model cvd = genhlth1 persdoc medcost1 checkup bphigh bloodcho1 
				asthma copd arthritis depress kiddis beltcomp diabetes age veteran married 
				education employed home gender limited equip blind1 decision diffwalk1
				smoker flushot daysdrink juice1
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***still 0.843, take out arthritis;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No") checkup (ref="Never") 
		  bphigh (ref="No") bloodcho1 (ref="No") asthma (ref="No") 
		  copd (ref="No") depress (ref="No") kiddis (ref="No") beltcomp (ref="Always")
		  diabetes (ref="No") veteran (ref="No") married (ref="Never marr") education 
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No") diffwalk1 (ref="No")
		  smoker (ref="No") flushot (ref="No");
	model cvd = genhlth1 persdoc medcost1 checkup bphigh bloodcho1 
				asthma copd depress kiddis beltcomp diabetes age veteran married 
				education employed home gender limited equip blind1 decision diffwalk1
				smoker flushot daysdrink juice1
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

****still 0.843, take out flushot;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No") checkup (ref="Never") 
		  bphigh (ref="No") bloodcho1 (ref="No") asthma (ref="No") 
		  copd (ref="No") depress (ref="No") kiddis (ref="No") beltcomp (ref="Always")
		  diabetes (ref="No") veteran (ref="No") married (ref="Never marr") education 
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No") diffwalk1 (ref="No")
		  smoker (ref="No");
	model cvd = genhlth1 persdoc medcost1 checkup bphigh bloodcho1 
				asthma copd depress kiddis beltcomp diabetes age veteran married 
				education employed home gender limited equip blind1 decision diffwalk1
				smoker daysdrink juice1
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***still 0.843, take out beltcomp;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No") checkup (ref="Never") 
		  bphigh (ref="No") bloodcho1 (ref="No") asthma (ref="No") 
		  copd (ref="No") depress (ref="No") kiddis (ref="No")
		  diabetes (ref="No") veteran (ref="No") married (ref="Never marr") education 
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No") diffwalk1 (ref="No")
		  smoker (ref="No");
	model cvd = genhlth1 persdoc medcost1 checkup bphigh bloodcho1 
				asthma copd depress kiddis diabetes age veteran married 
				education employed home gender limited equip blind1 decision diffwalk1
				smoker daysdrink juice1
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***what happens when you take out genhlth1? takes c down to 0.835;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class persdoc (ref="No") medcost1 (ref="No") checkup (ref="Never") 
		  bphigh (ref="No") bloodcho1 (ref="No") asthma (ref="No") 
		  copd (ref="No") depress (ref="No") kiddis (ref="No")
		  diabetes (ref="No") veteran (ref="No") married (ref="Never marr") education 
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No") diffwalk1 (ref="No")
		  smoker (ref="No");
	model cvd = persdoc medcost1 checkup bphigh bloodcho1 
				asthma copd depress kiddis diabetes age veteran married 
				education employed home gender limited equip blind1 decision diffwalk1
				smoker daysdrink juice1
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***put it back in, still 0.843, take out juice1;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No") checkup (ref="Never") 
		  bphigh (ref="No") bloodcho1 (ref="No") asthma (ref="No") 
		  copd (ref="No") depress (ref="No") kiddis (ref="No")
		  diabetes (ref="No") veteran (ref="No") married (ref="Never marr") education 
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No") diffwalk1 (ref="No")
		  smoker (ref="No");
	model cvd = genhlth1 persdoc medcost1 checkup bphigh bloodcho1 
				asthma copd depress kiddis diabetes age veteran married 
				education employed home gender limited equip blind1 decision diffwalk1
				smoker daysdrink
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***still 0.843, take out education;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No") checkup (ref="Never") 
		  bphigh (ref="No") bloodcho1 (ref="No") asthma (ref="No") 
		  copd (ref="No") depress (ref="No") kiddis (ref="No")
		  diabetes (ref="No") veteran (ref="No") married (ref="Never marr") 
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No") diffwalk1 (ref="No")
		  smoker (ref="No");
	model cvd = genhlth1 persdoc medcost1 checkup bphigh bloodcho1 
				asthma copd depress kiddis diabetes age veteran married 
				employed home gender limited equip blind1 decision diffwalk1
				smoker daysdrink
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***down to 0.842, take out asthma;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No") checkup (ref="Never") 
		  bphigh (ref="No") bloodcho1 (ref="No")
		  copd (ref="No") depress (ref="No") kiddis (ref="No")
		  diabetes (ref="No") veteran (ref="No") married (ref="Never marr") 
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No") diffwalk1 (ref="No")
		  smoker (ref="No");
	model cvd = genhlth1 persdoc medcost1 checkup bphigh bloodcho1 
				copd depress kiddis diabetes age veteran married 
				employed home gender limited equip blind1 decision diffwalk1
				smoker daysdrink
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***still 0.842, take out married;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No") checkup (ref="Never") 
		  bphigh (ref="No") bloodcho1 (ref="No")
		  copd (ref="No") depress (ref="No") kiddis (ref="No")
		  diabetes (ref="No") veteran (ref="No")
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No") diffwalk1 (ref="No")
		  smoker (ref="No");
	model cvd = genhlth1 persdoc medcost1 checkup bphigh bloodcho1 
				copd depress kiddis diabetes age veteran 
				employed home gender limited equip blind1 decision diffwalk1
				smoker daysdrink
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***still 0.842, take out veteran;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No") checkup (ref="Never") 
		  bphigh (ref="No") bloodcho1 (ref="No")
		  copd (ref="No") depress (ref="No") kiddis (ref="No")
		  diabetes (ref="No")
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No") diffwalk1 (ref="No")
		  smoker (ref="No");
	model cvd = genhlth1 persdoc medcost1 checkup bphigh bloodcho1 
				copd depress kiddis diabetes age
				employed home gender limited equip blind1 decision diffwalk1
				smoker daysdrink
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***still 0.842, take out diffwalk1;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No") checkup (ref="Never") 
		  bphigh (ref="No") bloodcho1 (ref="No")
		  copd (ref="No") depress (ref="No") kiddis (ref="No")
		  diabetes (ref="No")
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No")
		  smoker (ref="No");
	model cvd = genhlth1 persdoc medcost1 checkup bphigh bloodcho1 
				copd depress kiddis diabetes age
				employed home gender limited equip blind1 decision
				smoker daysdrink
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***still 0.842, take out depress;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No") checkup (ref="Never") 
		  bphigh (ref="No") bloodcho1 (ref="No")
		  copd (ref="No") kiddis (ref="No")
		  diabetes (ref="No")
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No")
		  smoker (ref="No");
	model cvd = genhlth1 persdoc medcost1 checkup bphigh bloodcho1 
				copd kiddis diabetes age
				employed home gender limited equip blind1 decision
				smoker daysdrink
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***still 0.842, take out daysdrink;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No") checkup (ref="Never") 
		  bphigh (ref="No") bloodcho1 (ref="No")
		  copd (ref="No") kiddis (ref="No")
		  diabetes (ref="No")
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No")
		  smoker (ref="No");
	model cvd = genhlth1 persdoc medcost1 checkup bphigh bloodcho1 
				copd kiddis diabetes age
				employed home gender limited equip blind1 decision
				smoker
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***down to 0.841, take out checkup;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No")
		  bphigh (ref="No") bloodcho1 (ref="No")
		  copd (ref="No") kiddis (ref="No")
		  diabetes (ref="No")
		  employed (ref="Employed for wages") home (ref="Own") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No")
		  smoker (ref="No");
	model cvd = genhlth1 persdoc medcost1 bphigh bloodcho1 
				copd kiddis diabetes age
				employed home gender limited equip blind1 decision
				smoker
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***still 0.841, take out home;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No")
		  bphigh (ref="No") bloodcho1 (ref="No")
		  copd (ref="No") kiddis (ref="No")
		  diabetes (ref="No")
		  employed (ref="Employed for wages") gender 
		  limited (ref="No") equip (ref="No") blind1 (ref="No") decision (ref="No")
		  smoker (ref="No");
	model cvd = genhlth1 persdoc medcost1 bphigh bloodcho1 
				copd kiddis diabetes age
				employed gender limited equip blind1 decision
				smoker
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***still 0.841, take out blind1;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") medcost1 (ref="No")
		  bphigh (ref="No") bloodcho1 (ref="No")
		  copd (ref="No") kiddis (ref="No")
		  diabetes (ref="No")
		  employed (ref="Employed for wages") gender 
		  limited (ref="No") equip (ref="No") decision (ref="No")
		  smoker (ref="No");
	model cvd = genhlth1 persdoc medcost1 bphigh bloodcho1 
				copd kiddis diabetes age
				employed gender limited equip decision
				smoker
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***down to 0.840, take out medcost1;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No")
		  bphigh (ref="No") bloodcho1 (ref="No")
		  copd (ref="No") kiddis (ref="No")
		  diabetes (ref="No")
		  employed (ref="Employed for wages") gender 
		  limited (ref="No") equip (ref="No") decision (ref="No")
		  smoker (ref="No");
	model cvd = genhlth1 persdoc bphigh bloodcho1 
				copd kiddis diabetes age
				employed gender limited equip decision
				smoker
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***still 0.840, take out equip;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No")
		  bphigh (ref="No") bloodcho1 (ref="No")
		  copd (ref="No") kiddis (ref="No")
		  diabetes (ref="No")
		  employed (ref="Employed for wages") gender 
		  limited (ref="No") decision (ref="No")
		  smoker (ref="No");
	model cvd = genhlth1 persdoc bphigh bloodcho1 
				copd kiddis diabetes age
				employed gender limited decision
				smoker
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***down to 0.839, = to # vars in ascvd, what does removing genhlth1 do? down to 0.829;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class persdoc (ref="No")
		  bphigh (ref="No") bloodcho1 (ref="No")
		  copd (ref="No") kiddis (ref="No")
		  diabetes (ref="No")
		  employed (ref="Employed for wages") gender 
		  limited (ref="No") decision (ref="No")
		  smoker (ref="No");
	model cvd = persdoc bphigh bloodcho1 
				copd kiddis diabetes age
				employed gender limited decision
				smoker
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***keep for now, take out bloodcho1; 

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No")
		  bphigh (ref="No")
		  copd (ref="No") kiddis (ref="No")
		  diabetes (ref="No")
		  employed (ref="Employed for wages") gender 
		  limited (ref="No") decision (ref="No")
		  smoker (ref="No");
	model cvd = genhlth1 persdoc bphigh 
				copd kiddis diabetes age
				employed gender limited decision
				smoker
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***still 0.839, take out persdoc;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent")
		  bphigh (ref="No")
		  copd (ref="No") kiddis (ref="No")
		  diabetes (ref="No")
		  employed (ref="Employed for wages") gender 
		  limited (ref="No") decision (ref="No")
		  smoker (ref="No");
	model cvd = genhlth1 bphigh 
				copd kiddis diabetes age
				employed gender limited decision
				smoker
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***down to 0.838, stop above removing persdoc;

***what does removing genhlth1 do now? down to 0.828, so pretty consistent;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class persdoc (ref="No")
		  bphigh (ref="No")
		  copd (ref="No") kiddis (ref="No")
		  diabetes (ref="No")
		  employed (ref="Employed for wages") gender 
		  limited (ref="No") decision (ref="No")
		  smoker (ref="No");
	model cvd = persdoc bphigh 
				copd kiddis diabetes age
				employed gender limited decision
				smoker
				/selection = backward expb 
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

********odds ratios are under "Odds Ratio Estimates and Wald Confidence Intervals" "estimates";
	
********for cat vars, odds ratio compared to reference group
	****if =1, same chance;
	****if <1, then it is "(1-estimate)% less likely than [baseline group]"
	****if >1, then it is "(estimate-1)% more likely than [baseline group]"
	
*******for quant, each is odds ratio increase PER UNIT;
		***exponential, so raise odds ratio to unit multiplier, not multiply;

proc freq data=aday.complete;
	tables persdoc*medcost1 / chisq;
	
	
proc print data=aday.complete (obs=234 firstobs=234);
	var genhlth1 copd diabetes;	
	