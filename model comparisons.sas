
proc freq data=aday.complete;
	tables x_imprace;
	
proc freq data=aday.complete;
	tables gender;

********************************Native;

data aday.native;
	set aday.complete;
	if x_imprace = "American Indian/Alask";

Proc Logistic data = aday.native desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") bphigh (ref="No") copd (ref="No") 
		  kiddis (ref="No") diabetes (ref="No") employed (ref="Employed for wages") gender 
		  limited (ref="No") decision (ref="No") smoker (ref="No");
	model cvd = genhlth1 persdoc bphigh copd kiddis diabetes age employed gender limited decision
				smoker;*
				/selection = backward expb
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

************c = 0.834 w/o removing vars, 0.832 when smoker, persdoc, employed removed, 974/6539 obs = Yes;

*******************************Asian;
	
data aday.asian;
	set aday.complete;
	if x_imprace = "Asian, Non-Hispanic";
	
Proc Logistic data = aday.asian desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") bphigh (ref="No") copd (ref="No") 
		  kiddis (ref="No") diabetes (ref="No") employed (ref="Employed for wages") gender 
		  limited (ref="No") decision (ref="No") smoker (ref="No");
	model cvd = genhlth1 persdoc bphigh copd kiddis diabetes age employed gender limited decision
				smoker
				/selection = backward expb
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

***********c = 0.875 w/o removing vars, 0.871 if smoker, kiddis, employed, decision, 402/7714 obs yes;

*****************************Black;
	
data aday.black;
	set aday.complete;
	if x_imprace = "Black, Non-Hispanic";
	
Proc Logistic data = aday.black desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") bphigh (ref="No") copd (ref="No") 
		  kiddis (ref="No") diabetes (ref="No") employed (ref="Employed for wages") gender 
		  limited (ref="No") decision (ref="No") smoker (ref="No");
	model cvd = genhlth1 persdoc bphigh copd kiddis diabetes age employed gender limited decision
				smoker
				/selection = backward expb
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

************c = 0.826 w/o, none left, 4437/33852 obs yes;
	
*****************************************Hispanic;

data aday.hispanic;
	set aday.complete;
	if x_imprace = "Hispanic";
	
Proc Logistic data = aday.hispanic desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") bphigh (ref="No") copd (ref="No") 
		  kiddis (ref="No") diabetes (ref="No") employed (ref="Employed for wages") gender 
		  limited (ref="No") decision (ref="No") smoker (ref="No");
	model cvd = genhlth1 persdoc bphigh copd kiddis diabetes age employed gender limited decision
				smoker
				/selection = backward expb
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

************c = 0.835 w/o, none left, 2659/30989;

****************************************white;
	
data aday.white;
	set aday.complete;
	if x_imprace = "White, Non-Hispanic";
	
Proc Logistic data = aday.white desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") bphigh (ref="No") copd (ref="No") 
		  kiddis (ref="No") diabetes (ref="No") employed (ref="Employed for wages") gender 
		  limited (ref="No") decision (ref="No") smoker (ref="No");
	model cvd = genhlth1 persdoc bphigh copd kiddis diabetes age employed gender limited decision
				smoker
				/selection = backward expb
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

************c = 0.840 w/o, none left, 41665/342346;

*************************************female;

data aday.female;
	set aday.complete;
	if gender = "Female";
	
Proc Logistic data = aday.female desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") bphigh (ref="No") copd (ref="No") 
		  kiddis (ref="No") diabetes (ref="No") employed (ref="Employed for wages") gender 
		  limited (ref="No") decision (ref="No") smoker (ref="No");
	model cvd = genhlth1 persdoc bphigh copd kiddis diabetes age employed gender limited decision
				smoker;*
				/selection = backward expb
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;
	
***********c = 0.836, gender left (duh), 27269/257999;

********************************************male;

data aday.male;
	set aday.complete;
	if gender = "Male";
	
Proc Logistic data = aday.male desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") bphigh (ref="No") copd (ref="No") 
		  kiddis (ref="No") diabetes (ref="No") employed (ref="Employed for wages") gender 
		  limited (ref="No") decision (ref="No") smoker (ref="No");
	model cvd = genhlth1 persdoc bphigh copd kiddis diabetes age employed gender limited decision
				smoker
				/selection = backward expb
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

*********c = 0.839, gender left (duh), 24225/175223;

***************************************************************individual cvd vars;

****heartattack, c=0.840, incidence = 26287/433222;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") bphigh (ref="No") copd (ref="No") 
		  kiddis (ref="No") diabetes (ref="No") employed (ref="Employed for wages") gender 
		  limited (ref="No") decision (ref="No") smoker (ref="No");
	model heartattack = genhlth1 persdoc bphigh copd kiddis diabetes age employed gender limited decision
				smoker
				/selection = backward expb
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

****stroke, c = 0.822, incidence = 18224/433222;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") bphigh (ref="No") copd (ref="No") 
		  kiddis (ref="No") diabetes (ref="No") employed (ref="Employed for wages") gender 
		  limited (ref="No") decision (ref="No") smoker (ref="No");
	model stroke = genhlth1 persdoc bphigh copd kiddis diabetes age employed gender limited decision
				smoker;*
				/selection = backward expb
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;

****corodis, c = 0.845, incidence = 26504/433222;

Proc Logistic data = aday.complete desc outest = betas outmodel=scoringdata; *PLOTS(only)=roc;
	class genhlth1 (ref="Excellent") persdoc (ref="No") bphigh (ref="No") copd (ref="No") 
		  kiddis (ref="No") diabetes (ref="No") employed (ref="Employed for wages") gender 
		  limited (ref="No") decision (ref="No") smoker (ref="No");
	model corodis = genhlth1 persdoc bphigh copd kiddis diabetes age employed gender limited decision
				smoker
				/selection = backward expb
	CTABLE pprob=(0 to 1 by .05)
	LACKFIT RISKLIMITS;	
	output out = output p = predicted;
Run;
