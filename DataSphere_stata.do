
* Defining the path to databases
global data2p0 				"PATH TO DATA 2.0"
global data3p0 				"PATH TO DATA 3.0"
global data 				"PATH TO DATA 4.0"
global DestinationFolder 	"PATH TO DESTINATION FOLDER"


***************************************************************************************
/** Databases

1. abcd_cbcls01: 			Baseline - summary scores 
2. abcd_cbcl01: 			Baseline - raw data/CBCL
3. abcd_yksad01: 			Youth Diagnostic Interview for DSM-5 Background Items 5 (KSADS-5)
4. dibf01: 					Parent Diagnostic Interview for DSM-5 Background Items Full (KSADS-5)
5. abcd_ant01: 				Youth Anthropometrics Modified From PhenX
6. acspsw03: 				Data on Weights
7. abcd_lt01:				Site ID
8. abcd_ydmes01:			Youth discrimination
9. abcd_bisbas01: 			Youth Behavioral Inhibition/Behavioral Approach System Scales Modified from PhenX (BIS/BAS)
10. abcd_smrip101:			Structural MRI - Cortical and subcortical structures (and abcd_smrip201)
11. crpbi01:	 			Parental Acceptance 
12. pdem02: 				Demographic data
13. abcd_mhy02:				Children's mental health summary scores
14. abcd_mhp02: 			Mental health summary scores, parent surveys
15. abcd_asrs01: 			Parents mental health (summary)
16. abcd_fes01: 			Family conflict
17. abcd_pssrs01: 			Parent Short Social Responsiveness Scale (Difficulty relating to peers and is regarded by other children as odd or weird)
18. abcd_pksadscd01:		Parent KSADS Conduct Disorder (Bully others in the last two weeks): In the past two weeks, how often did your child make fun of other kids?
19. abcd_ytbpai01: 			Positive emotions and affective well-being in past week (6, 12, and 18 months follow-up, subsample)
20. abcd_ywpss01: 			Children's will to problem solving (one-year follow-up)
21. psb01:					Parent prosocial behavior surveys
22. abcd_psb01:				Youth prosocial behavior survey
23. abcd_yrb01:				Physical activity (3 indicators)
24. abcd_saiq02:			Involvement in sport activities
25. abcd_ksad01: 			Mental Health - Symptoms and Diagnoses Parents
26. abcd_ksad501: 			Mental Health - Symptoms and Diagnoses Youth
27. pps01:					Prodromal Psychosis Scale
28. abcd_tbss01:			Youth NIH TB Summary Scores (Fluid, crystallized, and total cognitive abilities)
29. abcd_sss01: 			Variety of summary/composite scores: SES, social, and perinatal
30. abcd_nsc01:				Neighboorhood safety
31. abcd_mx01: 				Medical History Questionnaire (MHX)
32. abcd_lpmh01:			Longitudinal Medical History Questionnaire
33. abcd_adbc01:			Adult Behavior Checklist
34. srpf01:					School Risk and Protective Factors Survey
35. pmq01:					Parental Monitoring Survey
36. abcd_ptsd01: 			Parent Diagnostic Interview for DSM-5 (KSADS) Traumatic Events
37. abcd_fhxssp01:			Parent Family History Summary Scores
38. medsy01: 				Medications Survey Inventory Modified from PhenX (PMP)
39. abcd_sds01:				Parent Sleep Disturbance Scale for Children (SDS)
40. abcd_eatqp01:			Early Adolescent Temperament Questionnaire
41. abcd_suss01:			Summary Scores Substance Use
42. abcd_ysu02:				Youth Substance Use Interview
43. abcd_ysuip01:			Youth Substance Use Introduction and Patterns (follow-up)
44. abcd_ps01:				Pearson Scores - Rey Auditory Verbal Learning Test, Matrix Reasoning Test, and Rey Delayed Recall Test
45. abcd_mrinback02:		Behavioral performance measures for nBack task fMRI (working memory)
46. abcd_ple01:				Parent Life Events
47. abcd_yle01:				Youth Life Events
48. abcd_pbp01:				Youth Peer Behavior Profile
49. abcd_pnhps01:			Youth Peer Network Health Protective Scaler
50. abcd_yssbpm01:			Youth Summary Scores BPM and POA
51. abcd_lpksad01:			Parent Diagnostic Interview for DSM-5 Background Items Full (KSAD) - follow-up
52. abcd_socdev_p_emr01:	Social Development Parent Difficulties in Emotion Regulation
53. abcd_socdev_child_emr01:Child Difficulties in Emotion Regulation
54. abcd_yest01:			Youth Emotional Stroop Task
55. abcd_esttlb01:			Emotional Stroop Task Trial Level Behavior
56. abcd_pxccp01:			Parent PhenX Community Cohesion
57. abcd_ysr01:				Other Resilience (Close friends)
58. abcd_rhds01: 			Residential History Derived Scores
59. abcd_socdev_p_nbh01:	Social Development Parent Neighborhood
60. abcd_socdev_p_nbh01:	Social Development Parent Neighborhood
61. abcd_pasrs01: 			Parents mental health (items)

**/

**************************************************************************************
**************************************** 1 *******************************************
**************************************************************************************

**** Loading data on CBCL - Summary
clear
import delimited "$data\abcd_cbcls01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname											///
		cbcl_scr_syn_anxdep_r cbcl_scr_syn_withdep_r cbcl_scr_syn_somatic_r 		///
		cbcl_scr_syn_social_r cbcl_scr_syn_thought_r cbcl_scr_syn_attention_r 		///
		cbcl_scr_syn_rulebreak_r cbcl_scr_syn_aggressive_r cbcl_scr_syn_internal_r 	///
		cbcl_scr_syn_external_r cbcl_scr_syn_totprob_r cbcl_scr_dsm5_depress_r 		///
		cbcl_scr_dsm5_anxdisord_r cbcl_scr_dsm5_somaticpr_r cbcl_scr_dsm5_adhd_r 	///
		cbcl_scr_dsm5_opposit_r cbcl_scr_dsm5_conduct_r cbcl_scr_07_sct_r 			///
		cbcl_scr_07_ocd_r cbcl_scr_07_stress_r										///
		cbcl_scr_syn_anxdep_t cbcl_scr_syn_withdep_t cbcl_scr_syn_somatic_t 		///
		cbcl_scr_syn_social_t cbcl_scr_syn_thought_t cbcl_scr_syn_attention_t 		///
		cbcl_scr_syn_rulebreak_t cbcl_scr_syn_aggressive_t cbcl_scr_syn_internal_t 	///
		cbcl_scr_syn_external_t cbcl_scr_syn_totprob_t cbcl_scr_dsm5_depress_t 		///
		cbcl_scr_dsm5_anxdisord_t cbcl_scr_dsm5_somaticpr_t cbcl_scr_dsm5_adhd_t 	///
		cbcl_scr_dsm5_opposit_t cbcl_scr_dsm5_conduct_t cbcl_scr_07_sct_t 			///
		cbcl_scr_07_ocd_t cbcl_scr_07_stress_t
		
		
tempfile cbclsum
save `cbclsum'



**** Loading the database
clear
import delimited "$data\abcd_cbcl01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1


** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


**************************************************************************************
**************************************** 2 *******************************************
**************************************************************************************
** CBCL profile

*******************
*Syndrome scales - 	Anxious/Depressed, Withdrawn/Depressed, Somatic Complaints -> Internalizing Behavior
*+					Social problems, Thought Problems, Attention Problems
*+					Rul-Breaking Behavior, Aggressive Behavior -> Externalizing Behavior


global anxdepress2 		"cbcl_q14_p cbcl_q29_p cbcl_q30_p cbcl_q31_p cbcl_q32_p cbcl_q33_p cbcl_q35_p cbcl_q45_p cbcl_q50_p cbcl_q52_p cbcl_q71_p cbcl_q91_p cbcl_q112_p"
global withdranx 		"cbcl_q05_p cbcl_q42_p cbcl_q65_p cbcl_q69_p cbcl_q75_p cbcl_q102_p cbcl_q103_p cbcl_q111_p"
global somatic1 		"cbcl_q47_p cbcl_q49_p cbcl_q51_p cbcl_q54_p cbcl_q56a_p cbcl_q56b_p cbcl_q56c_p cbcl_q56d_p cbcl_q56e_p cbcl_q56f_p cbcl_q56g_p"
global internalizing 	$anxdepress2 $withdranx $somatic1
global socialprob		"cbcl_q11_p cbcl_q12_p cbcl_q25_p cbcl_q27_p cbcl_q34_p cbcl_q36_p cbcl_q38_p cbcl_q48_p cbcl_q62_p cbcl_q64_p cbcl_q79_p"
global thoughtprob		"cbcl_q09_p cbcl_q18_p cbcl_q40_p cbcl_q46_p cbcl_q58_p cbcl_q59_p cbcl_q60_p cbcl_q66_p cbcl_q70_p cbcl_q76_p cbcl_q83_p cbcl_q84_p cbcl_q85_p cbcl_q92_p cbcl_q100_p"
global attentionprob	"cbcl_q01_p cbcl_q04_p cbcl_q08_p cbcl_q10_p cbcl_q13_p cbcl_q17_p cbcl_q41_p cbcl_q61_p cbcl_q78_p cbcl_q80_p"
global rulebreaker		"cbcl_q02_p cbcl_q26_p cbcl_q28_p cbcl_q39_p cbcl_q43_p cbcl_q63_p cbcl_q67_p cbcl_q72_p cbcl_q73_p cbcl_q81_p cbcl_q82_p cbcl_q90_p cbcl_q96_p cbcl_q99_p cbcl_q101_p cbcl_q105_p cbcl_q106_p"
global aggressive		"cbcl_q03_p cbcl_q16_p cbcl_q19_p cbcl_q20_p cbcl_q21_p cbcl_q22_p cbcl_q23_p cbcl_q37_p cbcl_q57_p cbcl_q68_p cbcl_q86_p cbcl_q87_p cbcl_q88_p cbcl_q89_p cbcl_q94_p cbcl_q95_p cbcl_q97_p cbcl_q104_p"
global externalizing	$rulebreaker $aggressive

****************
** CBCL Score 1: Summing across all responses
egen cbcl_anxdep1 = rowtotal($anxdepress2)
egen cbcl_witanx1 = rowtotal($withdranx)
egen cbcl_somatc1 = rowtotal($somatic1)
egen cbcl_intern1 = rowtotal($internalizing)
egen cbcl_social1 = rowtotal($socialprob)
egen cbcl_though1 = rowtotal($thoughtprob)
egen cbcl_attent1 = rowtotal($attentionprob)
egen cbcl_rulebr1 = rowtotal($rulebreaker)
egen cbcl_aggres1 = rowtotal($aggressive)
egen cbcl_extern1 = rowtotal($externalizing)

****************
** CBCL Score 2: Summing across dichotomized responses (Not true = 0; often or sometimes true = 1)
foreach v of varlist $anxdepress2 $withdranx $somatic1 $socialprob $thoughtprob $attentionprob $rulebreaker $aggressive {
	rename `v' `v'temp
	gen `v' = cond(`v'temp>=1,1,0)
}

egen cbcl_anxdep2 = rowtotal($anxdepress2)
egen cbcl_witanx2 = rowtotal($withdranx)
egen cbcl_somatc2 = rowtotal($somatic1)
egen cbcl_intern2 = rowtotal($internalizing)
egen cbcl_social2 = rowtotal($socialprob)
egen cbcl_though2 = rowtotal($thoughtprob)
egen cbcl_attent2 = rowtotal($attentionprob)
egen cbcl_rulebr2 = rowtotal($rulebreaker)
egen cbcl_aggres2 = rowtotal($aggressive)
egen cbcl_extern2 = rowtotal($externalizing)

foreach v of varlist $anxdepress2 $withdranx $somatic1 $socialprob $thoughtprob $attentionprob $rulebreaker $aggressive {
	drop `v'
	rename `v'temp `v'
}

****************
** CBCL Score 3: Principal Component analysis
pca $anxdepress2
predict cbcl_anxdep3
pca $withdranx
predict cbcl_witanx3
pca $somatc1
predict cbcl_somatc3
pca $internalizing
predict cbcl_intern3
pca $socialprob
predict cbcl_social3
pca $thoughtprob
predict cbcl_though3
pca $attentionprob
predict cbcl_attent3
pca $rulebreaker
predict cbcl_rulebr3
pca $aggressive
predict cbcl_aggres3
pca $externalizing
predict cbcl_extern3

****************
** DMS Score 4: Percentile of CBCL Score 1

foreach v in cbcl_anxdep cbcl_witanx cbcl_somatc cbcl_intern cbcl_social cbcl_though cbcl_attent cbcl_rulebr cbcl_aggres cbcl_extern {
	xtile 	`v'4a = `v'1 if eventname=="baseline_year_1_arm_1", nq(100) 
	xtile 	`v'4b = `v'1 if eventname=="1_year_follow_up_y_arm_1", nq(100) 
	xtile 	`v'4c = `v'1 if eventname=="2_year_follow_up_y_arm_1", nq(100) 
	gen 	`v'4 = `v'4a if eventname=="baseline_year_1_arm_1"
	replace	`v'4 = `v'4b if eventname=="1_year_follow_up_y_arm_1"
	replace	`v'4 = `v'4c if eventname=="2_year_follow_up_y_arm_1"
	drop `v'4a `v'4b `v'4c
}

**************************************************************************************
**************************************************************************************
** DSM Oriented Scales - Depressive Problems, Anxiety Problems, Somatic Problems,
*+						Oppositional Defiant Problems, Conduct Problems

global depressive 		"cbcl_q05_p cbcl_q14_p cbcl_q18_p cbcl_q24_p cbcl_q35_p cbcl_q52_p cbcl_q54_p cbcl_q76_p cbcl_q77_p cbcl_q91_p cbcl_q100_p cbcl_q102_p cbcl_q103_p"
global anxious 			"cbcl_q11_p cbcl_q29_p cbcl_q30_p cbcl_q31_p cbcl_q45_p cbcl_q47_p cbcl_q50_p cbcl_q71_p cbcl_q112_p"
global somatic2 		"cbcl_q56a_p cbcl_q56b_p cbcl_q56c_p cbcl_q56d_p cbcl_q56e_p cbcl_q56f_p cbcl_q56g_p"
global attentiondef 	"cbcl_q04_p cbcl_q08_p cbcl_q10_p cbcl_q41_p cbcl_q78_p cbcl_q93_p cbcl_q104_p"
global oppositional 	"cbcl_q03_p cbcl_q22_p cbcl_q23_p cbcl_q86_p cbcl_q95_p"
global conductprob		"cbcl_q15_p cbcl_q16_p cbcl_q21_p cbcl_q26_p cbcl_q28_p cbcl_q37_p cbcl_q39_p cbcl_q43_p cbcl_q57_p cbcl_q67_p cbcl_q72_p cbcl_q81_p cbcl_q82_p cbcl_q90_p cbcl_q97_p cbcl_q101_p cbcl_q106_p"

****************
** DMS Score 1: Summing across all responses
egen dms_depres1 = rowtotal($depressive)
egen dms_anxiou1 = rowtotal($anxious)
egen dms_somati1 = rowtotal($somatic2)
egen dms_attent1 = rowtotal($attentiondef)
egen dms_opposi1 = rowtotal($oppositional)
egen dms_conduc1 = rowtotal($conductprob)

****************
** DMS Score 2: Summing across dichotomized responses (Not true = 0; often or sometimes true = 1)
foreach v of varlist $depressive $anxious $somatic2 $attentiondef $oppositional $conductprob {
	rename `v' `v'temp
	gen `v' = cond(`v'temp>=1,1,0)
}

egen dms_depres2 = rowtotal($depressive)
egen dms_anxiou2 = rowtotal($anxious)
egen dms_somati2 = rowtotal($somatic2)
egen dms_attent2 = rowtotal($attentiondef)
egen dms_opposi2 = rowtotal($oppositional)
egen dms_conduc2 = rowtotal($conductprob)

foreach v of varlist $depressive $anxious $somatic2 $attentiondef $oppositional $conductprob {
	drop `v'
	rename `v'temp `v'
}

****************
** DMS Score 3: Principal Component analysis
pca $depressive 
predict dms_depres3
pca $anxious 
predict dms_anxiou3
pca $somatic2 
predict dms_somati3
pca $attentiondef 
predict dms_attent3
pca $oppositional 
predict dms_opposi3
pca $conductprob
predict dms_conduc3

****************
** DMS Score 4: Percentile of DMS Score 1 (Check do-file accountability paper - PSU)

foreach v in dms_depres dms_anxiou dms_somati dms_attent dms_opposi dms_conduc {
	xtile 	`v'4a = `v'1 if eventname=="baseline_year_1_arm_1", nq(100) 
	xtile 	`v'4b = `v'1 if eventname=="1_year_follow_up_y_arm_1", nq(100) 
	xtile 	`v'4c = `v'1 if eventname=="2_year_follow_up_y_arm_1", nq(100) 
	gen 	`v'4 = `v'4a if eventname=="baseline_year_1_arm_1"
	replace	`v'4 = `v'4b if eventname=="1_year_follow_up_y_arm_1"
	replace	`v'4 = `v'4c if eventname=="2_year_follow_up_y_arm_1"
	drop `v'4a `v'4b `v'4c
}

rename sex gender

keep subjectkey src_subject_id interview_date interview_age gender eventname		///
		$socialprob $rulebreaker $aggressive $oppositional $conductprob 			///
		$depressive $anxious $somatic2 $attentiondef $oppositional $conductprob		///
		dms_depres1 dms_anxiou1 dms_somati1 dms_attent1 dms_opposi1 dms_conduc1		///
		dms_depres2 dms_anxiou2 dms_somati2 dms_attent2 dms_opposi2 dms_conduc2		///
		cbcl_anxdep1 cbcl_witanx1 cbcl_somatc1 $anxdepress2 $withdranx $somatic1 	///
		$internalizing cbcl_anxdep2 cbcl_witanx2 cbcl_somatc2

		
tempfile cbclsc
save `cbclsc'


**************************************************************************************
**************************************** 3 *******************************************
**************************************************************************************
**** Loading data on problems with bullyings, youth
clear
import delimited "$data\abcd_yksad01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname											///
		ksads_bully_raw_26 kbi_y_sex_orient kbi_y_sex_orient_probs kbi_y_trans_id 	///
		kbi_y_trans_prob
		
		
tempfile bullyy
save `bullyy'


**************************************************************************************
**************************************** 4 *******************************************
**************************************************************************************
**** Loading data on problems with bullyings, parents
clear
import delimited "$data\dibf01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname											///
		kbi_p_c_bully kbi_p_conflict kbi_p_c_age_services 							///
		kbi_p_c_age_services_bl_dk kbi_p_c_best_friend kbi_p_c_best_friend_len		///
		kbi_p_c_gay kbi_p_c_gay_problems kbi_p_c_trans kbi_p_c_trans_problems		///
		kbi_p_c_reg_friend_group_len kbi_ss_c_mental_health_p  						///
		kbi_p_c_school_setting kbi_p_c_spec_serv___1 kbi_p_c_spec_serv___2			///
		kbi_p_c_spec_serv___3 kbi_p_c_spec_serv___4 kbi_p_c_spec_serv___5			///
		kbi_p_c_spec_serv___6 kbi_p_c_spec_serv___7 kbi_p_c_spec_serv___8			///
		kbi_p_c_spec_serv___9 kbi_p_c_spec_serv___10 kbi_p_c_scheck7

		
tempfile bullyp
save `bullyp'


**************************************************************************************
**************************************** 5 *******************************************
**************************************************************************************
**** Loading data on Youth Anthropometrics Modified From PhenX
clear
import delimited "$data\abcd_ant01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day

gen bodyw_kg 	=  anthroweightcalc/2.205
gen bodyh_m 	=  anthroheightcalc/39.37

gen 	bmi =  bodyw_kg/(bodyh_m^2)
replace bmi = . if bmi>55

* Definition of obsesity for Children and teens: https://www.cdc.gov/obesity/childhood/defining.html

sum bmi if eventname=="baseline_year_1_arm_1", detail
_pctile bmi if eventname=="baseline_year_1_arm_1", percentiles(5,85,95)

gen undr_weight = cond(bmi<=r(r1),1,0) 					if eventname=="baseline_year_1_arm_1"
gen norm_weight = cond(bmi>r(r1) & bmi<=r(r2),1,0)		if eventname=="baseline_year_1_arm_1"
gen over_weight = cond(bmi>r(r2) & bmi<r(r3),1,0)		if eventname=="baseline_year_1_arm_1"
gen obes_weight = cond(bmi>=r(r3) & bmi<.,1,0)			if eventname=="baseline_year_1_arm_1"

sum bmi if eventname=="1_year_follow_up_y_arm_1", detail
_pctile bmi if eventname=="1_year_follow_up_y_arm_1", percentiles(5,85,95)

replace undr_weight = cond(bmi<=r(r1),1,0) 					if eventname=="1_year_follow_up_y_arm_1"
replace norm_weight = cond(bmi>r(r1) & bmi<=r(r2),1,0)		if eventname=="1_year_follow_up_y_arm_1"
replace over_weight = cond(bmi>r(r2) & bmi<r(r3),1,0)		if eventname=="1_year_follow_up_y_arm_1"
replace obes_weight = cond(bmi>=r(r3) & bmi<.,1,0)			if eventname=="1_year_follow_up_y_arm_1"


keep 	subjectkey src_subject_id eventname											///
		anthroheightcalc anthroweightcalc anthro_waist_cm undr_weight norm_weight	///
		over_weight obes_weight bodyw_kg bodyh_m bmi
		
tempfile anthro
save `anthro'

**************************************************************************************
**************************************** 6 *******************************************
**************************************************************************************
**** Loading data on Weights
clear
import delimited "$data\acspsw03.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname 										///
		race_ethnicity rel_family_id rel_group_id rel_ingroup_order 				///
		rel_relationship rel_same_sex acs_raked_propensity_score					///
		genetic_paired_subjectid_4 genetic_pi_hat_1 genetic_pi_hat_2 				///
		genetic_pi_hat_3 genetic_pi_hat_4 genetic_zygosity_status_1 				///
		genetic_zygosity_status_2 genetic_zygosity_status_3 						///
		genetic_zygosity_status_4 genetic_af_african genetic_af_european 			///
		genetic_af_east_asian genetic_af_american genetic_paired_subjectid_1 		///
		genetic_paired_subjectid_2 genetic_paired_subjectid_3
		
tempfile weight
save `weight'


**************************************************************************************
**************************************** 7 *******************************************
**************************************************************************************
**** Loading data on Site ID
clear
import delimited "$data\abcd_lt01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id site_id_l eventname
		
tempfile siteID
save `siteID'


**************************************************************************************
**************************************** 8 *******************************************
**************************************************************************************
**** Loading data on discrimination

**** Loading the database (Youth)
clear
import delimited "$data\abcd_ydmes01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname										///
		dim_yesno_q1-dim_matrix_q7
		
		
tempfile discrimin
save `discrimin'


**************************************************************************************
**************************************** 9 *******************************************
**************************************************************************************
**** Loading data on temperamental traits

**** Loading the database (Youth)
clear
import delimited "$data\abcd_bisbas01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day

** Scale scoring from: https://www.phenxtoolkit.org/protocols/view/540601#:~:text=The%20behavioral%20inhibition%20system%20(BIS,strongly%20agree%20to%20strongly%20disagree).

* Behavioral Activation System (BAS) 
egen bas_drive = rowtotal(bisbas13_y bisbas14_y bisbas15_y bisbas16_y)
egen bas_funsk = rowtotal(bisbas17_y bisbas17_y bisbas18_y bisbas19_y bisbas20_y)
egen bas_rewar = rowtotal(bisbas8_y bisbas10_y bisbas9_y bisbas11_y bisbas12_y)

* Behavioral Inhibition System (BIS)
egen bis = rowtotal(bisbas1_y bisbas2_y bisbas3_y bisbas4_y bisbas5r_y bisbas6_y bisbas7_y)

keep 	subjectkey src_subject_id eventname										///
		bas_drive bas_funsk bas_rewar bis
		
		
tempfile bisbas
save `bisbas'


**************************************************************************************
************************************** 10 ********************************************
**************************************************************************************
**** Loading data on Structural MRI


**** Loading the database (Regions of Interest - ROI, Cortical structures)
clear
import delimited "$data\abcd_smrip10201.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname										///
		smri_vol_cdk_totallh smri_vol_cdk_totalrh smri_vol_cdk_total 			///
		smri_vol_cdk_insulalh smri_vol_cdk_insularh smri_vol_cdk_rrmdfrlh 		///
		smri_vol_cdk_rrmdfrrh smri_vol_cdk_frpolerh smri_vol_cdk_frpolelh 		///
		smri_vol_cdk_lobfrlh smri_vol_cdk_lobfrrh smri_vol_cdk_mobfrlh 			///
		smri_vol_cdk_mobfrrh smri_vol_cdk_cdacaterh smri_vol_cdk_cdacatelh		///
		smri_vol_cdk_parahpallh smri_vol_cdk_parahpalrh
		
tempfile smri1
save `smri1'

**** Loading the database (Regions of Interest - ROI, Subcortical structures)
clear
import delimited "$data\abcd_smrip10201.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 



keep 	subjectkey src_subject_id eventname														///
		smri_vol_scs_cbwmatterlh smri_vol_scs_ltventriclelh smri_vol_scs_inflatventlh 			///
		smri_vol_scs_crbwmatterlh smri_vol_scs_crbcortexlh smri_vol_scs_tplh  					///
		smri_vol_scs_caudatelh smri_vol_scs_putamenlh smri_vol_scs_pallidumlh 		 			///
		smri_vol_scs_3rdventricle smri_vol_scs_4thventricle smri_vol_scs_bstem 			 		///
		smri_vol_scs_hpuslh smri_vol_scs_amygdalalh smri_vol_scs_csf smri_vol_scs_lesionlh 	 	///
		smri_vol_scs_aal smri_vol_scs_vedclh smri_vol_scs_cbwmatterrh 							///
		smri_vol_scs_ltventriclerh smri_vol_scs_inflatventrh smri_vol_scs_crbwmatterrh 			///
		smri_vol_scs_crbcortexrh smri_vol_scs_tprh smri_vol_scs_caudaterh 						///
		smri_vol_scs_putamenrh smri_vol_scs_pallidumrh smri_vol_scs_hpusrh 						///
		smri_vol_scs_amygdalarh smri_vol_scs_lesionrh smri_vol_scs_aar smri_vol_scs_vedcrh 		///
		smri_vol_scs_wmhint smri_vol_scs_wmhintlh smri_vol_scs_wmhintrh smri_vol_scs_ccps 		///
		smri_vol_scs_ccmidps smri_vol_scs_ccct smri_vol_scs_ccmidat smri_vol_scs_ccat 			///
		smri_vol_scs_wholeb smri_vol_scs_latventricles smri_vol_scs_allventricles 				///
		smri_vol_scs_intracranialv smri_vol_scs_suprateialv smri_vol_scs_subcorticalgv 
		
		
tempfile smri2
save `smri2'


**************************************************************************************
*************************************** 11 *******************************************
**************************************************************************************
**** Loading data on Parental Acceptance (Also see family conflict: abcd_fes01)
clear
import delimited "$data\crpbi01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname										///
		crpbi_parent1_y crpbi_parent2_y crpbi_parent3_y crpbi_parent4_y			/// 
		crpbi_parent5_y crpbi_caregiver12_y crpbi_caregiver13_y 				///
		crpbi_caregiver14_y crpbi_caregiver15_y crpbi_caregiver16_y 			///
		crpbi_caregiver1_y crpbi_caregiver2_y

		
tempfile paccept
save `paccept'


**************************************************************************************
*************************************** 12 *******************************************
**************************************************************************************
**** Loading demographic data
clear
import delimited "$data\pdem02.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day

* Usually, first day of school: September 10
* Usually, last day of school: June 20

gen 		summer=1 if interview_month==6 & interview_day>=20
replace 	summer=1 if interview_month==7 | interview_month==8
replace 	summer=1 if interview_month==9 & interview_day<=10
replace 	summer=0 if summer==.

gen 		sc_grade = demo_ed_v2 if summer==0
replace 	sc_grade = demo_ed_v2 - 1 if summer==1

table sc_grade, c(n interview_age  min interview_age mean interview_age max interview_age)

* For fouth grade, full range of ages in interviewed children
gen 		rel_age = interview_age - 119 if sc_grade==4

* For third grade, mostly relatively older children were interviewed
gen 		rel_age3 = interview_age - 112 if sc_grade==3

* For fifth grade, mostly relatively younger children were interviewed
gen 		rel_age5 = interview_age - 127 if sc_grade==5

*******************
** Foreigners
gen 	foreign_p = 0 if demo_prnt_16==0 | demo_prnt_origin_v2==189
replace foreign_p = 1 if demo_prnt_origin_v2!=189 & demo_prnt_origin_v2!=777 & demo_prnt_origin_v2!=999 & demo_prnt_origin_v2!=.  

gen 	foreign_y = 0 if demo_origin_v2==189
replace foreign_y = 1 if demo_origin_v2!=189 & demo_origin_v2!=777 & demo_origin_v2!=999

gen country_op = .
gen country_oy = .

* African Origin
foreach ccode in 3 5 19 23 27 28 29 31 33 34 38 39 40 41 48 52 54 55 57 62 65 69 70 87 95 96 97 102 103 106 109 110 117 118 120 126 127 144 147 149 151 152 157 158 160 166 168 174 177 180 184 196 197 {
	replace country_op = 1 if demo_prnt_origin_v2==`ccode'
	replace country_oy = 1 if demo_origin_v2==`ccode'
}

* South Asia Origin
foreach ccode in 14 20 76 122 162 {
	replace country_op = 2 if demo_prnt_origin_v2==`ccode'
	replace country_oy = 2 if demo_origin_v2==`ccode'
}
* East Asia Origin
*Timor-Leste considered Asia
foreach ccode in 25 30 36 77 92 104 105 112 115 119 128 132 138 153 159 172 175 194 {
	replace country_op = 3 if demo_prnt_origin_v2==`ccode'
	replace country_oy = 3 if demo_origin_v2==`ccode'
}

* Middle East Origin
* Georgia is not part of the UE. They are negotiating though
* Israel in ME
foreach ccode in 1 8 11 13 78 79 81 85 86 90 91 94 130 131 133 148 171 173 182 187 190 195 {
	replace country_op = 4 if demo_prnt_origin_v2==`ccode'
	replace country_oy = 4 if demo_origin_v2==`ccode'
}

* Central America Origin
foreach ccode in 6 12 15 18 41 44 49 50 53 67 68 72 73 83 108 125 134 163 164 165 179 {
	replace country_op = 5 if demo_prnt_origin_v2==`ccode'
	replace country_oy = 5 if demo_origin_v2==`ccode'
}

* South America Origin
* Guyana/Suriname considered South America, even though culturally they are more similar to the Caribe
foreach ccode in 7 21 24 35 37 51 71 136 137 167 188 193 198 {
	replace country_op = 6 if demo_prnt_origin_v2==`ccode'
	replace country_oy = 6 if demo_origin_v2==`ccode'
}

* Oceania Origin
foreach ccode in 9 58 88 121 124 135 145 156 178 183 191 {
	replace country_op = 7 if demo_prnt_origin_v2==`ccode'
	replace country_oy = 7 if demo_origin_v2==`ccode'
}

* Eastern Europe Origin
* Cyprus considered culturally and politically European
foreach ccode in 2 16 22 26 43 45 46 74 84 89 93 98 99 101 113 116 150 154 155 181 186 {
	replace country_op = 8 if demo_prnt_origin_v2==`ccode'
	replace country_oy = 8 if demo_origin_v2==`ccode'
}
* Western Europe Origin
foreach ccode in 4 10 17 60 61 64 66 80 82 100 107 114 123 139 140 142 143 146 161 170 185 192 {
	replace country_op = 9 if demo_prnt_origin_v2==`ccode'
	replace country_oy = 9 if demo_origin_v2==`ccode'
}
* Northern Europe Origin
foreach ccode in 47 56 59 75 129 169 {
	replace country_op = 10 if demo_prnt_origin_v2==`ccode'
	replace country_oy = 10 if demo_origin_v2==`ccode'
}
* Canadian origin
replace country_op = 11 if demo_prnt_origin_v2==32
replace country_oy = 11 if demo_origin_v2==32

* Mexican origin
replace country_op = 12 if demo_prnt_origin_v2==111
replace country_oy = 12 if demo_origin_v2==111

label define country_op 1 "Africa" 2 "South Asia" 3 "East Asia" 4 "Middle East" 5 "Central America" 6 "South America" 7 "Oceania" 8 "Eastern Europe" 9 "Western Europe" 10 "North Europe" 11 "Canada" 12 "Mexico"
label values country_op country_op 
label define country_oy 1 "Africa" 2 "South Asia" 3 "East Asia" 4 "Middle East" 5 "Central America" 6 "South America" 7 "Oceania" 8 "Eastern Europe" 9 "Western Europe" 10 "North Europe" 11 "Canada" 12 "Mexico"
label values country_oy country_oy 


*** Race
egen aux_race = rowtotal(demo_race_a_p___10 demo_race_a_p___11 demo_race_a_p___12 demo_race_a_p___13 demo_race_a_p___14 demo_race_a_p___15 demo_race_a_p___16 demo_race_a_p___17 demo_race_a_p___18 demo_race_a_p___19 demo_race_a_p___20 demo_race_a_p___21 demo_race_a_p___22 demo_race_a_p___23 demo_race_a_p___24 demo_race_a_p___25),m
gen mix_race = cond(aux_race>1 & aux_race<., 1, 0) if aux_race!=.

*** Marital status
label define demo_prnt_marital_v2 1 "Married" 2 "Widowed" 3 "Divorced" 4 "Separated" 5 "Never married" 6 "Living with partner" 777 "Refused to answer"
label values demo_prnt_marital_v2 demo_prnt_marital_v2 

*** Education
gen 	educ_lev = 1 if demo_prnt_ed_v2==0
replace educ_lev = 2 if demo_prnt_ed_v2>0 & demo_prnt_ed_v2<=14
replace educ_lev = 3 if demo_prnt_ed_v2==15
replace educ_lev = 4 if demo_prnt_ed_v2>15 & demo_prnt_ed_v2<=17
replace educ_lev = 5 if demo_prnt_ed_v2==18 
replace educ_lev = 6 if demo_prnt_ed_v2>18 & demo_prnt_ed_v2<=21

label define educ_lev 1 "No school" 2 "High school" 3 "Some College" 4 "Associate Degree" 5 "College" 6 "Masters or more"
label values educ_lev educ_lev

gen 	educ_levpt = 1 if demo_prtnr_ed_v2==0
replace educ_levpt = 2 if demo_prtnr_ed_v2>0 & demo_prtnr_ed_v2<=14
replace educ_levpt = 3 if demo_prtnr_ed_v2==15
replace educ_levpt = 4 if demo_prtnr_ed_v2>15 & demo_prtnr_ed_v2<=17
replace educ_levpt = 5 if demo_prtnr_ed_v2==18 
replace educ_levpt = 6 if demo_prtnr_ed_v2>18 & demo_prtnr_ed_v2<=21

label define educ_levpt 1 "No school" 2 "High school" 3 "Some College" 4 "Associate Degree" 5 "College" 6 "Masters or more"
label values educ_levpt educ_levpt

*** Income
gen 	fam_income = 2500 if demo_comb_income_v2==1
replace fam_income = 8500 if demo_comb_income_v2==2
replace fam_income = 14000 if demo_comb_income_v2==3
replace fam_income = 20500 if demo_comb_income_v2==4
replace fam_income = 30000 if demo_comb_income_v2==5
replace fam_income = 42500 if demo_comb_income_v2==6
replace fam_income = 62500 if demo_comb_income_v2==7
replace fam_income = 87500 if demo_comb_income_v2==8
replace fam_income = 150000 if demo_comb_income_v2==9
replace fam_income = 250000 if demo_comb_income_v2==10

gen n_fam = demo_roster_v2 
*if demo_roster_v2 <=15
gen fam_income_pc = fam_income/n_fam 

xtile q_fam_income_pc = fam_income_pc, nq(5)
xtile d_fam_income_pc = fam_income_pc, nq(10)

label define demo_comb_income_v2 1 "Less than 5,000" 2 "5,000 through 11,999" 3 "12,000 through 15,999" 4 "16,000 through 24,999" 5 "$25,000 through $34,999" 6 "35,000 through 49,999" 7 "50,000 through 74,999" 8 "$75,000 through $99,999" 9 "100,000 through $199,999" 10 "$200,000 and greater"
label values demo_comb_income_v2 demo_comb_income_v2 

*** Make ends meet
foreach mem in demo_fam_exp1_v2 demo_fam_exp2_v2 demo_fam_exp3_v2 demo_fam_exp4_v2 demo_fam_exp5_v2 demo_fam_exp6_v2 demo_fam_exp7_v2 {
	replace `mem'=. if `mem'==777
}
egen mem1 = rowtotal(demo_fam_exp1_v2 demo_fam_exp2_v2 demo_fam_exp3_v2 demo_fam_exp4_v2 demo_fam_exp5_v2 demo_fam_exp6_v2 demo_fam_exp7_v2)
gen mem2 = cond(demo_fam_exp1_v2==1 | demo_fam_exp2_v2==1 | demo_fam_exp3_v2==1 | demo_fam_exp4_v2==1 | demo_fam_exp5_v2==1 | demo_fam_exp6_v2==1 | demo_fam_exp7_v2==1, 1, 0)


*** Family variables
label define demo_prim 1 "Childs Biological Mother" 2 "Childs Biological Father" 3 "Adoptive Parent" 4 "Childs Custodial" 5 "Other"
label values demo_prim demo_prim 

gen 	both_bioparents = 1 if (demo_prim==1 | demo_prim==2) & (fam_roster_2c_v2==1 | fam_roster_3c_v2==1 | fam_roster_4c_v2==1 | fam_roster_5c_v2==1 | fam_roster_6c_v2==1 | fam_roster_7c_v2==1 | fam_roster_8c_v2==1 | fam_roster_9c_v2==1 | fam_roster_10c_v2==1 | fam_roster_11c_v2==1 | fam_roster_12c_v2==1 | fam_roster_13c_v2==1 | fam_roster_14c_v2==1 | fam_roster_15c_v2==1)
replace both_bioparents = 0 if both_bioparents!=1 & fam_roster_2c_v2!=.

gen 	both_adoparents = 1 if (demo_prim==3) & (fam_roster_2c_v2==1 | fam_roster_3c_v2==1 | fam_roster_4c_v2==1 | fam_roster_5c_v2==1 | fam_roster_6c_v2==1 | fam_roster_7c_v2==1 | fam_roster_8c_v2==1 | fam_roster_9c_v2==1 | fam_roster_10c_v2==1 | fam_roster_11c_v2==1 | fam_roster_12c_v2==1 | fam_roster_13c_v2==1 | fam_roster_14c_v2==1 | fam_roster_15c_v2==1)
replace both_adoparents = 0 if both_adoparents!=1 & fam_roster_2c_v2!=.

gen 	both_cusparents = 1 if (demo_prim==4) & (fam_roster_2c_v2==1 | fam_roster_3c_v2==1 | fam_roster_4c_v2==1 | fam_roster_5c_v2==1 | fam_roster_6c_v2==1 | fam_roster_7c_v2==1 | fam_roster_8c_v2==1 | fam_roster_9c_v2==1 | fam_roster_10c_v2==1 | fam_roster_11c_v2==1 | fam_roster_12c_v2==1 | fam_roster_13c_v2==1 | fam_roster_14c_v2==1 | fam_roster_15c_v2==1)
replace both_cusparents = 0 if both_cusparents & fam_roster_2c_v2!=.

gen 	both_othparents = 1 if (demo_prim==4) & (fam_roster_2c_v2==1 | fam_roster_3c_v2==1 | fam_roster_4c_v2==1 | fam_roster_5c_v2==1 | fam_roster_6c_v2==1 | fam_roster_7c_v2==1 | fam_roster_8c_v2==1 | fam_roster_9c_v2==1 | fam_roster_10c_v2==1 | fam_roster_11c_v2==1 | fam_roster_12c_v2==1 | fam_roster_13c_v2==1 | fam_roster_14c_v2==1 | fam_roster_15c_v2==1)
replace both_othparents = 0 if both_cusparents!=1 & fam_roster_2c_v2!=.

gen 	one_bioparent = 1 if (demo_prim==1 | demo_prim==2) & (fam_roster_2c_v2!=1 & fam_roster_3c_v2!=1 & fam_roster_4c_v2!=1 & fam_roster_5c_v2!=1 & fam_roster_6c_v2!=1 & fam_roster_7c_v2!=1 & fam_roster_8c_v2!=1 & fam_roster_9c_v2!=1 & fam_roster_10c_v2!=1 & fam_roster_11c_v2!=1 & fam_roster_12c_v2!=1 & fam_roster_13c_v2!=1 & fam_roster_14c_v2!=1 & fam_roster_15c_v2!=1)
replace one_bioparent = 0 if one_bioparent!=1 & fam_roster_2c_v2!=.

gen 	one_adoparent = 1 if (demo_prim==3) & (fam_roster_2c_v2!=1 & fam_roster_3c_v2!=1 & fam_roster_4c_v2!=1 & fam_roster_5c_v2!=1 & fam_roster_6c_v2!=1 & fam_roster_7c_v2!=1 & fam_roster_8c_v2!=1 & fam_roster_9c_v2!=1 & fam_roster_10c_v2!=1 & fam_roster_11c_v2!=1 & fam_roster_12c_v2!=1 & fam_roster_13c_v2!=1 & fam_roster_14c_v2!=1 & fam_roster_15c_v2!=1)
replace one_adoparent = 0 if one_adoparent!=1 & fam_roster_2c_v2!=.

gen 	one_cusparent = 1 if (demo_prim==4) & (fam_roster_2c_v2!=1 & fam_roster_3c_v2!=1 & fam_roster_4c_v2!=1 & fam_roster_5c_v2!=1 & fam_roster_6c_v2!=1 & fam_roster_7c_v2!=1 & fam_roster_8c_v2!=1 & fam_roster_9c_v2!=1 & fam_roster_10c_v2!=1 & fam_roster_11c_v2!=1 & fam_roster_12c_v2!=1 & fam_roster_13c_v2!=1 & fam_roster_14c_v2!=1 & fam_roster_15c_v2!=1)
replace one_cusparent = 0 if one_cusparent!=1 & fam_roster_2c_v2!=.

gen 	one_othparent = 1 if (demo_prim==4) & (fam_roster_2c_v2!=1 & fam_roster_3c_v2!=1 & fam_roster_4c_v2!=1 & fam_roster_5c_v2!=1 & fam_roster_6c_v2!=1 & fam_roster_7c_v2!=1 & fam_roster_8c_v2!=1 & fam_roster_9c_v2!=1 & fam_roster_10c_v2!=1 & fam_roster_11c_v2!=1 & fam_roster_12c_v2!=1 & fam_roster_13c_v2!=1 & fam_roster_14c_v2!=1 & fam_roster_15c_v2!=1)
replace one_othparent = 0 if one_othparent!=1 & fam_roster_2c_v2!=.

local n = 1
foreach sib in fam_roster_2c_v2 fam_roster_3c_v2 fam_roster_4c_v2 fam_roster_5c_v2 fam_roster_6c_v2 fam_roster_7c_v2 fam_roster_8c_v2 fam_roster_9c_v2 fam_roster_10c_v2 fam_roster_11c_v2 fam_roster_12c_v2 fam_roster_13c_v2 fam_roster_14c_v2 fam_roster_15c_v2{
	gen bio_sibling`n' = 1 if `sib'==3
	gen ado_sibling`n' = 1 if `sib'==5
	gen ste_sibling`n' = 1 if `sib'==7
	
	local n = `n'+1
}

egen bio_siblings = rowtotal(bio_sibling1-bio_sibling14)
egen ado_siblings = rowtotal(ado_sibling1-ado_sibling14)
egen ste_siblings = rowtotal(ste_sibling1-ste_sibling14)
egen tot_siblings = rowtotal(bio_siblings ado_siblings ste_siblings)

gen any_sibling = cond(tot_siblings>0,1,0)

foreach sib in bio_siblings ado_siblings ste_siblings tot_siblings any_sibling{
	replace `sib' = . if fam_roster_2c_v2==.
}

*** Religion
gen religion = demo_yrs_2 if demo_yrs_2<=4

label define religion 1 "Not at all" 2 "Not very" 3 "Somewhat" 4 "Very"
label values religion religion 


keep 	subjectkey src_subject_id eventname											///
		demo_brthdat_v2 demo_ed_v2 summer sc_grade rel_age rel_age3 rel_age5		///
		demo_gender_id_v2 demo_prim demo_prnt_age_v2 demo_prnt_gender_id_v2			///
		mix_race demo_race_a_p___10-demo_race_a_p___25 demo_ethn_v2 demo_ethn2_v2	///
		demo_prnt_race_a_v2___10-demo_prnt_race_a_v2___25 demo_prnt_marital_v2		///
		country_op country_oy demo_prnt_ed_v2 educ_lev demo_prtnr_ed_v2	educ_levpt	///
		demo_roster_v2 fam_income demo_comb_income_v2 q_fam_income_pc 				///
		d_fam_income_pc demo_fam_exp1_v2-demo_fam_exp7_v2 mem1 mem2 religion 		///
		demo_prim tot_siblings bio_siblings ado_siblings ste_siblings				///
		both_bioparents both_adoparents both_cusparents both_othparents 			///
		one_bioparent one_adoparent one_cusparent one_othparent any_sibling			///
		demo_origin_v2 demo_prnt_origin_v2 foreign_p foreign_y fam_income_pc		///
		demo_prnt_prtnr_v2
		
		
tempfile demog
save `demog'


************************************************************************************************************
******************************************   13   **********************************************************
************************************************************************************************************

**** Loading the database - Mental health summary scores, parent surveys
clear
import delimited "$data\abcd_mhp02.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1


** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname												///
		pgbi_p_ss_score ple_p_ss_total_number ple_p_ss_total_good ple_p_ss_total_bad 	///
		ple_p_ss_affected_good_sum ple_p_ss_affected_bad_sum ple_p_ss_affected_mean 	///
		ssrs_p_ss_sum gish_p_ss_m_sum gish_p_ss_f_sum
		
tempfile mhsp
save `mhsp'


************************************************************************************************************
******************************************   14   **********************************************************
************************************************************************************************************

**** Loading the database - Mental health summary scores, youth surveys
clear
import delimited "$data\abcd_mhy02.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1


** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname												///
		ple_y_ss_total_number ple_y_ss_total_good ple_y_ss_total_bad 					///
		ple_y_ss_affect_sum ple_y_ss_affected_good_sum ple_y_ss_affected_bad_sum 		///
		pps_y_ss_number pps_y_ss_bother_sum pps_y_ss_severity_score 					///
		pps_ss_mean_severity upps_y_ss_negative_urgency upps_y_ss_lack_of_planning 		///
		upps_y_ss_sensation_seeking upps_y_ss_positive_urgency 							///
		upps_y_ss_lack_of_perseverance bis_y_ss_bis_sum bis_y_ss_bas_rr 				///
		bis_y_ss_bas_drive bis_y_ss_bas_fs bis_y_ss_bism_sum bis_y_ss_basm_rr 			///
		bis_y_ss_basm_drive delq_y_ss_sum sup_y_ss_sum gish_y_ss_m_sum gish_y_ss_f_sum	///
		peq_ss_relational_aggs peq_ss_overt_victim peq_ss_overt_aggression 				///
		peq_ss_reputation_victim peq_ss_reputation_aggs peq_ss_relational_victim
		
tempfile mhsy
save `mhsy'	


************************************************************************************************************
******************************************   15   **********************************************************
************************************************************************************************************

**** Loading the database - Parent Adult Self Report Scores Aseba (ASR) - Summary scores
clear
import delimited "$data\abcd_asrs01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1


** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname 											///
		asr_scr_perstr_r asr_scr_perstr_t asr_scr_perstr_total asr_scr_perstr_nm 		///
		asr_scr_anxdep_r asr_scr_anxdep_t asr_scr_anxdep_total asr_scr_anxdep_nm 		///
		asr_scr_withdrawn_r asr_scr_withdrawn_t asr_scr_withdrawn_total 				///
		asr_scr_withdrawn_nm asr_scr_somatic_r asr_scr_somatic_t 						///
		asr_scr_somatic_total asr_scr_somatic_nm asr_scr_thought_r 						///
		asr_scr_thought_t asr_scr_thought_total asr_scr_thought_nm 						///
		asr_scr_attention_r asr_scr_attention_t asr_scr_attention_total 				///
		asr_scr_attention_nm asr_scr_aggressive_r asr_scr_aggressive_t 					///
		asr_scr_aggressive_total asr_scr_aggressive_nm asr_scr_rulebreak_r 				///
		asr_scr_rulebreak_t asr_scr_rulebreak_total asr_scr_rulebreak_nm 				///
		asr_scr_intrusive_r asr_scr_intrusive_t asr_scr_intrusive_total 				///
		asr_scr_intrusive_nm asr_scr_internal_r asr_scr_internal_t 						///
		asr_scr_internal_total asr_scr_internal_nm asr_scr_external_r 					///
		asr_scr_external_t asr_scr_external_total asr_scr_external_nm 					///
		asr_scr_totprob_r asr_scr_totprob_t asr_scr_totprob_total asr_scr_totprob_nm 	///
		asr_scr_depress_r asr_scr_depress_t asr_scr_depress_total asr_scr_depress_nm 	///
		asr_scr_anxdisord_r asr_scr_anxdisord_t asr_scr_anxdisord_total 				///
		asr_scr_anxdisord_nm asr_scr_somaticpr_r asr_scr_somaticpr_t 					///
		asr_scr_somaticpr_total asr_scr_somaticpr_nm asr_scr_avoidant_r 				///
		asr_scr_avoidant_t asr_scr_avoidant_total asr_scr_avoidant_nm 					///
		asr_scr_adhd_r asr_scr_adhd_t asr_scr_adhd_total asr_scr_adhd_nm 				///
		asr_scr_antisocial_r asr_scr_antisocial_t asr_scr_antisocial_total 				///
		asr_scr_antisocial_nm asr_scr_inattention_r asr_scr_inattention_t 				///
		asr_scr_inattention_total asr_scr_inattention_nm asr_scr_hyperactive_r 			///
		asr_scr_hyperactive_t asr_scr_hyperactive_total asr_scr_hyperactive_nm			
		
tempfile asrs
save `asrs'	


**************************************************************************************
*************************************** 16 *******************************************
**************************************************************************************
**** Loading data on Family conflict
clear
import delimited "$data\abcd_fes01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day

egen family_conf = rowtotal(fes_youth_q1 fes_youth_q2 fes_youth_q3 fes_youth_q4 fes_youth_q5 fes_youth_q6 fes_youth_q7 fes_youth_q8 fes_youth_q9), miss
egen fam_confav = rowmean(fes_youth_q1 fes_youth_q2 fes_youth_q3 fes_youth_q4 fes_youth_q5 fes_youth_q6 fes_youth_q7 fes_youth_q8 fes_youth_q9)

keep 	subjectkey src_subject_id eventname										///
		fes_youth_q1 fes_youth_q2 fes_youth_q3 fes_youth_q4 fes_youth_q5 		///
		fes_youth_q6 fes_youth_q7 fes_youth_q8 fes_youth_q9 family_conf			///
		fam_confav

		
tempfile fesy
save `fesy'


**************************************************************************************
*************************************** 17 *******************************************
**************************************************************************************
**** Loading data on Autism
clear
import delimited "$data\abcd_pssrs01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day

keep 	subjectkey src_subject_id eventname										///
		ssrs_6_p ssrs_15r_p ssrs_16_p ssrs_18_p ssrs_24_p ssrs_29_p 			///
		ssrs_35_p ssrs_37_p ssrs_39_p ssrs_42_p ssrs_58_p

		
tempfile autis
save `autis'



**************************************************************************************
*************************************** 18 *******************************************
**************************************************************************************
**** Loading data on Conduct Disorder
clear
import delimited "$data\abcd_pksadscd01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname										///
		ksads_cdr_478_p ksads_cdr_479_p ksads_cdr_480_p ksads_cdr_487_p 		///
		ksads_cdr_518_p ksads_cdr_473_p ksads_cdr_474_p ksads_cdr_475_p 		///
		ksads_cdr_476_p ksads_cdr_477_p ksads_cdr_527_p ksads_cdr_528_p 		///
		ksads_cdr_486_p

		
tempfile condd
save `condd'


**************************************************************************************
*************************************** 19 *******************************************
**************************************************************************************
**** Loading data on Positive emotionality
clear
*import delimited "$data2p0\abcd_ytbpai01.txt", varnames(1) encoding(Big5) 
import delimited "$data\abcd_ytbpai01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname										///
		poa_nihtb_1_y poa_nihtb_2_y poa_nihtb_3_y poa_nihtb_4_y poa_nihtb_5_y 	///
		poa_nihtb_6_y poa_nihtb_7_y poa_nihtb_8_y poa_nihtb_9_y
		
tempfile posemo
save `posemo'


**************************************************************************************
*************************************** 20 *******************************************
**************************************************************************************
**** Loading data on Children's will to problem solving (one-year follow-up)
clear
import delimited "$data\abcd_ywpss01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname										///
		wps_q1_y wps_q2_y wps_q3_y wps_q4_y wps_q5_y wps_q6_y
		
tempfile ywill
save `ywill'


**************************************************************************************
*************************************** 21 *******************************************
**************************************************************************************
**** Loading data on Parent prosocial behavior surveys (about their children)
clear
import delimited "$data\psb01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


egen pro_socialp = rowmean(prosocial_q1_p prosocial_q2_p prosocial_q3_p)

keep 	subjectkey src_subject_id eventname										///
		prosocial_q1_p prosocial_q2_p prosocial_q3_p pro_socialp
		
tempfile prosocp
save `prosocp'


**************************************************************************************
*************************************** 22 *******************************************
**************************************************************************************
**** Loading data on Youth prosocial behavior survey
clear
import delimited "$data\abcd_psb01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day

egen pro_socialy = rowmean(prosocial_q1_y prosocial_q2_y prosocial_q3_y)

keep 	subjectkey src_subject_id eventname										///
		prosocial_q1_y prosocial_q2_y prosocial_q3_y pro_socialy
		
tempfile prosocy
save `prosocy'


**************************************************************************************
*************************************** 23 *******************************************
**************************************************************************************
**** Loading data on Physical activity (3 indicators)
clear
import delimited "$data\abcd_yrb01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname										///
		physical_activity1_y physical_activity2_y physical_activity5_y
		
tempfile phyactiv
save `phyactiv'
		

**************************************************************************************
*************************************** 24 *******************************************
**************************************************************************************
**** Loading data on Involvement in sport activities
clear
import delimited "$data\abcd_saiq02.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day

rename sai_p_activities___29 nosportp
label var nosportp "Has not participated EVER in any of 28 sports"

keep 	subjectkey src_subject_id eventname										///
		nosportp
		
tempfile sportact
save `sportact'


**************************************************************************************
*************************************** 25 *******************************************
**************************************************************************************
**** Loading data on mental health diagnoses and symptoms (parental report)
clear
import delimited "$data\abcd_ksad01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1


** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day

*********************
*** Diagnoses
describe ksads_1_843_p ksads_1_840_p ksads_1_846_p ksads_2_835_p ksads_2_836_p ksads_2_831_p ksads_2_832_p ksads_2_830_p ksads_2_838_p ksads_3_848_p ksads_4_826_p ksads_4_828_p ksads_4_851_p ksads_4_849_p ksads_5_906_p ksads_5_857_p ksads_6_859_p ksads_7_861_p ksads_7_909_p ksads_8_863_p ksads_8_911_p ksads_9_867_p ksads_10_913_p ksads_10_869_p ksads_11_917_p ksads_11_919_p ksads_12_927_p ksads_12_925_p ksads_13_938_p ksads_13_929_p ksads_13_932_p ksads_13_930_p ksads_13_935_p ksads_13_942_p ksads_13_941_p ksads_14_853_p ksads_15_901_p ksads_16_897_p ksads_16_898_p ksads_17_904_p ksads_19_891_p ksads_20_893_p ksads_20_874_p ksads_20_872_p ksads_20_889_p ksads_20_878_p ksads_20_877_p ksads_20_875_p ksads_20_876_p ksads_20_879_p ksads_20_873_p ksads_20_871_p ksads_21_923_p ksads_21_921_p ksads_22_969_p ksads_23_946_p ksads_23_954_p ksads_23_945_p ksads_23_950_p ksads_23_947_p ksads_23_948_p ksads_23_949_p ksads_23_952_p ksads_23_955_p ksads_23_951_p ksads_23_953_p ksads_24_967_p ksads_25_915_p ksads_25_865_p


foreach v of varlist ksads_1_843_p ksads_1_840_p ksads_1_846_p ksads_2_835_p ksads_2_836_p ksads_2_831_p ksads_2_832_p ksads_2_830_p ksads_2_838_p ksads_3_848_p ksads_4_826_p ksads_4_828_p ksads_4_851_p ksads_4_849_p ksads_5_906_p ksads_5_857_p ksads_6_859_p ksads_7_861_p ksads_7_909_p ksads_8_863_p ksads_8_911_p ksads_9_867_p ksads_10_913_p ksads_10_869_p ksads_11_917_p ksads_11_919_p ksads_12_927_p ksads_12_925_p ksads_13_938_p ksads_13_929_p ksads_13_932_p ksads_13_930_p ksads_13_935_p ksads_13_942_p ksads_13_941_p ksads_14_853_p ksads_15_901_p ksads_16_897_p ksads_16_898_p ksads_17_904_p ksads_19_891_p ksads_20_893_p ksads_20_874_p ksads_20_872_p ksads_20_889_p ksads_20_878_p ksads_20_877_p ksads_20_875_p ksads_20_876_p ksads_20_879_p ksads_20_873_p ksads_20_871_p ksads_21_923_p ksads_21_921_p ksads_22_969_p ksads_23_946_p ksads_23_954_p ksads_23_945_p ksads_23_950_p ksads_23_947_p ksads_23_948_p ksads_23_949_p ksads_23_952_p ksads_23_955_p ksads_23_951_p ksads_23_953_p ksads_24_967_p ksads_25_915_p ksads_25_865_p{
	replace `v'=. if `v'>1
}
/*
rename ksads_4_829_p delusionsp_p
rename ksads_4_828_p delusionsp_c
rename ksads_4_850_p psychotic_p
rename ksads_4_849_p psychotic_c
rename ksads_4_826_p hallucina_c
rename ksads_4_827_p hallucina_p
rename ksads_4_851_p uschizoph_c
rename ksads_4_852_p uschizoph_p
rename ksads_13_938_p eatingdp_c 
rename ksads_13_940_p eatingdp_p
rename ksads_14_853_p adhdp_p
rename ksads_14_854_p adhdp_c
*/

* Schizo-related problems
clonevar delusionsp_p = ksads_4_829_p
clonevar delusionsp_c = ksads_4_828_p 
clonevar psychotic_p = ksads_4_850_p 
clonevar psychotic_c = ksads_4_849_p 
clonevar hallucina_c = ksads_4_826_p 
clonevar hallucina_p = ksads_4_827_p 
clonevar uschizoph_c = ksads_4_851_p 
clonevar uschizoph_p = ksads_4_852_p 

* Mania-related problems
clonevar bpimanic_c = ksads_2_830_p
clonevar bpidepre_c = ksads_2_831_p
clonevar bpihyman_c = ksads_2_832_p
clonevar bpiidepre_c = ksads_2_836_p
clonevar bpiihyman_c = ksads_2_835_p
clonevar bpunspec_c = ksads_2_838_p


*********************
*** Symptoms
global depress_present "ksads_1_1_p ksads_1_3_p ksads_1_5_p ksads_1_171_p ksads_1_167_p ksads_1_163_p ksads_1_169_p ksads_1_175_p ksads_1_173_p ksads_1_181_p ksads_1_165_p ksads_1_161_p ksads_1_159_p ksads_1_183_p ksads_1_157_p ksads_1_177_p ksads_22_141_p ksads_1_179_p"
global bipolar_present "ksads_2_12_p ksads_2_209_p ksads_2_195_p ksads_2_14_p ksads_2_217_p ksads_2_215_p ksads_2_201_p ksads_2_213_p ksads_2_9_p ksads_2_7_p ksads_2_191_p ksads_2_189_p ksads_2_197_p ksads_2_207_p ksads_2_199_p ksads_2_210_p ksads_2_203_p ksads_2_205_p ksads_2_192_p"
global mooddys_present "ksads_3_229_p ksads_3_226_p"
global psychos_present "ksads_4_258_p ksads_4_230_p ksads_4_252_p ksads_4_254_p ksads_4_243_p ksads_4_241_p ksads_4_237_p ksads_4_239_p ksads_4_256_p ksads_4_247_p ksads_4_245_p ksads_4_16_p ksads_4_234_p ksads_4_18_p ksads_4_236_p ksads_4_235_p ksads_4_232_p ksads_4_248_p ksads_4_250_p"
global panic_present "ksads_5_261_p ksads_5_263_p ksads_5_20_p ksads_5_265_p ksads_5_267_p ksads_5_269_p"
global agaroph_present "ksads_6_274_p ksads_6_276_p ksads_6_278_p ksads_6_22_p ksads_6_272_p"
global sepanx_present "ksads_7_300_p ksads_7_26_p ksads_7_287_p ksads_7_291_p ksads_7_293_p ksads_7_289_p ksads_7_295_p ksads_7_24_p ksads_7_281_p ksads_7_285_p ksads_7_297_p ksads_7_283_p"
global socanx_present "ksads_8_309_p ksads_8_29_p ksads_8_30_p ksads_8_311_p ksads_8_307_p ksads_8_303_p ksads_8_301_p"
global genanx_present "ksads_10_45_p ksads_10_320_p ksads_10_324_p ksads_10_328_p ksads_10_326_p ksads_10_47_p ksads_10_322_p"
global obscomp_present "ksads_11_343_p ksads_11_331_p ksads_11_48_p ksads_11_335_p ksads_11_341_p ksads_11_50_p ksads_11_339_p ksads_11_347_p ksads_11_333_p ksads_11_345_p ksads_11_337_p"
global social_probprpt "ksads_5_20_p ksads_5_261_p ksads_6_22_p ksads_6_272_p ksads_8_29_p ksads_8_307_p ksads_9_41_p ksads_9_34_p ksads_10_45_p ksads_10_320_p ksads_11_48_p ksads_11_50_p ksads_12_52_p ksads_12_56_p ksads_12_60_p ksads_12_62_p"
global eatdis_present "ksads_13_469_p ksads_13_470_p ksads_13_473_p ksads_13_471_p ksads_13_74_p ksads_13_472_p ksads_13_475_p ksads_13_68_p ksads_13_66_p ksads_13_70_p ksads_13_72_p"
global adhd_present "ksads_14_398_p ksads_14_403_p ksads_14_405_p ksads_14_406_p ksads_14_76_p ksads_14_396_p ksads_14_397_p ksads_14_404_p ksads_14_85_p ksads_14_77_p ksads_14_84_p ksads_14_401_p ksads_14_80_p ksads_14_81_p ksads_14_400_p ksads_14_88_p ksads_14_399_p ksads_14_408_p ksads_14_394_p ksads_14_395_p ksads_14_407_p ksads_14_402_p ksads_14_409_p ksads_14_429_p"
global oppdef_present "ksads_15_95_p ksads_15_436_p ksads_15_435_p ksads_15_433_p ksads_15_93_p ksads_15_432_p ksads_15_91_p ksads_15_438_p ksads_15_437_p ksads_15_434_p"
global condu_present "ksads_16_449_p ksads_16_463_p ksads_16_453_p ksads_16_461_p ksads_16_465_p ksads_16_98_p ksads_16_104_p ksads_16_102_p ksads_16_457_p ksads_16_455_p ksads_16_451_p ksads_16_106_p ksads_16_100_p ksads_16_447_p ksads_16_459_p"
global autism_present "ksads_18_116_p ksads_18_112_p ksads_18_114_p"
global alcoh_present "ksads_19_500_p ksads_19_499_p ksads_19_508_p ksads_19_493_p ksads_19_481_p ksads_19_501_p ksads_19_483_p ksads_19_491_p ksads_19_489_p ksads_19_485_p ksads_19_497_p ksads_19_122_p ksads_19_495_p ksads_19_120_p ksads_19_498_p ksads_19_486_p"
global drugs_present "ksads_20_126_p ksads_20_545_p ksads_20_590_p ksads_20_620_p ksads_20_665_p ksads_20_575_p ksads_20_650_p ksads_20_560_p ksads_20_521_p ksads_20_635_p" /* There are more symptoms to be added */
global ptsd_present "ksads_21_355_p ksads_21_373_p ksads_21_359_p ksads_21_365_p ksads_21_137_p ksads_21_369_p ksads_21_357_p ksads_21_349_p ksads_21_371_p ksads_21_134_p ksads_21_375_p ksads_21_385_p ksads_21_367_p ksads_21_383_p ksads_21_135_p ksads_21_377_p ksads_21_353_p ksads_21_139_p ksads_21_391_p ksads_21_351_p ksads_21_363_p ksads_21_361_p ksads_21_379_p ksads_21_387_p ksads_21_389_p ksads_21_381_p" 
global suic_present "ksads_23_813_p ksads_23_814_p ksads_23_809_p ksads_23_149_p ksads_23_812_p ksads_23_808_p ksads_23_807_p ksads_23_143_p ksads_23_145_p ksads_23_810_p ksads_23_147_p ksads_23_811_p ksads_23_815_p ksads_24_967_p ksads_24_153_p ksads_24_151_p" 
global symp_past "ksads_22_142_p ksads_1_158_p ksads_1_160_p ksads_1_182_p ksads_1_178_p ksads_1_164_p ksads_1_162_p ksads_23_150_p ksads_23_148_p ksads_23_820_p ksads_23_819_p ksads_23_818_p ksads_1_170_p ksads_1_166_p ksads_1_2_p ksads_1_4_p ksads_1_6_p ksads_1_1_p ksads_1_172_p ksads_1_168_p ksads_1_170_p ksads_1_166_p ksads_4_259_p ksads_4_231_p ksads_4_238_p ksads_4_240_p ksads_4_257_p ksads_4_246_p ksads_4_17_p ksads_4_19_p ksads_4_249_p ksads_4_251_p ksads_4_233_p ksads_2_196_p ksads_2_13_p ksads_2_198_p ksads_2_211_p ksads_2_214_p ksads_2_203_p ksads_2_207_p ksads_7_25_p ksads_7_284_p ksads_7_282_p ksads_7_27_p ksads_7_286_p ksads_7_288_p ksads_7_290_p ksads_7_292_p ksads_5_21_p ksads_5_262_p ksads_6_23_p ksads_6_273_p ksads_8_31_p ksads_8_308_p ksads_9_42_p ksads_9_35_p ksads_10_46_p ksads_10_321_p ksads_11_49_p ksads_11_51_p ksads_12_53_p ksads_12_61_p ksads_13_476_p ksads_13_477_p ksads_13_75_p ksads_13_480_p ksads_13_69_p ksads_13_67_p ksads_13_71_p ksads_13_73_p ksads_14_410_p ksads_14_78_p ksads_14_411_p ksads_14_412_p ksads_14_413_p ksads_14_414_p ksads_14_415_p ksads_14_82_p ksads_14_416_p ksads_14_417_p ksads_14_86_p ksads_14_418_p ksads_14_420_p ksads_14_419_p ksads_14_424_p ksads_14_421_p ksads_14_422_p ksads_14_423_p ksads_15_92_p ksads_15_439_p ksads_15_440_p ksads_15_94_p ksads_15_96_p ksads_15_442_p ksads_15_436_p ksads_15_441_p ksads_16_105_p ksads_16_103_p ksads_16_460_p ksads_16_462_p ksads_16_466_p ksads_16_452_p ksads_16_464_p ksads_16_448_p ksads_16_454_p ksads_16_450_p ksads_16_99_p ksads_16_107_p ksads_16_456_p ksads_16_458_p ksads_16_101_p ksads_23_822_p ksads_23_144_p ksads_23_818_p ksads_23_825_p ksads_23_150_p ksads_23_821_p ksads_23_817_p ksads_23_816_p ksads_23_146_p ksads_23_819_p ksads_23_148_p ksads_23_820_p ksads_23_824_p ksads_2_204_p ksads_2_208_p ksads_2_202_p ksads_2_200_p ksads_1_180_p ksads_1_184_p ksads_1_174_p ksads_1_176_p"


foreach v of varlist $depress_present $bipolar_present $mooddys_present $psychos_present $panic_present $agaroph_present $sepanx_present $socanx_present $genanx_present $obscomp_present $social_probprpt $eatdis_present $adhd_present $oppdef_present $condu_present $autism_present $alcoh_present $drugs_present $ptsd_present $suic_present $symp_past{
	replace `v'=. if `v'==555 			/* No answer because failed to answer Level 1 screening */
	replace `v'=0 if `v'==888			/* No answer because failed to pass Level 1 screening */
}

sum $depress_present if eventname=="baseline_year_1_arm_1"
sum $depress_present if eventname=="1_year_follow_up_y_arm_1"
sum $depress_present if eventname=="2_year_follow_up_y_arm_1"


sum $psychos_present if eventname=="baseline_year_1_arm_1"
sum $psychos_present if eventname=="1_year_follow_up_y_arm_1"


*****************************************************************************************************************************
*****************************************************************************************************************************
/* Variables at baseline and one-year follow-up:
- ksads_4_16_p    int     %10.0g                Symptom - Hallucinations Present
- ksads_4_18_p    int     %10.0g                Symptom - Persecutory Delusions Past two weeks Present
- ksads_13_74_p   int     %10.0g                Symptom - Binge Eating Present
- ksads_13_68_p   int     %10.0g                Symptom - Emaciation Present
- ksads_13_66_p   int     %10.0g                Symptom - Fear of becoming obese Present
- ksads_13_70_p   int     %10.0g                Symptom - Weight control vomiting Present
- ksads_13_72_p   int     %10.0g                Symptom - Weight control other (laxatives exercise dieting pills) Present 徆

*/

global dsm5p_axdppy "ksads_1_843_p ksads_1_840_p ksads_1_846_p ksads_2_835_p ksads_2_836_p ksads_2_831_p ksads_2_832_p ksads_2_830_p ksads_2_838_p ksads_3_848_p ksads_4_826_p ksads_4_828_p ksads_4_851_p ksads_4_849_p ksads_5_906_p ksads_5_857_p ksads_6_859_p ksads_6_908_p ksads_7_861_p ksads_7_909_p ksads_8_863_p ksads_8_911_p ksads_9_867_p ksads_10_913_p ksads_10_869_p ksads_11_917_p ksads_11_919_p ksads_12_925_p ksads_12_927_p ksads_13_938_p ksads_13_929_p ksads_13_932_p ksads_13_930_p ksads_13_935_p ksads_13_942_p ksads_13_941_p ksads_17_904_p ksads_21_923_p ksads_21_921_p ksads_21_923_p ksads_25_915_p ksads_25_865_p"
global dsm5p_devdis "ksads_14_853_p ksads_18_903_p"
global dsm5p_condis "ksads_15_901_p ksads_16_897_p ksads_16_898_p"
global dsm5p_subdis "ksads_19_891_p ksads_19_895_p ksads_20_893_p ksads_20_874_p ksads_20_872_p ksads_20_889_p ksads_20_878_p ksads_20_877_p ksads_20_875_p ksads_20_876_p ksads_20_879_p ksads_20_873_p ksads_20_871_p"
global dsm5p_suibeh "ksads_23_946_p ksads_23_954_p ksads_23_945_p ksads_23_950_p ksads_23_947_p ksads_23_948_p ksads_23_949_p ksads_23_952_p ksads_23_955_p ksads_23_951_p ksads_23_953_p ksads_24_967_p"

*sum $dsm5p_conduct if eventname=="baseline_year_1_arm_1"
*sum $dsm5p_conduct if eventname=="1_year_follow_up_y_arm_1"

*****************************************************************************************************************************
*****************************************************************************************************************************
/* Variables at baseline and two-year follow-up:
*/
*** Depression
** Present
egen dpr_eating = rowmax(ksads_1_171_p ksads_1_167_p ksads_1_169_p ksads_1_165_p)
egen dpr_sleep = rowmax(ksads_1_157_p ksads_22_141_p)
egen dpr_motor = rowmax(ksads_1_175_p ksads_1_173_p)
egen dpr_energy = rowmax(ksads_1_159_p)
egen drp_worth = rowmax(ksads_1_181_p ksads_1_177_p)
egen drp_decis = rowmax(ksads_1_163_p ksads_1_161_p)
egen drp_suic = rowmax(ksads_23_149_p ksads_23_147_p ksads_23_811_p ksads_23_810_p ksads_23_809_p)
*ksads_23_815_p
egen dpr_dprirr = rowmax(ksads_1_1_p ksads_1_3_p)
egen dpr_eat2 = rowmax(ksads_1_165_p ksads_1_169_p)

* Major depressive disorder (MDD)
egen dsm5_mdd = rowtotal(ksads_1_1_p ksads_1_3_p ksads_1_5_p dpr_eating dpr_sleep dpr_motor dpr_energy drp_worth drp_decis drp_suic), miss
egen Dsm5_mdd = rowmean(ksads_1_1_p ksads_1_3_p ksads_1_5_p dpr_eating dpr_sleep dpr_motor dpr_energy drp_worth drp_decis drp_suic)

egen mdd_first = rowmax(ksads_1_1_p ksads_1_3_p ksads_1_5_p)
egen mdd_second = rowtotal(dpr_eating dpr_sleep dpr_motor dpr_energy drp_worth drp_decis drp_suic)
gen mdd_diagn = (mdd_first==1 & dsm5_mdd>=5) if dsm5_mdd<.

* Vargas and Mittal
egen drp_selfinj = rowmax(ksads_23_807_p ksads_23_808_p)
egen dsm5_mddvm = rowtotal(ksads_1_1_p ksads_1_3_p ksads_1_5_p ksads_22_141_p ksads_23_143_p ksads_23_145_p ksads_23_147_p ksads_23_149_p ksads_1_157_p ksads_1_159_p ksads_1_161_p ksads_1_163_p ksads_1_165_p ksads_1_167_p ksads_1_169_p ksads_1_171_p ksads_1_173_p ksads_1_175_p ksads_1_177_p ksads_1_179_p ksads_1_181_p ksads_1_183_p), miss


* Dysthymia/persistent depression
egen dsm5_dys = rowtotal(dpr_dprirr dpr_eat2 dpr_energy ksads_1_181_p drp_decis ksads_1_179_p), miss
egen Dsm5_dys = rowmean(dpr_dprirr dpr_eat2 dpr_energy ksads_1_181_p drp_decis ksads_1_179_p)

** Past

egen drp_selfinjP = rowmax(ksads_23_816_p ksads_23_817_p)

egen dsm5_mddvmP = rowtotal(ksads_1_2_p ksads_1_4_p ksads_1_6_p ksads_22_142_p ksads_23_144_p ksads_23_146_p ksads_23_148_p ksads_23_150_p ksads_1_158_p ksads_1_160_p ksads_1_162_p ksads_1_164_p ksads_1_166_p ksads_1_168_p ksads_1_170_p ksads_1_172_p ksads_1_174_p ksads_1_176_p ksads_1_178_p ksads_1_180_p ksads_1_182_p ksads_1_184_p), miss

egen dpr_eatingP = rowmax(ksads_1_172_p ksads_1_168_p ksads_1_170_p ksads_1_166_p)
egen dpr_sleepP = rowmax(ksads_22_142_p ksads_1_158_p)
egen dpr_motorP = rowmax(ksads_1_176_p ksads_1_174_p)
egen dpr_energyP = rowmax(ksads_1_160_p)
egen drp_worthP = rowmax(ksads_1_182_p ksads_1_178_p)
egen drp_decisP = rowmax(ksads_1_164_p ksads_1_162_p)
egen drp_suicP = rowmax(ksads_23_150_p ksads_23_148_p ksads_23_820_p ksads_23_819_p ksads_23_818_p)

egen dpr_dprirrP = rowmax(ksads_1_2_p ksads_1_4_p)
egen dpr_eat2P = rowmax(ksads_1_170_p ksads_1_166_p)

* Major depressive disorder (MDD)
egen dsm5_mddP = rowtotal(ksads_1_2_p ksads_1_4_p ksads_1_6_p dpr_eatingP dpr_sleepP dpr_motorP dpr_energyP drp_worthP drp_decisP drp_suicP), miss
egen Dsm5_mddP = rowmean(ksads_1_2_p ksads_1_4_p ksads_1_6_p dpr_eatingP dpr_sleepP dpr_motorP dpr_energyP drp_worthP drp_decisP drp_suicP)


** Past and Present
egen dpr_eatingp = rowmax(ksads_1_172_p ksads_1_168_p ksads_1_170_p ksads_1_166_p ksads_1_171_p ksads_1_167_p ksads_1_169_p ksads_1_165_p)
egen dpr_sleepp = rowmax(ksads_22_142_p ksads_1_158_p ksads_1_157_p ksads_22_141_p)
egen dpr_motorp = rowmax(ksads_1_176_p ksads_1_174_p)
egen dpr_energyp = rowmax(ksads_1_160_p ksads_1_159_p)
egen drp_worthp = rowmax(ksads_1_182_p ksads_1_178_p ksads_1_181_p ksads_1_177_p)
egen drp_decisp = rowmax(ksads_1_164_p ksads_1_162_p ksads_1_163_p ksads_1_161_p)
egen drp_suicp = rowmax(ksads_23_150_p ksads_23_148_p ksads_23_820_p ksads_23_819_p ksads_23_818_p ksads_23_149_p ksads_23_147_p ksads_23_811_p ksads_23_815_p ksads_23_810_p ksads_23_809_p)

egen dpr_dprirrp = rowmax(ksads_1_2_p ksads_1_4_p ksads_1_1_p ksads_1_3_p)
egen dpr_eat2p = rowmax(ksads_1_170_p ksads_1_166_p ksads_1_165_p ksads_1_169_p)

* Major depressive disorder (MDD)
egen dsm5_mddp = rowtotal(ksads_1_2_p ksads_1_4_p ksads_1_6_p ksads_1_1_p ksads_1_3_p ksads_1_5_p dpr_eatingp dpr_sleepp dpr_motorp dpr_energyp drp_worthp drp_decisp drp_suicp), miss
egen Dsm5_mddp = rowmean(ksads_1_2_p ksads_1_4_p ksads_1_6_p ksads_1_1_p ksads_1_3_p ksads_1_5_p dpr_eatingp dpr_sleepp dpr_motorp dpr_energyp drp_worthp drp_decisp drp_suicp)

* Dysthymia/persistent depression
egen dsm5_dysp = rowtotal(dpr_dprirr dpr_eat2p dpr_energyp ksads_1_181_p ksads_1_182_p drp_decisp ksads_1_179_p ksads_1_180_p), miss
egen Dsm5_dysp = rowmean(dpr_dprirr dpr_eat2p dpr_energyp ksads_1_181_p ksads_1_182_p drp_decisp ksads_1_179_p ksads_1_180_p)

***************************************************************************************************************************************
*** Bipolar
** Present
egen mnc_racingt = rowmax(ksads_2_201_p ksads_2_199_p)
egen mnc_activity = rowmax(ksads_2_203_p ksads_2_207_p)

* Manic or hypomanic episode
egen dsm5_manic = rowtotal(ksads_2_195_p ksads_2_12_p ksads_2_197_p mnc_racingt ksads_2_209_p mnc_activity ksads_2_213_p), miss
egen Dsm5_manic = rowmean(ksads_2_195_p ksads_2_12_p ksads_2_197_p mnc_racingt ksads_2_209_p mnc_activity ksads_2_213_p)

** Past and Present
egen mnc_racingtp = rowmax(ksads_2_202_p ksads_2_200_p ksads_2_201_p ksads_2_199_p)
egen mnc_activityp = rowmax(ksads_2_203_p ksads_2_207_p ksads_2_204_p ksads_2_208_p)

* Manic or hypomanic episode
egen dsm5_manicp = rowtotal(ksads_2_196_p ksads_2_13_p ksads_2_198_p ksads_2_211_p ksads_2_214_p ksads_2_195_p ksads_2_12_p ksads_2_197_p mnc_racingtp ksads_2_209_p mnc_activityp ksads_2_213_p), miss
egen Dsm5_manicp = rowmean(ksads_2_196_p ksads_2_13_p ksads_2_198_p ksads_2_211_p ksads_2_214_p ksads_2_195_p ksads_2_12_p ksads_2_197_p mnc_racingtp ksads_2_209_p mnc_activityp ksads_2_213_p)


***************************************************************************************************************************************
*** Mood dysregulation (too few cases - but symptoms might still increase)
** Present
egen dsm5_moodd = rowtotal(ksads_3_229_p ksads_3_226_p), miss
egen Dsm5_moodd = rowmean(ksads_3_229_p ksads_3_226_p)


***************************************************************************************************************************************
*** Psychosis

** Present
egen delhal_drug = rowmax(ksads_4_254_p ksads_4_243_p)
egen delhal_affc = rowmax(ksads_4_252_p ksads_4_241_p)

egen dsm5_psyc = rowtotal(ksads_4_258_p ksads_4_230_p ksads_4_237_p ksads_4_239_p ksads_4_256_p ksads_4_247_p ksads_4_245_p ksads_4_16_p ksads_4_234_p ksads_4_18_p ksads_4_236_p ksads_4_235_p ksads_4_232_p ksads_4_248_p ksads_4_250_p), miss
clonevar dsm5_psycr = dsm5_psyc
replace dsm5_psycr = 0 if delhal_drug==1 | delhal_affc==1
egen Dsm5_psyc = rowmean(ksads_4_258_p ksads_4_230_p ksads_4_237_p ksads_4_239_p ksads_4_256_p ksads_4_247_p ksads_4_245_p ksads_4_16_p ksads_4_234_p ksads_4_18_p ksads_4_236_p ksads_4_235_p ksads_4_232_p ksads_4_248_p ksads_4_250_p)
clonevar Dsm5_psycr = Dsm5_psyc 
replace Dsm5_psycr = 0 if delhal_drug==1 | delhal_affc==1


** Past and Present
egen delhal_drugp = rowmax(ksads_4_255_p ksads_4_244_p ksads_4_254_p ksads_4_243_p)
egen delhal_affcp = rowmax(ksads_4_253_p ksads_4_242_p ksads_4_252_p ksads_4_241_p)

egen dsm5_psycp = rowtotal(ksads_4_259_p ksads_4_231_p ksads_4_238_p ksads_4_240_p ksads_4_257_p ksads_4_246_p ksads_4_17_p ksads_4_19_p ksads_4_249_p ksads_4_251_p ksads_4_233_p ksads_4_258_p ksads_4_230_p ksads_4_237_p ksads_4_239_p ksads_4_256_p ksads_4_247_p ksads_4_245_p ksads_4_16_p ksads_4_234_p ksads_4_18_p ksads_4_236_p ksads_4_235_p ksads_4_232_p ksads_4_248_p ksads_4_250_p), miss
clonevar dsm5_psycrp = dsm5_psycp
replace dsm5_psycrp = 0 if delhal_drugp==1 | delhal_affcp==1
egen Dsm5_psycp = rowmean(ksads_4_259_p ksads_4_231_p ksads_4_238_p ksads_4_240_p ksads_4_257_p ksads_4_246_p ksads_4_17_p ksads_4_19_p ksads_4_249_p ksads_4_251_p ksads_4_233_p ksads_4_258_p ksads_4_230_p ksads_4_237_p ksads_4_239_p ksads_4_256_p ksads_4_247_p ksads_4_245_p ksads_4_16_p ksads_4_234_p ksads_4_18_p ksads_4_236_p ksads_4_235_p ksads_4_232_p ksads_4_248_p ksads_4_250_p)
clonevar Dsm5_psycrp = Dsm5_psycp
replace Dsm5_psycrp = 0 if delhal_drugp==1 | delhal_affcp==1


** Past 
egen delhal_drugP = rowmax(ksads_4_255_p ksads_4_244_p)
egen delhal_affcP = rowmax(ksads_4_253_p ksads_4_242_p)

egen dsm5_psycP = rowtotal(ksads_4_259_p ksads_4_231_p ksads_4_238_p ksads_4_240_p ksads_4_257_p ksads_4_246_p ksads_4_17_p ksads_4_19_p ksads_4_249_p ksads_4_251_p ksads_4_233_p), miss
clonevar dsm5_psycrP = dsm5_psycP
replace dsm5_psycrP = 0 if delhal_drugP==1 | delhal_affcP==1
egen Dsm5_psycP = rowmean(ksads_4_259_p ksads_4_231_p ksads_4_238_p ksads_4_240_p ksads_4_257_p ksads_4_246_p ksads_4_17_p ksads_4_19_p ksads_4_249_p ksads_4_251_p ksads_4_233_p)
clonevar Dsm5_psycrP = Dsm5_psycp
replace Dsm5_psycrP = 0 if delhal_drugP==1 | delhal_affcP==1


***************************************************************************************************************************************
*** Separation anxiety

** Present
egen dsm5_sepx = rowtotal(ksads_7_24_p ksads_7_283_p ksads_7_281_p ksads_7_26_p ksads_7_285_p ksads_7_287_p ksads_7_289_p ksads_7_291_p), miss
egen Dsm5_sepx = rowmean(ksads_7_24_p ksads_7_283_p ksads_7_281_p ksads_7_26_p ksads_7_285_p ksads_7_287_p ksads_7_289_p ksads_7_291_p)

** Past and Present
egen dsm5_sepxp = rowtotal(ksads_7_25_p ksads_7_284_p ksads_7_282_p ksads_7_27_p ksads_7_286_p ksads_7_288_p ksads_7_290_p ksads_7_292_p ksads_7_24_p ksads_7_283_p ksads_7_281_p ksads_7_26_p ksads_7_285_p ksads_7_287_p ksads_7_289_p ksads_7_291_p), miss
egen Dsm5_sepxp = rowmean(ksads_7_25_p ksads_7_284_p ksads_7_282_p ksads_7_27_p ksads_7_286_p ksads_7_288_p ksads_7_290_p ksads_7_292_p ksads_7_24_p ksads_7_283_p ksads_7_281_p ksads_7_26_p ksads_7_285_p ksads_7_287_p ksads_7_289_p ksads_7_291_p)

** Past
egen dsm5_sepxP = rowtotal(ksads_7_25_p ksads_7_284_p ksads_7_282_p ksads_7_27_p ksads_7_286_p ksads_7_288_p ksads_7_290_p ksads_7_292_p), miss
egen Dsm5_sepxP = rowmean(ksads_7_25_p ksads_7_284_p ksads_7_282_p ksads_7_27_p ksads_7_286_p ksads_7_288_p ksads_7_290_p ksads_7_292_p)


***************************************************************************************************************************************
*** Anxiety problems

** Present
egen dsm5_anxpb = rowtotal(ksads_5_20_p ksads_5_261_p ksads_6_22_p ksads_6_272_p ksads_8_29_p ksads_8_307_p ksads_9_41_p ksads_9_34_p ksads_10_45_p ksads_10_320_p ksads_11_48_p ksads_11_50_p ksads_12_52_p ksads_12_60_p), miss
egen Dsm5_anxpb = rowmean(ksads_5_20_p ksads_5_261_p ksads_6_22_p ksads_6_272_p ksads_8_29_p ksads_8_307_p ksads_9_41_p ksads_9_34_p ksads_10_45_p ksads_10_320_p ksads_11_48_p ksads_11_50_p ksads_12_52_p ksads_12_60_p)

** Past and Present
egen dsm5_anxpbp = rowtotal(ksads_5_21_p ksads_5_262_p ksads_6_23_p ksads_6_273_p ksads_8_31_p ksads_8_308_p ksads_9_42_p ksads_9_35_p ksads_10_46_p ksads_10_321_p ksads_11_49_p ksads_11_51_p ksads_12_53_p ksads_12_61_p ksads_5_20_p ksads_5_261_p ksads_6_22_p ksads_6_272_p ksads_8_29_p ksads_8_307_p ksads_9_41_p ksads_9_34_p ksads_10_45_p ksads_10_320_p ksads_11_48_p ksads_11_50_p ksads_12_52_p ksads_12_60_p), miss
egen Dsm5_anxpbp = rowmean(ksads_5_21_p ksads_5_262_p ksads_6_23_p ksads_6_273_p ksads_8_31_p ksads_8_308_p ksads_9_42_p ksads_9_35_p ksads_10_46_p ksads_10_321_p ksads_11_49_p ksads_11_51_p ksads_12_53_p ksads_12_61_p ksads_5_20_p ksads_5_261_p ksads_6_22_p ksads_6_272_p ksads_8_29_p ksads_8_307_p ksads_9_41_p ksads_9_34_p ksads_10_45_p ksads_10_320_p ksads_11_48_p ksads_11_50_p ksads_12_52_p ksads_12_60_p)


***************************************************************************************************************************************
*** Eating disorders

** Present
egen dsm5_eatd = rowtotal(ksads_13_469_p ksads_13_470_p ksads_13_74_p ksads_13_475_p ksads_13_68_p ksads_13_66_p ksads_13_70_p ksads_13_72_p), miss
egen Dsm5_eatd = rowmean(ksads_13_469_p ksads_13_470_p ksads_13_74_p ksads_13_475_p ksads_13_68_p ksads_13_66_p ksads_13_70_p ksads_13_72_p)

** Past and Present
egen dsm5_eatdp = rowtotal(ksads_13_476_p ksads_13_477_p ksads_13_75_p ksads_13_480_p ksads_13_69_p ksads_13_67_p ksads_13_71_p ksads_13_73_p ksads_13_469_p ksads_13_470_p ksads_13_74_p ksads_13_475_p ksads_13_68_p ksads_13_66_p ksads_13_70_p ksads_13_72_p), miss
egen Dsm5_eatdp = rowmean(ksads_13_476_p ksads_13_477_p ksads_13_75_p ksads_13_480_p ksads_13_69_p ksads_13_67_p ksads_13_71_p ksads_13_73_p ksads_13_469_p ksads_13_470_p ksads_13_74_p ksads_13_475_p ksads_13_68_p ksads_13_66_p ksads_13_70_p ksads_13_72_p)


***************************************************************************************************************************************
*** ADHD

** Present
egen dsm5_adhdina = rowtotal(ksads_14_394_p ksads_14_76_p ksads_14_395_p ksads_14_396_p ksads_14_397_p ksads_14_398_p ksads_14_399_p ksads_14_80_p ksads_14_400_p), miss
egen Dsm5_adhdina = rowmean(ksads_14_394_p ksads_14_76_p ksads_14_395_p ksads_14_396_p ksads_14_397_p ksads_14_398_p ksads_14_399_p ksads_14_80_p ksads_14_400_p)

egen dsm5_adhdimp = rowtotal(ksads_14_401_p ksads_14_84_p ksads_14_402_p ksads_14_404_p ksads_14_403_p ksads_14_408_p ksads_14_405_p ksads_14_406_p ksads_14_407_p), miss
egen Dsm5_adhdimp = rowmean(ksads_14_401_p ksads_14_84_p ksads_14_402_p ksads_14_404_p ksads_14_403_p ksads_14_408_p ksads_14_405_p ksads_14_406_p ksads_14_407_p)

egen dsm5_adhd = rowtotal(ksads_14_394_p ksads_14_76_p ksads_14_395_p ksads_14_396_p ksads_14_397_p ksads_14_398_p ksads_14_399_p ksads_14_80_p ksads_14_400_p ksads_14_401_p ksads_14_84_p ksads_14_402_p ksads_14_404_p ksads_14_403_p ksads_14_408_p ksads_14_405_p ksads_14_406_p ksads_14_407_p), miss
egen Dsm5_adhd = rowmean(ksads_14_394_p ksads_14_76_p ksads_14_395_p ksads_14_396_p ksads_14_397_p ksads_14_398_p ksads_14_399_p ksads_14_80_p ksads_14_400_p ksads_14_401_p ksads_14_84_p ksads_14_402_p ksads_14_404_p ksads_14_403_p ksads_14_408_p ksads_14_405_p ksads_14_406_p ksads_14_407_p)

** Past
egen dsm5_adhdinaP = rowtotal(ksads_14_410_p ksads_14_78_p ksads_14_411_p ksads_14_412_p ksads_14_413_p ksads_14_414_p ksads_14_415_p ksads_14_82_p ksads_14_416_p), miss
egen Dsm5_adhdinaP = rowmean(ksads_14_410_p ksads_14_78_p ksads_14_411_p ksads_14_412_p ksads_14_413_p ksads_14_414_p ksads_14_415_p ksads_14_82_p ksads_14_416_p)

egen dsm5_adhdimpP = rowtotal(ksads_14_417_p ksads_14_86_p ksads_14_418_p ksads_14_420_p ksads_14_419_p ksads_14_424_p ksads_14_421_p ksads_14_422_p ksads_14_423_p), miss
egen Dsm5_adhdimpP = rowmean(ksads_14_417_p ksads_14_86_p ksads_14_418_p ksads_14_420_p ksads_14_419_p ksads_14_424_p ksads_14_421_p ksads_14_422_p ksads_14_423_p)

egen dsm5_adhdP = rowtotal(ksads_14_410_p ksads_14_78_p ksads_14_411_p ksads_14_412_p ksads_14_413_p ksads_14_414_p ksads_14_415_p ksads_14_82_p ksads_14_416_p ksads_14_417_p ksads_14_86_p ksads_14_418_p ksads_14_420_p ksads_14_419_p ksads_14_424_p ksads_14_421_p ksads_14_422_p ksads_14_423_p), miss

egen Dsm5_adhdP = rowmean(ksads_14_410_p ksads_14_78_p ksads_14_411_p ksads_14_412_p ksads_14_413_p ksads_14_414_p ksads_14_415_p ksads_14_82_p ksads_14_416_p ksads_14_417_p ksads_14_86_p ksads_14_418_p ksads_14_420_p ksads_14_419_p ksads_14_424_p ksads_14_421_p ksads_14_422_p ksads_14_423_p)


** Past and Present
egen dsm5_adhdinap = rowtotal(ksads_14_410_p ksads_14_78_p ksads_14_411_p ksads_14_412_p ksads_14_414_p ksads_14_415_p ksads_14_82_p ksads_14_416_p ksads_14_394_p ksads_14_76_p ksads_14_395_p ksads_14_396_p ksads_14_398_p ksads_14_399_p ksads_14_80_p ksads_14_400_p), miss
egen Dsm5_adhdinap = rowmean(ksads_14_410_p ksads_14_78_p ksads_14_411_p ksads_14_412_p ksads_14_414_p ksads_14_415_p ksads_14_82_p ksads_14_416_p ksads_14_394_p ksads_14_76_p ksads_14_395_p ksads_14_396_p ksads_14_398_p ksads_14_399_p ksads_14_80_p ksads_14_400_p)

egen dsm5_adhdimpp = rowtotal(ksads_14_417_p ksads_14_86_p ksads_14_418_p ksads_14_420_p ksads_14_419_p ksads_14_424_p ksads_14_421_p ksads_14_422_p ksads_14_423_p ksads_14_401_p ksads_14_84_p ksads_14_402_p ksads_14_404_p ksads_14_403_p ksads_14_408_p ksads_14_405_p ksads_14_406_p ksads_14_407_p), miss
egen Dsm5_adhdimpp = rowmean(ksads_14_417_p ksads_14_86_p ksads_14_418_p ksads_14_420_p ksads_14_419_p ksads_14_424_p ksads_14_421_p ksads_14_422_p ksads_14_423_p ksads_14_401_p ksads_14_84_p ksads_14_402_p ksads_14_404_p ksads_14_403_p ksads_14_408_p ksads_14_405_p ksads_14_406_p ksads_14_407_p)

egen dsm5_adhdp = rowtotal(ksads_14_410_p ksads_14_78_p ksads_14_411_p ksads_14_412_p ksads_14_414_p ksads_14_415_p ksads_14_82_p ksads_14_416_p ksads_14_394_p ksads_14_76_p ksads_14_395_p ksads_14_396_p ksads_14_398_p ksads_14_399_p ksads_14_80_p ksads_14_400_p ksads_14_417_p ksads_14_86_p ksads_14_418_p ksads_14_420_p ksads_14_419_p ksads_14_424_p ksads_14_421_p ksads_14_422_p ksads_14_423_p ksads_14_401_p ksads_14_84_p ksads_14_402_p ksads_14_404_p ksads_14_403_p ksads_14_408_p ksads_14_405_p ksads_14_406_p ksads_14_407_p), miss
egen Dsm5_adhdp = rowmean(ksads_14_410_p ksads_14_78_p ksads_14_411_p ksads_14_412_p ksads_14_414_p ksads_14_415_p ksads_14_82_p ksads_14_416_p ksads_14_394_p ksads_14_76_p ksads_14_395_p ksads_14_396_p ksads_14_398_p ksads_14_399_p ksads_14_80_p ksads_14_400_p ksads_14_417_p ksads_14_86_p ksads_14_418_p ksads_14_420_p ksads_14_419_p ksads_14_424_p ksads_14_421_p ksads_14_422_p ksads_14_423_p ksads_14_401_p ksads_14_84_p ksads_14_402_p ksads_14_404_p ksads_14_403_p ksads_14_408_p ksads_14_405_p ksads_14_406_p ksads_14_407_p)


***************************************************************************************************************************************
*** ODD

** Present
egen dsm5_odd = rowtotal(ksads_15_91_p ksads_15_432_p ksads_15_433_p ksads_15_93_p ksads_15_95_p ksads_15_435_p ksads_15_436_p ksads_15_434_p), miss
egen Dsm5_odd = rowmean(ksads_15_91_p ksads_15_432_p ksads_15_433_p ksads_15_93_p ksads_15_95_p ksads_15_435_p ksads_15_436_p ksads_15_434_p)

** Past and Present
egen dsm5_oddp = rowtotal(ksads_15_92_p ksads_15_439_p ksads_15_440_p ksads_15_94_p ksads_15_96_p ksads_15_442_p ksads_15_436_p ksads_15_441_p ksads_15_91_p ksads_15_432_p ksads_15_433_p ksads_15_93_p ksads_15_95_p ksads_15_435_p ksads_15_436_p ksads_15_434_p), miss
egen Dsm5_oddp = rowmean(ksads_15_92_p ksads_15_439_p ksads_15_440_p ksads_15_94_p ksads_15_96_p ksads_15_442_p ksads_15_436_p ksads_15_441_p ksads_15_91_p ksads_15_432_p ksads_15_433_p ksads_15_93_p ksads_15_95_p ksads_15_435_p ksads_15_436_p ksads_15_434_p)


** Past 
egen dsm5_oddP = rowtotal(ksads_15_92_p ksads_15_439_p ksads_15_440_p ksads_15_94_p ksads_15_96_p ksads_15_442_p ksads_15_436_p ksads_15_441_p), miss
egen Dsm5_oddP = rowmean(ksads_15_92_p ksads_15_439_p ksads_15_440_p ksads_15_94_p ksads_15_96_p ksads_15_442_p ksads_15_436_p ksads_15_441_p)


***************************************************************************************************************************************
*** Conduct disorder

** Present
egen dsm5_condd = rowtotal(ksads_16_104_p ksads_16_102_p ksads_16_459_p ksads_16_461_p ksads_16_465_p ksads_16_451_p ksads_16_463_p ksads_16_447_p ksads_16_453_p ksads_16_449_p ksads_16_98_p ksads_16_106_p ksads_16_455_p ksads_16_457_p ksads_16_100_p), miss
egen Dsm5_condd = rowmean(ksads_16_104_p ksads_16_102_p ksads_16_459_p ksads_16_461_p ksads_16_465_p ksads_16_451_p ksads_16_463_p ksads_16_447_p ksads_16_453_p ksads_16_449_p ksads_16_98_p ksads_16_106_p ksads_16_455_p ksads_16_457_p ksads_16_100_p)

** Past and Present
egen dsm5_conddp = rowtotal(ksads_16_105_p ksads_16_103_p ksads_16_460_p ksads_16_462_p ksads_16_466_p ksads_16_452_p ksads_16_464_p ksads_16_448_p ksads_16_454_p ksads_16_450_p ksads_16_99_p ksads_16_107_p ksads_16_456_p ksads_16_458_p ksads_16_101_p ksads_16_104_p ksads_16_102_p ksads_16_459_p ksads_16_461_p ksads_16_465_p ksads_16_451_p ksads_16_463_p ksads_16_447_p ksads_16_453_p ksads_16_449_p ksads_16_98_p ksads_16_106_p ksads_16_455_p ksads_16_457_p ksads_16_100_p), miss
egen Dsm5_conddp = rowmean(ksads_16_105_p ksads_16_103_p ksads_16_460_p ksads_16_462_p ksads_16_466_p ksads_16_452_p ksads_16_464_p ksads_16_448_p ksads_16_454_p ksads_16_450_p ksads_16_99_p ksads_16_107_p ksads_16_456_p ksads_16_458_p ksads_16_101_p ksads_16_104_p ksads_16_102_p ksads_16_459_p ksads_16_461_p ksads_16_465_p ksads_16_451_p ksads_16_463_p ksads_16_447_p ksads_16_453_p ksads_16_449_p ksads_16_98_p ksads_16_106_p ksads_16_455_p ksads_16_457_p ksads_16_100_p)


***************************************************************************************************************************************
*** Suicide ideation/plan/attempt

** Present
egen dsm5_suicb = rowtotal(ksads_23_813_p ksads_23_814_p ksads_23_809_p ksads_23_149_p ksads_23_812_p ksads_23_808_p ksads_23_807_p ksads_23_143_p ksads_23_145_p ksads_23_810_p ksads_23_147_p ksads_23_811_p ksads_23_815_p), miss
egen Dsm5_suicb = rowmean(ksads_23_813_p ksads_23_814_p ksads_23_809_p ksads_23_149_p ksads_23_812_p ksads_23_808_p ksads_23_807_p ksads_23_143_p ksads_23_145_p ksads_23_810_p ksads_23_147_p ksads_23_811_p ksads_23_815_p)

** Past and Present
egen dsm5_suicbp = rowtotal(ksads_23_822_p ksads_23_144_p ksads_23_818_p ksads_23_825_p ksads_23_150_p ksads_23_821_p ksads_23_817_p ksads_23_816_p ksads_23_146_p ksads_23_819_p ksads_23_148_p ksads_23_820_p ksads_23_824_p ksads_23_813_p ksads_23_814_p ksads_23_809_p ksads_23_149_p ksads_23_812_p ksads_23_808_p ksads_23_807_p ksads_23_143_p ksads_23_145_p ksads_23_810_p ksads_23_147_p ksads_23_811_p ksads_23_815_p), miss
egen Dsm5_suicbp = rowmean(ksads_23_822_p ksads_23_144_p ksads_23_818_p ksads_23_825_p ksads_23_150_p ksads_23_821_p ksads_23_817_p ksads_23_816_p ksads_23_146_p ksads_23_819_p ksads_23_148_p ksads_23_820_p ksads_23_824_p ksads_23_813_p ksads_23_814_p ksads_23_809_p ksads_23_149_p ksads_23_812_p ksads_23_808_p ksads_23_807_p ksads_23_143_p ksads_23_145_p ksads_23_810_p ksads_23_147_p ksads_23_811_p ksads_23_815_p)

** Past 
egen dsm5_suicbP = rowtotal(ksads_23_822_p ksads_23_144_p ksads_23_818_p ksads_23_825_p ksads_23_150_p ksads_23_821_p ksads_23_817_p ksads_23_816_p ksads_23_146_p ksads_23_819_p ksads_23_148_p ksads_23_820_p ksads_23_824_p), miss
egen Dsm5_suicbP = rowmean(ksads_23_822_p ksads_23_144_p ksads_23_818_p ksads_23_825_p ksads_23_150_p ksads_23_821_p ksads_23_817_p ksads_23_816_p ksads_23_146_p ksads_23_819_p ksads_23_148_p ksads_23_820_p ksads_23_824_p)


global dsm5p_axdppy "ksads_1_843_p ksads_1_840_p ksads_1_846_p ksads_2_835_p ksads_2_836_p ksads_2_831_p ksads_2_832_p ksads_2_830_p ksads_2_838_p ksads_3_848_p ksads_4_826_p ksads_4_828_p ksads_4_851_p ksads_4_849_p ksads_5_906_p ksads_5_857_p ksads_6_859_p ksads_6_908_p ksads_7_861_p ksads_7_909_p ksads_8_863_p ksads_8_911_p ksads_9_867_p ksads_10_913_p ksads_10_869_p ksads_11_917_p ksads_11_919_p ksads_12_925_p ksads_12_927_p ksads_13_938_p ksads_13_929_p ksads_13_932_p ksads_13_930_p ksads_13_935_p ksads_13_942_p ksads_13_941_p ksads_17_904_p ksads_21_923_p ksads_21_921_p ksads_21_923_p ksads_25_915_p ksads_25_865_p"
global dsm5p_devdis "ksads_14_853_p ksads_18_903_p"
global dsm5p_condis "ksads_15_901_p ksads_16_897_p ksads_16_898_p"
global dsm5p_subdis "ksads_19_891_p ksads_19_895_p ksads_20_893_p ksads_20_874_p ksads_20_872_p ksads_20_889_p ksads_20_878_p ksads_20_877_p ksads_20_875_p ksads_20_876_p ksads_20_879_p ksads_20_873_p ksads_20_871_p"
global dsm5p_suibeh "ksads_23_946_p ksads_23_954_p ksads_23_945_p ksads_23_950_p ksads_23_947_p ksads_23_948_p ksads_23_949_p ksads_23_952_p ksads_23_955_p ksads_23_951_p ksads_23_953_p ksads_24_967_p"

global dsm5_MDD "ksads_1_1_p ksads_1_3_p ksads_1_5_p ksads_22_141_p ksads_23_143_p ksads_23_145_p ksads_23_147_p ksads_23_149_p ksads_1_157_p ksads_1_159_p ksads_1_161_p ksads_1_163_p ksads_1_165_p ksads_1_167_p ksads_1_169_p ksads_1_171_p ksads_1_173_p ksads_1_175_p ksads_1_177_p ksads_1_179_p ksads_1_181_p ksads_1_183_p ksads_22_142_p ksads_23_144_p ksads_23_146_p ksads_23_148_p ksads_23_150_p ksads_1_158_p ksads_1_160_p ksads_1_162_p ksads_1_164_p ksads_1_166_p ksads_1_168_p ksads_1_170_p ksads_1_172_p ksads_1_174_p ksads_1_176_p ksads_1_178_p ksads_1_180_p ksads_1_182_p ksads_1_184_p"

global dsm5_ADHD "ksads_14_394_p ksads_14_76_p ksads_14_395_p ksads_14_396_p ksads_14_397_p ksads_14_398_p ksads_14_399_p ksads_14_80_p ksads_14_400_p ksads_14_401_p ksads_14_84_p ksads_14_402_p ksads_14_404_p ksads_14_403_p ksads_14_408_p ksads_14_405_p ksads_14_406_p ksads_14_407_p ksads_14_410_p ksads_14_78_p ksads_14_411_p ksads_14_412_p ksads_14_413_p ksads_14_414_p ksads_14_415_p ksads_14_82_p ksads_14_416_p ksads_14_417_p ksads_14_86_p ksads_14_418_p ksads_14_420_p ksads_14_419_p ksads_14_424_p ksads_14_421_p ksads_14_422_p ksads_14_423_p"



keep 	subjectkey src_subject_id eventname										///
		$dsm5p_axdppy $dsm5p_devdis $dsm5p_condis $dsm5p_subdis $dsm5p_suibeh	///
		ksads_22_969_p delusionsp_c psychotic_c hallucina_c uschizoph_c			///
		bpimanic_c bpidepre_c bpihyman_c bpiidepre_c bpiihyman_c bpunspec_c		///
		Dsm5_mdd Dsm5_dys Dsm5_manic Dsm5_psyc Dsm5_psycr Dsm5_sepx 			///
		Dsm5_anxpb Dsm5_eatd Dsm5_adhdina Dsm5_adhdimp Dsm5_adhd Dsm5_odd 		///
		Dsm5_condd Dsm5_suicb 													///
		Dsm5_mddp Dsm5_dysp Dsm5_manicp Dsm5_psycp  							///
		Dsm5_sepxp Dsm5_anxpbp Dsm5_eatdp Dsm5_adhdinap Dsm5_adhdimpp 			///
		Dsm5_adhdp Dsm5_oddp Dsm5_conddp Dsm5_suicbp							///
		dsm5_mdd dsm5_dys dsm5_manic dsm5_psyc dsm5_psycr dsm5_sepx 			///
		dsm5_anxpb dsm5_eatd dsm5_adhdina dsm5_adhdimp dsm5_adhd dsm5_odd 		///
		dsm5_condd dsm5_suicb 													///
		dsm5_mddp dsm5_dysp dsm5_manicp dsm5_psycp  							///
		dsm5_sepxp dsm5_anxpbp dsm5_eatdp dsm5_adhdinap dsm5_adhdimpp 			///
		dsm5_adhdp dsm5_oddp dsm5_conddp dsm5_suicbp dpr_eating dpr_sleep 		///
		dpr_motor dpr_energy drp_worth drp_decis drp_suic mdd_first mdd_second 	///
		mdd_diagn dsm5_mddvm $dsm5_MDD $dsm5_ADHD dsm5_adhdinaP Dsm5_adhdinaP 	///
		dsm5_adhdimpP Dsm5_adhdimpP dsm5_adhdP Dsm5_adhdP dsm5_mddvmP 			///
		dsm5_mddP Dsm5_mddP ksads_1_2_p ksads_1_4_p ksads_1_6_p dpr_eatingP 	///
		dpr_sleepP dpr_motorP dpr_energyP drp_worthP drp_decisP drp_suicP		///
		dsm5_sepxP Dsm5_sepxP delhal_drugP delhal_affcP delhal_drug delhal_affc ///
		delhal_drugp delhal_affcp dsm5_psycr Dsm5_psycr dsm5_psycrp Dsm5_psycrp ///
		dsm5_psycrP Dsm5_psycrP Dsm5_psycP dsm5_oddP Dsm5_oddP dsm5_suicbP 		///
		Dsm5_suicbP
*Dsm5_psycprp dsm5_psycprp
		
tempfile dsm5dgnsp
save `dsm5dgnsp'


**************************************************************************************
*************************************** 26 *******************************************
**************************************************************************************
**** Loading data on mental health diagnoses and symptoms (youth report)
clear
import delimited "$data\abcd_ksad501.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1


** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


/*
** Diagnoses
* Ideation-passive
rename ksads_23_946_t sideapy_c
rename ksads_23_957_t sideapy_p

* Ideation-active on specific
rename ksads_23_947_t sideaay_c
rename ksads_23_958_t sideaay_p

* Ideation-active method
rename ksads_23_948_t sideamy_c
rename ksads_23_959_t sideamy_p

* Ideation-active intent
rename ksads_23_949_t sideaiy_c
rename ksads_23_960_t sideaiy_p

* Ideation-active plan
rename ksads_23_950_t sidealy_c
rename ksads_23_961_t sidealy_p

* Attempt
rename ksads_23_953_t sattemy_c
rename ksads_23_965_t sattemy_p
*/


*** Symptoms
global depress_present "ksads_1_171_t ksads_1_167_t ksads_1_3_t ksads_1_163_t ksads_1_169_t ksads_1_175_t ksads_1_173_t ksads_1_181_t ksads_1_165_t ksads_1_1_t ksads_1_5_t ksads_1_161_t ksads_1_159_t ksads_1_183_t ksads_1_157_t ksads_1_177_t ksads_1_179_t ksads_22_141_t ksads_23_149_t ksads_23_147_t"
global bipolar_present "ksads_2_12_t ksads_2_209_t ksads_2_195_t ksads_2_14_t ksads_2_217_t ksads_2_215_t ksads_2_201_t ksads_2_213_t ksads_2_9_t ksads_2_7_t ksads_2_191_t ksads_2_189_t ksads_2_197_t ksads_2_207_t ksads_2_199_t ksads_2_210_t ksads_2_203_t ksads_2_205_t ksads_2_192_t"
global mooddys_present "ksads_3_229_t ksads_3_226_t"
global psychos_present "ksads_4_258_t ksads_4_230_t ksads_4_252_t ksads_4_254_t ksads_4_243_t ksads_4_241_t ksads_4_237_t ksads_4_239_t ksads_4_256_t ksads_4_247_t ksads_4_245_t ksads_4_16_t ksads_4_234_t ksads_4_18_t ksads_4_236_t ksads_4_235_t ksads_4_232_t ksads_4_248_t ksads_4_250_t"
global panic_present "ksads_5_261_t ksads_5_263_t ksads_5_20_t ksads_5_265_t ksads_5_267_t ksads_5_269_t"
global agaroph_present "ksads_6_274_t ksads_6_276_t ksads_6_278_t ksads_6_22_t ksads_6_272_t"
global sepanx_present "ksads_7_300_t ksads_7_26_t ksads_7_287_t ksads_7_291_t ksads_7_293_t ksads_7_289_t ksads_7_295_t ksads_7_24_t ksads_7_281_t ksads_7_285_t ksads_7_297_t ksads_7_283_t"
global socanx_present "ksads_8_309_t ksads_8_29_t ksads_8_30_t ksads_8_311_t ksads_8_307_t ksads_8_303_t ksads_8_301_t"
global genanx_present "ksads_10_45_t ksads_10_320_t ksads_10_324_t ksads_10_328_t ksads_10_326_t ksads_10_47_t ksads_10_322_t"
global obscomp_present "ksads_11_343_t ksads_11_331_t ksads_11_48_t ksads_11_335_t ksads_11_341_t ksads_11_50_t ksads_11_339_t ksads_11_347_t ksads_11_333_t ksads_11_345_t ksads_11_337_t"
global social_probprpt "ksads_5_20_t ksads_5_261_t ksads_6_22_t ksads_6_272_t ksads_8_29_t ksads_8_307_t ksads_9_41_t ksads_9_34_t ksads_10_45_t ksads_10_320_t ksads_11_48_t ksads_11_50_t ksads_12_52_t ksads_12_56_t ksads_12_60_t ksads_12_62_t"
global eatdis_present "ksads_13_469_t ksads_13_470_t ksads_13_473_t ksads_13_471_t ksads_13_74_t ksads_13_472_t ksads_13_475_t ksads_13_68_t ksads_13_66_t ksads_13_70_t ksads_13_72_t"
global adhd_present "ksads_14_398_t ksads_14_403_t ksads_14_405_t ksads_14_406_t ksads_14_76_t ksads_14_396_t ksads_14_397_t ksads_14_404_t ksads_14_85_t ksads_14_77_t ksads_14_84_t ksads_14_401_t ksads_14_80_t ksads_14_81_t ksads_14_400_t ksads_14_88_t ksads_14_399_t ksads_14_408_t ksads_14_394_t ksads_14_395_t ksads_14_407_t ksads_14_402_t ksads_14_409_t ksads_14_429_t"
global oppdef_present "ksads_15_95_t ksads_15_436_t ksads_15_435_t ksads_15_433_t ksads_15_93_t ksads_15_432_t ksads_15_91_t ksads_15_438_t ksads_15_437_t ksads_15_434_t"
global condu_present "ksads_16_449_t ksads_16_463_t ksads_16_453_t ksads_16_461_t ksads_16_465_t ksads_16_98_t ksads_16_104_t ksads_16_102_t ksads_16_457_t ksads_16_455_t ksads_16_451_t ksads_16_106_t ksads_16_100_t ksads_16_447_t ksads_16_459_t"
global autism_present "ksads_18_116_t ksads_18_112_t ksads_18_114_t"
global alcoh_present "ksads_19_500_t ksads_19_499_t ksads_19_508_t ksads_19_493_t ksads_19_481_t ksads_19_501_t ksads_19_483_t ksads_19_491_t ksads_19_489_t ksads_19_485_t ksads_19_497_t ksads_19_122_t ksads_19_495_t ksads_19_120_t ksads_19_498_t ksads_19_486_t"
global drugs_present "ksads_20_126_t ksads_20_545_t ksads_20_590_t ksads_20_620_t ksads_20_665_t ksads_20_575_t ksads_20_650_t ksads_20_560_t ksads_20_521_t ksads_20_635_t" /* There are more symptoms to be added */
global suic_present "ksads_23_807_t ksads_23_808_t ksads_23_809_t ksads_23_810_t ksads_23_811_t ksads_23_812_t ksads_23_813_t ksads_23_814_t ksads_23_815_t ksads_23_143_t ksads_23_145_t"
global symp_past "ksads_22_142_t ksads_1_158_t ksads_1_160_t ksads_1_182_t ksads_1_178_t ksads_1_164_t ksads_1_162_t ksads_23_150_t ksads_23_148_t ksads_23_820_t ksads_23_819_t ksads_23_818_t ksads_1_170_t ksads_1_166_t ksads_1_2_t ksads_1_4_t ksads_1_6_t ksads_1_1_t ksads_1_172_t ksads_1_168_t ksads_1_170_t ksads_1_166_t ksads_4_259_t ksads_4_231_t ksads_4_238_t ksads_4_240_t ksads_4_257_t ksads_4_246_t ksads_4_17_t ksads_4_19_t ksads_4_249_t ksads_4_251_t ksads_4_233_t ksads_2_196_t ksads_2_13_t ksads_2_198_t ksads_2_211_t ksads_2_214_t ksads_2_203_t ksads_2_207_t ksads_7_25_t ksads_7_284_t ksads_7_282_t ksads_7_27_t ksads_7_286_t ksads_7_288_t ksads_7_290_t ksads_7_292_t ksads_5_21_t ksads_5_262_t ksads_6_23_t ksads_6_273_t ksads_8_31_t ksads_8_308_t ksads_9_42_t ksads_9_35_t ksads_10_46_t ksads_10_321_t ksads_11_49_t ksads_11_51_t ksads_12_53_t ksads_12_61_t ksads_13_476_t ksads_13_477_t ksads_13_75_t ksads_13_480_t ksads_13_69_t ksads_13_67_t ksads_13_71_t ksads_13_73_t ksads_14_410_t ksads_14_78_t ksads_14_411_t ksads_14_412_t ksads_14_414_t ksads_14_415_t ksads_14_82_t ksads_14_416_t ksads_14_417_t ksads_14_86_t ksads_14_418_t ksads_14_420_t ksads_14_419_t ksads_14_424_t ksads_14_421_t ksads_14_422_t ksads_14_423_t ksads_15_92_t ksads_15_439_t ksads_15_440_t ksads_15_94_t ksads_15_96_t ksads_15_442_t ksads_15_436_t ksads_15_441_t ksads_16_105_t ksads_16_103_t ksads_16_460_t ksads_16_462_t ksads_16_466_t ksads_16_452_t ksads_16_464_t ksads_16_448_t ksads_16_454_t ksads_16_450_t ksads_16_99_t ksads_16_107_t ksads_16_456_t ksads_16_458_t ksads_16_101_t ksads_23_822_t ksads_23_144_t ksads_23_818_t ksads_23_825_t ksads_23_150_t ksads_23_821_t ksads_23_817_t ksads_23_816_t ksads_23_146_t ksads_23_819_t ksads_23_148_t ksads_23_820_t ksads_23_824_t ksads_2_204_t ksads_2_208_t ksads_2_202_t ksads_2_200_t ksads_1_180_t ksads_1_184_t ksads_1_174_t ksads_1_176_t"

foreach v of varlist $depress_present $bipolar_present $mooddys_present $psychos_present $panic_present $agaroph_present $sepanx_present $socanx_present $genanx_present $obscomp_present $social_probprpt $eatdis_present $adhd_present $oppdef_present $condu_present $autism_present $alcoh_present $drugs_present $suic_present $symp_past{
	replace `v'=. if `v'==555 			/* No answered because failed to answer Level 1 screening */
	replace `v'=0 if `v'==888			/* No answered because failed to pass Level 1 screening */
}

sum $suic_present if eventname=="baseline_year_1_arm_1"
sum $suic_present if eventname=="1_year_follow_up_y_arm_1"
sum $suic_present if eventname=="2_year_follow_up_y_arm_1"

*** Depression
** Present
egen dpr_eating = rowmax(ksads_1_171_t ksads_1_167_t ksads_1_169_t ksads_1_165_t)
egen dpr_sleep = rowmax(ksads_1_157_t ksads_22_141_t)
egen dpr_motor = rowmax(ksads_1_175_t ksads_1_173_t)
egen dpr_energy = rowmax(ksads_1_159_t)
egen drp_worth = rowmax(ksads_1_181_t ksads_1_177_t)
egen drp_decis = rowmax(ksads_1_163_t ksads_1_161_t)
egen drp_suic = rowmax(ksads_23_149_t ksads_23_147_t ksads_23_811_t ksads_23_815_t ksads_23_810_t ksads_23_809_t)

egen dpr_dprirr = rowmax(ksads_1_1_t ksads_1_3_t)
egen dpr_eat2 = rowmax(ksads_1_165_t ksads_1_169_t)

* Major depressive disorder (MDD)
egen dsm5y_mdd = rowtotal(ksads_1_1_t ksads_1_3_t ksads_1_5_t dpr_eating dpr_sleep dpr_motor dpr_energy drp_worth drp_decis drp_suic), miss
egen Dsm5y_mdd = rowmean(ksads_1_1_t ksads_1_3_t ksads_1_5_t dpr_eating dpr_sleep dpr_motor dpr_energy drp_worth drp_decis drp_suic)

egen mddy_first = rowmax(ksads_1_1_t ksads_1_3_t ksads_1_5_t)
egen mddy_second = rowtotal(dpr_eating dpr_sleep dpr_motor dpr_energy drp_worth drp_decis drp_suic)
gen mddy_diagn = (mddy_first==1 & dsm5y_mdd>=5) if dsm5y_mdd<.

* Dysthymia/persistent depression
egen dsm5y_dys = rowtotal(dpr_dprirr dpr_eat2 dpr_energy ksads_1_181_t drp_decis ksads_1_179_t), miss
egen Dsm5y_dys = rowmean(dpr_dprirr dpr_eat2 dpr_energy ksads_1_181_t drp_decis ksads_1_179_t)


** Past and Present
egen dpr_eatingp = rowmax(ksads_1_172_t ksads_1_168_t ksads_1_170_t ksads_1_166_t ksads_1_171_t ksads_1_167_t ksads_1_169_t ksads_1_165_t)
egen dpr_sleepp = rowmax(ksads_22_142_t ksads_1_158_t ksads_1_157_t ksads_22_141_t)
egen dpr_motorp = rowmax(ksads_1_176_t ksads_1_174_t)
egen dpr_energyp = rowmax(ksads_1_160_t ksads_1_159_t)
egen drp_worthp = rowmax(ksads_1_182_t ksads_1_178_t ksads_1_181_t ksads_1_177_t)
egen drp_decisp = rowmax(ksads_1_164_t ksads_1_162_t ksads_1_163_t ksads_1_161_t)
egen drp_suicp = rowmax(ksads_23_150_t ksads_23_148_t ksads_23_820_t ksads_23_819_t ksads_23_818_t ksads_23_149_t ksads_23_147_t ksads_23_811_t ksads_23_815_t ksads_23_810_t ksads_23_809_t)

egen dpr_dprirrp = rowmax(ksads_1_2_t ksads_1_4_t ksads_1_1_t ksads_1_3_t)
egen dpr_eat2p = rowmax(ksads_1_170_t ksads_1_166_t ksads_1_165_t ksads_1_169_t)

* Major depressive disorder (MDD)
egen dsm5y_mddp = rowtotal(ksads_1_2_t ksads_1_4_t ksads_1_6_t ksads_1_1_t ksads_1_3_t ksads_1_5_t dpr_eatingp dpr_sleepp dpr_motorp dpr_energyp drp_worthp drp_decisp drp_suicp), miss
egen Dsm5y_mddp = rowmean(ksads_1_2_t ksads_1_4_t ksads_1_6_t ksads_1_1_t ksads_1_3_t ksads_1_5_t dpr_eatingp dpr_sleepp dpr_motorp dpr_energyp drp_worthp drp_decisp drp_suicp)

* Vargas and Mittal
egen drp_selfinj = rowmax(ksads_23_807_t ksads_23_808_t)
egen dsm5y_mddvm = rowtotal(ksads_1_1_t ksads_1_3_t ksads_1_5_t ksads_22_141_t ksads_23_143_t ksads_23_145_t ksads_23_147_t ksads_23_149_t ksads_1_157_t ksads_1_159_t ksads_1_161_t ksads_1_163_t ksads_1_165_t ksads_1_167_t ksads_1_169_t ksads_1_171_t ksads_1_173_t ksads_1_175_t ksads_1_177_t ksads_1_179_t ksads_1_181_t ksads_1_183_t), miss

* Dysthymia/persistent depression
egen dsm5y_dysp = rowtotal(dpr_dprirr dpr_eat2p dpr_energyp ksads_1_181_t ksads_1_182_t drp_decisp ksads_1_179_t ksads_1_180_t), miss
egen Dsm5y_dysp = rowmean(dpr_dprirr dpr_eat2p dpr_energyp ksads_1_181_t ksads_1_182_t drp_decisp ksads_1_179_t ksads_1_180_t)


** Past

egen drpy_selfinjP = rowmax(ksads_23_816_t ksads_23_817_t)

egen dsm5y_mddvmP = rowtotal(ksads_1_2_t ksads_1_4_t ksads_1_6_t ksads_22_142_t ksads_23_144_t ksads_23_146_t ksads_23_148_t ksads_23_150_t ksads_1_158_t ksads_1_160_t ksads_1_162_t ksads_1_164_t ksads_1_166_t ksads_1_168_t ksads_1_170_t ksads_1_172_t ksads_1_174_t ksads_1_176_t ksads_1_178_t ksads_1_180_t ksads_1_182_t ksads_1_184_t), miss

egen dpr_eatingP = rowmax(ksads_1_172_t ksads_1_168_t ksads_1_170_t ksads_1_166_t)
egen dpr_sleepP = rowmax(ksads_22_142_t ksads_1_158_t)
egen dpr_motorP = rowmax(ksads_1_176_t ksads_1_174_t)
egen dpr_energyP = rowmax(ksads_1_160_t)
egen drp_worthP = rowmax(ksads_1_182_t ksads_1_178_t)
egen drp_decisP = rowmax(ksads_1_164_t ksads_1_162_t)
egen drp_suicP = rowmax(ksads_23_150_t ksads_23_148_t ksads_23_820_t ksads_23_819_t ksads_23_818_t)

egen dpr_dprirrP = rowmax(ksads_1_2_t ksads_1_4_t)
egen dpr_eat2P = rowmax(ksads_1_170_t ksads_1_166_t)

* Major depressive disorder (MDD)
egen dsm5y_mddP = rowtotal(ksads_1_2_t ksads_1_4_t ksads_1_6_t dpr_eatingP dpr_sleepP dpr_motorP dpr_energyP drp_worthP drp_decisP drp_suicP), miss
egen Dsm5y_mddP = rowmean(ksads_1_2_t ksads_1_4_t ksads_1_6_t dpr_eatingP dpr_sleepP dpr_motorP dpr_energyP drp_worthP drp_decisP drp_suicP)


***************************************************************************************************************************************
*** Bipolar
** Present
egen mnc_racingt = rowmax(ksads_2_201_t ksads_2_199_t)
egen mnc_activity = rowmax(ksads_2_203_t ksads_2_207_t)

* Manic or hypomanic episode
egen dsm5y_manic = rowtotal(ksads_2_195_t ksads_2_12_t ksads_2_197_t mnc_racingt ksads_2_209_t mnc_activity ksads_2_213_t), miss
egen Dsm5y_manic = rowmean(ksads_2_195_t ksads_2_12_t ksads_2_197_t mnc_racingt ksads_2_209_t mnc_activity ksads_2_213_t)

** Past and Present
egen mnc_racingtp = rowmax(ksads_2_202_t ksads_2_200_t ksads_2_201_t ksads_2_199_t)
egen mnc_activityp = rowmax(ksads_2_203_t ksads_2_207_t ksads_2_204_t ksads_2_208_t)

* Manic or hypomanic episode
egen dsm5y_manicp = rowtotal(ksads_2_196_t ksads_2_13_t ksads_2_198_t ksads_2_211_t ksads_2_214_t ksads_2_195_t ksads_2_12_t ksads_2_197_t mnc_racingtp ksads_2_209_t mnc_activityp ksads_2_213_t), miss
egen Dsm5y_manicp = rowmean(ksads_2_196_t ksads_2_13_t ksads_2_198_t ksads_2_211_t ksads_2_214_t ksads_2_195_t ksads_2_12_t ksads_2_197_t mnc_racingtp ksads_2_209_t mnc_activityp ksads_2_213_t)


***************************************************************************************************************************************
*** Anxiety problems

** Present
egen dsm5y_anxpb = rowtotal(ksads_8_29_t ksads_8_307_t ksads_10_45_t ksads_10_320_t), miss
egen Dsm5y_anxpb = rowmean(ksads_8_29_t ksads_8_307_t ksads_10_45_t ksads_10_320_t)

** Past and Present
egen dsm5y_anxpbp = rowtotal(ksads_8_31_t ksads_8_308_t ksads_10_46_t ksads_10_321_t ksads_8_29_t ksads_8_307_t ksads_10_45_t ksads_10_320_t), miss
egen Dsm5y_anxpbp = rowmean(ksads_8_31_t ksads_8_308_t ksads_10_46_t ksads_10_321_t ksads_8_29_t ksads_8_307_t ksads_10_45_t ksads_10_320_t)


***************************************************************************************************************************************
*** Suicide ideation/plan/attempt

** Present
egen dsm5y_suicb = rowtotal(ksads_23_813_t ksads_23_814_t ksads_23_809_t ksads_23_149_t ksads_23_812_t ksads_23_808_t ksads_23_807_t ksads_23_143_t ksads_23_145_t ksads_23_810_t ksads_23_147_t ksads_23_811_t ksads_23_815_t), miss
egen Dsm5y_suicb = rowmean(ksads_23_813_t ksads_23_814_t ksads_23_809_t ksads_23_149_t ksads_23_812_t ksads_23_808_t ksads_23_807_t ksads_23_143_t ksads_23_145_t ksads_23_810_t ksads_23_147_t ksads_23_811_t ksads_23_815_t)

** Past and Present
egen dsm5y_suicbp = rowtotal(ksads_23_822_t ksads_23_144_t ksads_23_818_t ksads_23_825_t ksads_23_150_t ksads_23_821_t ksads_23_817_t ksads_23_816_t ksads_23_146_t ksads_23_819_t ksads_23_148_t ksads_23_820_t ksads_23_824_t ksads_23_813_t ksads_23_814_t ksads_23_809_t ksads_23_149_t ksads_23_812_t ksads_23_808_t ksads_23_807_t ksads_23_143_t ksads_23_145_t ksads_23_810_t ksads_23_147_t ksads_23_811_t ksads_23_815_t), miss
egen Dsm5y_suicbp = rowmean(ksads_23_822_t ksads_23_144_t ksads_23_818_t ksads_23_825_t ksads_23_150_t ksads_23_821_t ksads_23_817_t ksads_23_816_t ksads_23_146_t ksads_23_819_t ksads_23_148_t ksads_23_820_t ksads_23_824_t ksads_23_813_t ksads_23_814_t ksads_23_809_t ksads_23_149_t ksads_23_812_t ksads_23_808_t ksads_23_807_t ksads_23_143_t ksads_23_145_t ksads_23_810_t ksads_23_147_t ksads_23_811_t ksads_23_815_t)

** Past
egen dsm5y_suicbP = rowtotal(ksads_23_822_t ksads_23_144_t ksads_23_818_t ksads_23_825_t ksads_23_150_t ksads_23_821_t ksads_23_817_t ksads_23_816_t ksads_23_146_t ksads_23_819_t ksads_23_148_t ksads_23_820_t ksads_23_824_t ksads_23_813_t ksads_23_814_t ksads_23_809_t ksads_23_149_t ksads_23_812_t ksads_23_808_t ksads_23_807_t ksads_23_143_t ksads_23_145_t ksads_23_810_t ksads_23_147_t ksads_23_811_t ksads_23_815_t), miss
egen Dsm5y_suicbP = rowmean(ksads_23_822_t ksads_23_144_t ksads_23_818_t ksads_23_825_t ksads_23_150_t ksads_23_821_t ksads_23_817_t ksads_23_816_t ksads_23_146_t ksads_23_819_t ksads_23_148_t ksads_23_820_t ksads_23_824_t ksads_23_813_t ksads_23_814_t ksads_23_809_t ksads_23_149_t ksads_23_812_t ksads_23_808_t ksads_23_807_t ksads_23_143_t ksads_23_145_t ksads_23_810_t ksads_23_147_t ksads_23_811_t ksads_23_815_t)



global dsm5y_mentalh "ksads_4_826_t ksads_4_828_t ksads_2_830_t ksads_2_832_t ksads_2_835_t ksads_2_836_t ksads_2_838_t ksads_1_840_t ksads_1_843_t ksads_1_846_t ksads_4_849_t ksads_4_851_t ksads_14_853_t ksads_5_857_t ksads_6_859_t ksads_7_861_t ksads_8_863_t ksads_25_865_t ksads_9_867_t ksads_10_869_t ksads_20_871_t ksads_20_872_t ksads_20_873_t ksads_20_874_t ksads_20_875_t ksads_20_876_t ksads_20_877_t ksads_20_878_t ksads_20_879_t ksads_20_889_t ksads_19_891_t ksads_20_893_t ksads_19_895_t ksads_16_897_t ksads_16_898_t ksads_15_901_t ksads_17_904_t ksads_5_906_t ksads_6_908_t ksads_7_909_t ksads_8_911_t ksads_10_913_t ksads_25_915_t ksads_11_917_t ksads_11_919_t ksads_21_921_t ksads_21_923_t ksads_12_925_t ksads_12_927_t ksads_13_929_t ksads_13_932_t ksads_13_935_t ksads_13_938_t ksads_13_941_t ksads_23_945_t ksads_23_946_t ksads_23_947_t ksads_23_948_t ksads_23_949_t ksads_23_950_t ksads_23_951_t ksads_23_952_t ksads_23_953_t ksads_23_954_t ksads_23_955_t ksads_24_967_t ksads_22_969_t"

foreach v of varlist $dsm5y_mentalh {
	replace `v'=. if `v'>1
}
   
global dsm5y_axdppy "ksads_1_840_t ksads_1_843_t ksads_1_846_t ksads_2_830_t ksads_2_831_t ksads_2_832_t ksads_2_835_t ksads_2_836_t ksads_2_838_t ksads_3_848_t ksads_4_826_t ksads_4_828_t ksads_4_849_t ksads_4_851_t ksads_5_857_t ksads_5_906_t ksads_6_859_t ksads_6_908_t ksads_7_861_t ksads_7_909_t ksads_8_863_t ksads_8_911_t ksads_13_942_t ksads_9_867_t ksads_10_869_t ksads_10_913_t ksads_11_917_t ksads_11_919_t ksads_12_925_t ksads_12_927_t ksads_13_929_t ksads_13_930_t ksads_13_932_t ksads_13_935_t ksads_13_938_t ksads_13_941_t ksads_13_942_t ksads_17_904_t ksads_21_921_t ksads_21_923_t ksads_25_865_t ksads_25_915_t"
global dsm5y_devdis "ksads_14_853_t ksads_18_903_t"
global dsm5y_condis "ksads_15_901_t ksads_16_897_t ksads_16_898_t "
global dsm5y_subdis "ksads_19_891_t ksads_19_895_t ksads_20_871_t ksads_20_872_t ksads_20_873_t ksads_20_874_t ksads_20_875_t ksads_20_876_t ksads_20_877_t ksads_20_878_t ksads_20_879_t ksads_20_889_t ksads_20_893_t"
global dsm5y_suibeh "ksads_23_945_t ksads_23_946_t ksads_23_947_t ksads_23_948_t ksads_23_949_t ksads_23_950_t ksads_23_951_t ksads_23_952_t ksads_23_953_t ksads_23_954_t ksads_23_955_t ksads_24_967_t"

*sum $dsm5y_mentalh if eventname=="baseline_year_1_arm_1"
*sum $dsm5y_mentalh if eventname=="1_year_follow_up_y_arm_1"
global dsm5y_MDD "ksads_1_1_t ksads_1_3_t ksads_1_5_t ksads_22_141_t ksads_23_143_t ksads_23_145_t ksads_23_147_t ksads_23_149_t ksads_1_157_t ksads_1_159_t ksads_1_161_t ksads_1_163_t ksads_1_165_t ksads_1_167_t ksads_1_169_t ksads_1_171_t ksads_1_173_t ksads_1_175_t ksads_1_177_t ksads_1_179_t ksads_1_181_t ksads_1_183_t dpry_eating dpry_sleep dpry_motor dpry_energy drpy_worth drpy_decis drpy_suic ksads_1_2_t ksads_1_4_t ksads_1_6_t ksads_22_142_t ksads_23_144_t ksads_23_146_t ksads_23_148_t ksads_23_150_t ksads_1_158_t ksads_1_160_t ksads_1_162_t ksads_1_164_t ksads_1_166_t ksads_1_168_t ksads_1_170_t ksads_1_172_t ksads_1_174_t ksads_1_176_t ksads_1_178_t ksads_1_180_t ksads_1_182_t ksads_1_184_t dpry_eatingP dpry_sleepP dpry_motorP dpry_energyP drpy_worthP drpy_decisP drpy_suicP"

rename dpr_eating dpry_eating 
rename dpr_sleep dpry_sleep 
rename dpr_motor dpry_motor 
rename dpr_energy dpry_energy 
rename drp_worth drpy_worth 
rename drp_decis drpy_decis 
rename drp_suic drpy_suic

rename dpr_eatingP dpry_eatingP
rename dpr_sleepP dpry_sleepP
rename dpr_motorP dpry_motorP
rename dpr_energyP dpry_energyP
rename drp_worthP drpy_worthP
rename drp_decisP drpy_decisP
rename drp_suicP drpy_suicP

			
keep 	subjectkey src_subject_id eventname										///
		$dsm5y_axdppy $dsm5y_devdis $dsm5y_condis $dsm5y_subdis $dsm5y_suibeh	///
		ksads_22_969_t Dsm5y_mdd Dsm5y_dys Dsm5y_manic Dsm5y_anxpb Dsm5y_suicb	///
		Dsm5y_mddp Dsm5y_dysp Dsm5y_manicp Dsm5y_anxpbp Dsm5y_suicbp			///
		dsm5y_mdd dsm5y_dys dsm5y_manic dsm5y_anxpb dsm5y_suicb					///
		dsm5y_mddp dsm5y_dysp dsm5y_manicp dsm5y_anxpbp dsm5y_suicbp 			///
		dpry_eating dpry_sleep dpry_motor dpry_energy drpy_worth drpy_decis 	///
		drpy_suic mddy_first mddy_second mddy_diagn dsm5y_mddvm $dsm5y_MDD		///
		dsm5y_mddvmP Dsm5y_mddP dsm5y_suicbP Dsm5y_suicbP

		
tempfile dsm5dgnsy
save `dsm5dgnsy'


**************************************************************************************
*************************************** 27 *******************************************
**************************************************************************************
**** Loading data on Prodromal Psychosis Scale
clear
import delimited "$data\pps01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1


** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day

rename visit eventname 

keep 	subjectkey src_subject_id eventname											///
		prodromal_1_y prodromal_2_y prodromal_3_y prodromal_4_y prodromal_5_y 		///
		prodromal_6_y prodromal_7_y prodromal_8_y prodromal_9_y prodromal_10_y 		///
		prodromal_11_y prodromal_12_y prodromal_13_y prodromal_14_y prodromal_15_y 	///
		prodromal_16_y prodromal_17_y prodromal_18_y prodromal_19_y prodromal_20_y 	///
		prodromal_21_y
		
tempfile prodromalp
save `prodromalp'


**************************************************************************************
*************************************** 28 *******************************************
**************************************************************************************
**** Loading data on Youth NIH TB Summary Scores (Cognitive abilities)
clear
import delimited "$data\abcd_tbss01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1


** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day

* NIH Toolbox Picture Sequence Memory Test (Episodic Memory)
	sum nihtbx_picture_uncorrected if eventname=="baseline_year_1_arm_1"
	gen seq_memory 	= (nihtbx_picture_uncorrected - r(mean))/r(sd)

* NIH Toolbox Flanker Inhibitory Control and Attention Test (Arrows or fishes pointing left or right)
	sum nihtbx_flanker_uncorrected if eventname=="baseline_year_1_arm_1"
	gen flanker 	= (nihtbx_flanker_uncorrected - r(mean))/r(sd)

* NIH Toolbox Pattern Comparison Processing Speed Test (Do the pictures look the same?)	
	sum nihtbx_pattern_uncorrected if eventname=="baseline_year_1_arm_1"
	gen procspeed 	= (nihtbx_pattern_uncorrected - r(mean))/r(sd)

* NIH Toolbox Picture Vocabulary Test (Matching the picture with the word)
	sum nihtbx_picvocab_uncorrected if eventname=="baseline_year_1_arm_1"
	gen vocabulary 	= (nihtbx_picvocab_uncorrected - r(mean))/r(sd)	

* NIH Toolbox Oral Reading Recognition Test (Reading the words on the screen)
	sum nihtbx_reading_uncorrected if eventname=="baseline_year_1_arm_1"
	gen reading 	= (nihtbx_reading_uncorrected - r(mean))/r(sd)	

* NIH Toolbox Crystallized Composite Fully-Corrected T-score
	sum nihtbx_cryst_fc if eventname=="baseline_year_1_arm_1"
	gen crystal_i 	= (nihtbx_cryst_fc - r(mean))/r(sd)		
	
keep 	subjectkey src_subject_id eventname										///
		seq_memory flanker procspeed vocabulary reading	crystal_i				///
		nihtbx_cryst_fc nihtbx_fluidcomp_fc nihtbx_totalcomp_fc
		
tempfile cogn_ab
save `cogn_ab'


**************************************************************************************
*************************************** 29 *******************************************
**************************************************************************************
**** Loading data on Latent variables 
clear
import delimited "$data\abcd_sss01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1


** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname											///
		latent_factor_ss_general_ses latent_factor_ss_social 						///
		latent_factor_ss_perinatal
		
tempfile latent
save `latent'


**************************************************************************************
*************************************** 30 *******************************************
**************************************************************************************
**** Loading data on neighborhood safety (Youth)
clear
import delimited "$data\abcd_nsc01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1


** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname										///
		neighborhood_crime_y
		
tempfile ncrimey
save `ncrimey'


**************************************************************************************
*************************************** 31 *******************************************
**************************************************************************************
**** Loading data on Medical History Questionnaire (MHX)

clear
import delimited "$data\abcd_mx01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1


** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname											///
		medhx_2a medhx_2b medhx_2c medhx_2d medhx_2e medhx_2f medhx_2g medhx_2h 	///
		medhx_2i medhx_2j medhx_2k medhx_2l medhx_2m medhx_2n medhx_2o medhx_2p 	///
		medhx_2q medhx_2r medhx_2s
		
tempfile phillbl
save `phillbl'


**************************************************************************************
*************************************** 32 *******************************************
**************************************************************************************
**** Loading data on Longitudinal Medical History Questionnaire
clear
import delimited "$data\abcd_lpmh01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1


** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname											///
		medhx_2a_l medhx_2b_l medhx_2c_l medhx_2d_l medhx_2e_l medhx_2f_l 			///
		medhx_2g_l medhx_2h_l medhx_2i_l medhx_2j_l medhx_2k_l medhx_2l_l 			///
		medhx_2m_l medhx_2n_l medhx_2o_l medhx_2p_l medhx_2q_l medhx_2r_l 			///
		medhx_2_notes2_l
		
tempfile phillfu
save `phillfu'


**************************************************************************************
*************************************** 33 *******************************************
**************************************************************************************
**** Loading data on Adult Behavior Checklist
clear
import delimited "$data\abcd_adbc01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1


** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day

*Adaptive functioning scales - 		Friends, personal strengths
*Syndrome scales - 					Anxious/Depressed, Withdrawn, Somatic Complaints -> Internalizing Behavior
*+									Thought Problems, Attention Problems
*+									Aggressive Behavior, Rule-Breaking Behavior, Intrusive -> Externalizing Behavior
*DSM oriented scales - 				Depressive problems, anxiety problems, somatic problems
*+									Avoidant personality ADHD, antisocial personality
*2014 scales - 						Sluggish Cognitive Tempo, Obsessive-Compulsive

global friend_ab 		"abcl_num_friends_p abcl_contact_p abcl_get_along_p abcl_visited_p"
global pstren_ab 		"abcl_q02_p abcl_q04_p abcl_q15_p abcl_q49_p abcl_q73_p abcl_q88_p abcl_q98_p abcl_q106_p abcl_q109_p abcl_q110_p abcl_q123_p"
global anxdep_ab 		"abcl_q12_p abcl_q14_p abcl_q31_p abcl_q33_p abcl_q34_p abcl_q35_p abcl_q45_p abcl_q47_p abcl_q50_p abcl_q52_p abcl_q71_p abcl_q103_p abcl_q107_p abcl_q112_p"
global withdr_ab 		"abcl_q25_p abcl_q30_p abcl_q42_p abcl_q48_p abcl_q60_p abcl_q65_p abcl_q67_p abcl_q69_p abcl_q111_p"
global somati_ab 		"abcl_q51_p abcl_q54_p abcl_q56a_p abcl_q56b_p abcl_q56c_p abcl_q56d_p abcl_q56e_p abcl_q56f_p abcl_q56g_p"
global intern_ab 		$anxdep_ab $withdr_ab $somati_ab
global though_ab		"abcl_q09_p abcl_q18_p abcl_q40_p abcl_q66_p abcl_q70_p abcl_q80_p abcl_q84_p abcl_q85_p abcl_q91_p"
global attent_ab		"abcl_q01_p abcl_q08_p abcl_q11_p abcl_q13_p abcl_q17_p abcl_q53_p abcl_q59_p abcl_q61_p abcl_q64_p abcl_q78_p abcl_q96_p abcl_q101_p abcl_q102_p abcl_q105_p abcl_q108_p abcl_q119_p abcl_q121_p"
global toprob_ab 		$though_ab $attent_ab
global aggres_ab		"abcl_q03_p abcl_q05_p abcl_q16_p abcl_q28_p abcl_q37_p abcl_q55_p abcl_q57_p abcl_q68_p abcl_q81_p abcl_q86_p abcl_q87_p abcl_q95_p abcl_q97_p abcl_q113_p abcl_q116_p abcl_q118_p"
global rulebr_ab		"abcl_q06_p abcl_q23_p abcl_q26_p abcl_q39_p abcl_q41_p abcl_q43_p abcl_q76_p abcl_q82_p abcl_q90_p abcl_q92_p abcl_q114_p abcl_q117_p abcl_q122_p"
global intrus_ab		"abcl_q07_p abcl_q19_p abcl_q74_p abcl_q93_p abcl_q94_p abcl_q104_p"
global extern_ab		$aggres_ab $rulebr_ab $intrus_ab
global dsmdep_ab 		"abcl_q14_p abcl_q18_p abcl_q24_p abcl_q35_p abcl_q52_p abcl_q54_p abcl_q60_p abcl_q77_p abcl_q78_p abcl_q91_p abcl_q96_p abcl_q100_p abcl_q102_p abcl_q103_p abcl_q107_p"
global dsmanx_ab 		"abcl_q22_p abcl_q29_p abcl_q45_p abcl_q50_p abcl_q72_p abcl_q112_p"
global dsmsom_ab 		"abcl_q56a_p abcl_q56b_p abcl_q56c_p abcl_q56d_p abcl_q56e_p abcl_q56f_p abcl_q56g_p"
global dsmavo_ab 		"abcl_q25_p abcl_q42_p abcl_q47_p abcl_q67_p abcl_q71_p abcl_q75_p abcl_q111_p"
global dsmadh_ab 		"abcl_q01_p abcl_q08_p abcl_q10_p abcl_q36_p abcl_q41_p abcl_q59_p abcl_q61_p abcl_q89_p abcl_q105_p abcl_q108_p abcl_q115_p abcl_q118_p abcl_q119_p"
global dsmant_ab 		"abcl_q03_p abcl_q05_p abcl_q16_p abcl_q21_p abcl_q23_p abcl_q26_p abcl_q28_p abcl_q37_p abcl_q39_p abcl_q43_p abcl_q57_p abcl_q76_p abcl_q82_p abcl_q92_p abcl_q95_p abcl_q97_p abcl_q101_p abcl_q114_p abcl_q120_p abcl_q122_p"
global sluggi_ab 		"abcl_q13_p abcl_q17_p abcl_q54_p abcl_q83_p abcl_q102_p"
global obscom_ab 		"abcl_q09_p abcl_q31_p abcl_q32_p abcl_q52_p abcl_q66_p abcl_q84_p abcl_q85_p abcl_q112_p"

****************
** ABCL Raw Score: Summing across all responses
egen abcl_friend = rowtotal($friend_ab), miss
egen abcl_pstren = rowtotal($pstren_ab), miss
egen abcl_anxdep = rowtotal($anxdep_ab), miss
egen abcl_withdr = rowtotal($withdr_ab), miss
egen abcl_somati = rowtotal($somati_ab), miss
egen abcl_intern = rowtotal($intern_ab), miss
egen abcl_though = rowtotal($though_ab), miss
egen abcl_attent = rowtotal($attent_ab), miss
egen abcl_toprob = rowtotal($toprob_ab), miss
egen abcl_aggres = rowtotal($aggres_ab), miss
egen abcl_rulebr = rowtotal($rulebr_ab), miss
egen abcl_intrus = rowtotal($intrus_ab), miss
egen abcl_extern = rowtotal($extern_ab), miss
egen abcl_dsmdep = rowtotal($dsmdep_ab), miss
egen abcl_dsmanx = rowtotal($dsmanx_ab), miss
egen abcl_dsmsom = rowtotal($dsmsom_ab), miss
egen abcl_dsmavo = rowtotal($dsmavo_ab), miss
egen abcl_dsmadh = rowtotal($dsmadh_ab), miss
egen abcl_dsmant = rowtotal($dsmant_ab), miss
egen abcl_sluggi = rowtotal($sluggi_ab), miss
egen abcl_obscom = rowtotal($obscom_ab), miss


keep 	subjectkey src_subject_id eventname											///
		abcl_friend abcl_pstren abcl_anxdep abcl_withdr abcl_somati abcl_intern 	///
		abcl_though abcl_attent abcl_toprob abcl_aggres abcl_rulebr abcl_intrus 	///
		abcl_extern abcl_dsmdep abcl_dsmanx abcl_dsmsom abcl_dsmavo abcl_dsmadh 	///
		abcl_dsmant abcl_sluggi abcl_obscom
		
tempfile adcl
save `adcl'


**************************************************************************************
*************************************** 34 *******************************************
**************************************************************************************
**** Loading data on School Risk and Protective Factors Survey
clear
import delimited "$data\srpf01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1


** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day

egen school_positive = rowmean(school_2_y school_3_y school_4_y school_5_y school_6_y school_7_y)
egen st_engaged = rowmean(school_12_y school_15_y school_17_y)

rename visit eventname 

label var school_positive 	"school_2_y to school_7_y"
label var st_engaged 		"school_12_y to school_17_y"

keep 	subjectkey src_subject_id eventname										///
		school_positive st_engaged school_2_y-school_17_y
		
tempfile school_rk
save `school_rk'


**************************************************************************************
*************************************** 35 *******************************************
**************************************************************************************
**** Loading data on Parental Monitoring Survey
clear
import delimited "$data\pmq01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1


** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


egen p_monitor = rowmean(parent_monitor_q1_y parent_monitor_q2_y parent_monitor_q3_y parent_monitor_q4_y parent_monitor_q5_y)

keep 	subjectkey src_subject_id eventname										///
		p_monitor
	
tempfile parent_mon
save `parent_mon'


**************************************************************************************
*************************************** 36 *******************************************
**************************************************************************************
**** Loading data on Parent Diagnostic Interview for DSM-5 (KSADS) Traumatic Events
clear
import delimited "$data\abcd_ptsd01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1


** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day

keep 	subjectkey src_subject_id eventname											///
		ksads_ptsd_raw_754_p ksads_ptsd_raw_755_p ksads_ptsd_raw_756_p 				///
		ksads_ptsd_raw_757_p ksads_ptsd_raw_758_p ksads_ptsd_raw_759_p 				///
		ksads_ptsd_raw_760_p ksads_ptsd_raw_761_p ksads_ptsd_raw_762_p 				///
		ksads_ptsd_raw_763_p ksads_ptsd_raw_764_p ksads_ptsd_raw_765_p 				///
		ksads_ptsd_raw_766_p ksads_ptsd_raw_767_p ksads_ptsd_raw_768_p 				///
		ksads_ptsd_raw_769_p ksads_ptsd_raw_770_p
	
tempfile ptsd_x
save `ptsd_x'


**************************************************************************************
*************************************** 37 *******************************************
**************************************************************************************
**** Loading data on Parent Family History Summary Scores
clear
import delimited "$data\abcd_fhxssp01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1


** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname											///
		famhx_ss_fath_prob_alc_p famhx_ss_moth_prob_alc_p famhx_ss_parent_alc_p 	///
		famhx_ss_fath_prob_dg_p famhx_ss_moth_prob_dg_p famhx_ss_parent_dg_p 		///
		famhx_ss_fath_prob_dprs_p famhx_ss_patgf_prob_dprs_p 						///
		famhx_ss_patgm_prob_dprs_p famhx_ss_moth_prob_dprs_p 						///
		famhx_ss_matgf_prob_dprs_p famhx_ss_matgm_prob_dprs_p 						///
		famhx_ss_momdad_dprs_p famhx_ss_parent_dprs_p famhx_ss_fath_prob_ma_p 		///
		famhx_ss_moth_prob_ma_p famhx_ss_parent_ma_p 								///
		famhx_ss_fath_prob_vs_p famhx_ss_moth_prob_vs_p famhx_ss_parent_vs_p 		///
		famhx_ss_fath_prob_trb_p famhx_ss_patgf_prob_trb_p 							///
		famhx_ss_patgm_prob_trb_p famhx_ss_moth_prob_trb_p 							///
		famhx_ss_matgf_prob_trb_p famhx_ss_matgm_prob_trb_p 						///
		famhx_ss_momdad_trb_p famhx_ss_parent_trb_p									///
		famhx_ss_fath_prob_nrv_p famhx_ss_moth_prob_nrv_p famhx_ss_parent_nrv_p 	///
		famhx_ss_fath_prob_prf_p famhx_ss_moth_prob_prf_p famhx_ss_parent_prf_p 	///
		famhx_ss_fath_prob_hspd_p famhx_ss_moth_prob_hspd_p famhx_ss_parent_hspd_p 	///
		famhx_ss_fath_prob_scd_p famhx_ss_moth_prob_scd_p famhx_ss_parent_scd_p		///
		famhx_ss_patgf_prob_ma_p famhx_ss_patgm_prob_ma_p famhx_ss_matgf_prob_ma_p 	///
		famhx_ss_matgm_prob_ma_p famhx_ss_patgf_prob_vs_p famhx_ss_patgm_prob_vs_p 	///
		famhx_ss_matgf_prob_vs_p famhx_ss_matgm_prob_vs_p 						 	///
		famhx_ss_momdad_ma_p famhx_ss_momdad_vs_p  									///
		famhx_ss_momdad_nrv_p famhx_ss_patgf_prob_nrv_p famhx_ss_patgm_prob_nrv_p 	///
		famhx_ss_matgf_prob_nrv_p famhx_ss_matgm_prob_nrv_p

tempfile family_hist
save `family_hist'


**************************************************************************************
*************************************** 38 *******************************************
**************************************************************************************
**** Loading data on Medications Survey Inventory Modified from PhenX (PMP)
clear
import delimited "$data\medsy01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1


** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day

* Loxapine: 	210242|1182290|943952|1170082   141868|219367|213110|6475 5049937	1367515 5049939	1367517 1506684	329943
* Olanzapine: 	6358152|6376625|6345626|6378526|6369646	754503
* Quetiapine: 	4257181|4258845|6363252|2404286|3740427	616483
* Asenapine: 	6837385 | 1606336
* Clotiapine: 	1225361|9270511|78931|1156514|10326746|1225362|4258941|1911459	207586|2058200|2620|207585|238031|1250452
* Clozapine: 	10324714|79097|3723592|1176921	1723989|216418|2626


keep 	subjectkey src_subject_id  eventname brought_medications					///
		med1_rxnorm_p med2_rxnorm_p med3_rxnorm_p med4_rxnorm_p med5_rxnorm_p 		///
		med6_rxnorm_p med7_rxnorm_p med8_rxnorm_p med9_rxnorm_p med10_rxnorm_p 		///
		med11_rxnorm_p med12_rxnorm_p med13_rxnorm_p med14_rxnorm_p med15_rxnorm_p  ///
		med_otc_1_rxnorm_p med_otc_2_rxnorm_p med_otc_3_rxnorm_p 					///
		med_otc_4_rxnorm_p med_otc_5_rxnorm_p med_otc_6_rxnorm_p 					///
		med_otc_7_rxnorm_p med_otc_8_rxnorm_p med_otc_9_rxnorm_p 					///
		med_otc_10_rxnorm_p med_otc_11_rxnorm_p med_otc_12_rxnorm_p 				///
		med_otc_13_rxnorm_p med_otc_14_rxnorm_p med_otc_15_rxnorm_p 				///		
		caff_24 caff_ago
	
tempfile medication
save `medication'


**************************************************************************************
*************************************** 39 *******************************************
**************************************************************************************
**** Loading data on Parent Sleep Disturbance Scale for Children (SDS)
clear
import delimited "$data\abcd_sds01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

drop abcd_sds01_id dataset_id
duplicates drop 

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day

egen sleepdisturb = rowmean(sleepdisturb1_p-sleepdisturb26_p)

keep 	subjectkey src_subject_id eventname 									///
		sleepdisturb1_p-sleepdisturb26_p sleepdisturb
	
tempfile sleepdis
save `sleepdis'



**************************************************************************************
*************************************** 40 *******************************************
**************************************************************************************
**** Loading data on Early Adolescent Temperament Questionnaire
clear
import delimited "$data\abcd_eatqp01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname 									///
		eatq_trouble_p-eatq_shy_meet_p
	
tempfile temperam
save `temperam'

**************************************************************************************
*************************************** 41 *******************************************
**************************************************************************************
**** Loading data on Summary Scores Substance Use
clear
import delimited "$data\abcd_suss01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day

keep 	subjectkey src_subject_id eventname 								///
		su_caff_ss_sum-res_tobacco_total_ecig_i
	
tempfile subsuse
save `subsuse'


**************************************************************************************
*************************************** 42 *******************************************
**************************************************************************************
**** Loading data on Youth Substance Use Interview, Baseline
clear
import delimited "$data\abcd_ysu02.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname 									///
		tlfb_alc tlfb_tob tlfb_mj tlfb_mj_synth tlfb_bitta tlfb_caff 			///
		tlfb_inhalant tlfb_rx_misuse tlfb_list_yes_no tlfb_alc_sip 				///
		tlfb_alc_use tlfb_tob_puff tlfb_cig_use su_tlfb_alc_lt_calc				///
		su_tlfb_cig_lt_calc
	
tempfile subsuse_bl
save `subsuse_bl'


**************************************************************************************
*************************************** 43 *******************************************
**************************************************************************************
**** Loading data on Youth Substance Use Interview, Baseline
clear
import delimited "$data\abcd_ysuip01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname 										///
		tlfb_alc_l tlfb_tob_l tlfb_mj_l tlfb_mj_synth_l tlfb_bitta_l tlfb_caff_l 	///
		tlfb_inhalant_l tlfb_rx_misuse_l tlfb_list_yes_no_l tlfb_alc_sip_l 			///
		tlfb_alc_use_l tlfb_tob_puff_l tlfb_cig_use_l 								///
		su_first_nicotine_1b_calc su_tlfb_alc_use_calc_l su_tlfb_alc_sip_calc_l		///
		tlfb_tob_puff_l 
	
tempfile subsuse_fu
save `subsuse_fu'



**************************************************************************************
*************************************** 44 *******************************************
**************************************************************************************
**** Loading data on Pearson scores - Rey Auditory Verbal Learning Test, Matrix Reasoning Test, and Rey Delayed Recall Test
clear
import delimited "$data\abcd_ps01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day

* Eight trial after second set of words and 30-minute pause
	gen ravlt_raw = pea_ravlt_ld_trial_vii_tc - pea_ravlt_ld_trial_vii_tr - pea_ravlt_ld_trial_vii_ti
	sum ravlt_raw if eventname=="baseline_year_1_arm_1"
	gen ravlt_sd = (ravlt_raw - r(mean))/r(sd)


keep 	subjectkey src_subject_id eventname 									///
		pea_assessment_status-pea_wiscv_tss ravlt_sd ravlt_raw
	
tempfile pearson_t
save `pearson_t'


**************************************************************************************
*************************************** 45 *******************************************
**************************************************************************************
**** Loading data on Behavioral performance measures for nBack task fMRI (working memory)
clear
import delimited "$data\abcd_mrinback02.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day

sum tfmri_nb_all_beh_ctotal_rate if eventname=="baseline_year_1_arm_1"
	gen nback_rate = (tfmri_nb_all_beh_ctotal_rate - r(mean))/r(sd)
	
sum tfmri_nb_all_beh_ctotal_mrt if eventname=="baseline_year_1_arm_1"
	gen nback_speed = (tfmri_nb_all_beh_ctotal_mrt - r(mean))/r(sd)
	
sum tfmri_nb_all_beh_ctotal_stdrt if eventname=="baseline_year_1_arm_1"
	gen nback_acc = -1*((tfmri_nb_all_beh_ctotal_stdrt - r(mean))/r(sd))


keep 	subjectkey src_subject_id eventname 									///
		tfmri_nb_all_beh_ctotal_rate tfmri_nb_all_beh_ctotal_mrt 				///
		tfmri_nb_all_beh_ctotal_stdrt nback_rate nback_speed nback_acc			///
		tfmri_nb_all_beh_ctotal_nt
		
tempfile nback_perf
save `nback_perf'


**************************************************************************************
*************************************** 46 *******************************************
**************************************************************************************
**** Loading data on Parent Life Events
clear
import delimited "$data\abcd_ple01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day

keep 	subjectkey src_subject_id eventname 									///
		ple_died_p-ple_new_sib_fu2_p
		
tempfile p_levents
save `p_levents'


**************************************************************************************
*************************************** 47 *******************************************
**************************************************************************************
**** Loading data on Youth Life Events
clear
import delimited "$data\abcd_yle01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day

keep 	subjectkey src_subject_id eventname 									///
		ple_died_y-ple_new_sib_fu2_y 
		
tempfile y_levents
save `y_levents'



**************************************************************************************
*************************************** 48 *******************************************
**************************************************************************************
**** Loading data on Youth Peer Behavior Profile
clear
import delimited "$data\abcd_pbp01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname 									///
		pbp_athletes-pbp_shoplifted
		
tempfile peer_influence
save `peer_influence'


**************************************************************************************
*************************************** 49 *******************************************
**************************************************************************************
**** Loading data on Youth Peer Network Health Protective Scaler
clear
import delimited "$data\abcd_pnhps01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day

keep 	subjectkey src_subject_id eventname 									///
		pnh_substance-pnh_art_involve
		
tempfile peerh_influence
save `peerh_influence'

	

**************************************************************************************
*************************************** 50 *******************************************
**************************************************************************************
**** Loading data on Youth Summary Scores BPM and POA
clear
import delimited "$data\abcd_yssbpm01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname 									///
		bpm_y_scr_attention_r-poa_y_ss_sum_nt
		
tempfile briefh_poa
save `briefh_poa'


**************************************************************************************
*************************************** 51 *******************************************
**************************************************************************************
**** Loading data on Parent Diagnostic Interview for DSM-5 Background Items Full (KSAD) - follow-up
clear
import delimited "$data\abcd_lpksad01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day

keep 	subjectkey src_subject_id eventname 											///
		kbi_p_how_well_c_school_l kbi_p_grades_in_school_l kbi_p_c_drop_in_grades_l 	///
		kbi_p_c_spec_serv_l___1 kbi_p_c_spec_serv_l___2 kbi_p_c_spec_serv_l___3 		///
		kbi_p_c_spec_serv_l___4 kbi_p_c_spec_serv_l___5 kbi_p_c_spec_serv_l___6 		///
		kbi_p_c_spec_serv_l___7 kbi_p_c_spec_serv_l___8 kbi_p_c_spec_serv_l___9 		///
		kbi_p_c_spec_serv_l___10 kbi_p_c_det_susp_l kbi_p_c_best_friend_l 				///
		kbi_p_c_best_friend_len_l kbi_p_c_reg_friend_group_l 							///
		kbi_p_c_reg_friend_group_len_l kbipcregfriend_groupopin_l kbi_p_c_bully_l 		///
		kbi_p_c_gay_l kbi_p_c_gay_problems_l kbi_p_c_trans_l kbi_p_c_trans_problems_l 	///
		kbi_p_c_mh_sa_l kbi_p_c_age_services_l kbipcserviceschecklistl1 				///
		kbipcserviceschecklistl2 kbipcserviceschecklistl3 kbipcserviceschecklistl4 		///
		kbipcserviceschecklistl5 kbipcserviceschecklistl6 kbipcserviceschecklistl7 		///
		kbipcserviceschecklistl8 kbipcserviceschecklistl9 kbipcserviceschecklistl10 	///
		kbi_p_c_mental_health_l kbi_ss_c_mental_health_p_l kbi_p_c_spec_serv_l___777 	
		
tempfile ksadb_fup
save `ksadb_fup'


**************************************************************************************
*************************************** 52 *******************************************
**************************************************************************************
**** Loading data on Social Development Parent Difficulties in Emotion Regulation
clear
import delimited "$data3p0\abcd_socdev_p_emr01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname 										///
		socialdev_pders_01-socialdev_pders_36	
		
tempfile emotion_regp
save `emotion_regp'


**************************************************************************************
*************************************** 53 *******************************************
**************************************************************************************
**** Loading data on Social Development Child Difficulties in Emotion Regulation
clear
import delimited "$data3p0\abcd_socdev_child_emr01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname 										///
		socialdev_cders_01-socialdev_cders_36	
		
tempfile emotion_regy
save `emotion_regy'	


**************************************************************************************
*************************************** 54 *******************************************
**************************************************************************************
**** Loading data on Youth Emotional Stroop Task
clear
import delimited "$data\abcd_yest01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname 										///
		strp_scr_script_startdate-strp_scr_incangf75con_rt	
		
tempfile emotion_stroop
save `emotion_stroop'	

/*54. abcd_yest01:			Youth Emotional Stroop Task
Emotional Stroop Task - The emotional Stroop task (Stroop, 1935) measures cognitive control 
under conditions of emotional salience (see Başgöze et al., 2015; Banich et al., 2019). 
The task-relevant dimension is an emotional word, which participants categorize as either a 
"good" feeling (happy, joyful) or a "bad" feeling (angry, upset). 
The task-irrelevant dimension is an image, which is of a teenager’s face with either a happy or 
an angry facial expression.  Trials are of two types. On congruent trials, the word and facial 
emotion are of the same valence (e.g. a happy face paired with word "joyful"). 
The location of the word varies from trial-to-trial, presented either on the top of the image 
or at the bottom. On incongruent trials, the word and facial expression are of different 
valence (e.g., a happy face paired with word "angry").  Participants work through 2 test blocks: 
one block consists of 50% congruent and 50% incongruent trials; the other consists of 25% incongruent 
trials and 75% congruent trials. The composition of the former type of block helps individuals 
keep the task set in mind more so than the latter (Kane & Engle, 2003). The 25% incongruent/75% 
congruent block is always administered first, followed by the 50% incongruent/50% congruent block. 
Accuracy and response times for congruent versus incongruent trials for the total task and 
within each emotion subtype (happy/joyful; angry/upset) are calculated. Relative difficulties 
with cognitive control are indexed by lower accuracy rates and longer reaction times for 
incongruent relative to congruent trials. */


**************************************************************************************
*************************************** 55 *******************************************
**************************************************************************************
**** Loading data on Emotional Stroop Task Trial Level Behavior
clear
import delimited "$data\abcd_esttlb01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname 										///
		taskname-data_file10_type
		
tempfile emotionst_task
save `emotionst_task'


**************************************************************************************
*************************************** 56 *******************************************
**************************************************************************************
**** Loading data on Parent PhenX Community Cohesion
clear
import delimited "$data\abcd_pxccp01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname 										///
		comc_phenx_close_knit_p-comc_phenx_budget_p	
		
tempfile neigh_cohesion
save `neigh_cohesion'


**************************************************************************************
*************************************** 57 *******************************************
**************************************************************************************
**** Loading data on Other Resilience (Close friends)
clear
import delimited "$data\abcd_ysr01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname 										///
		resiliency5a_y-resiliency6b_y	
		
tempfile close_friendsr
save `close_friendsr'				

**************************************************************************************
*************************************** 58 *******************************************
**************************************************************************************
**** Loading data on Residential History Derived Scores
clear
import delimited "$data\abcd_rhds01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day

gen  ver_addw2 = 1 if reshist_addr1_status=="[OK: 2_year_follow_up_y_arm_1 : 2020-07-09]" | reshist_addr1_status=="[OK: 30_month_follow_up_arm_1 : 2020-07-09]"
egen ver_addw2a = max(ver_addw2), by(subjectkey)
gen  ver_addw3 = 1 if reshist_addr1_status=="[OK: 3_year_follow_up_y_arm_1 : 2020-07-09]" | reshist_addr1_status=="[OK: 42_month_follow_up_arm_1 : 2020-07-09]"
egen ver_addw3a = max(ver_addw3), by(subjectkey)

gen 	period = 1 if eventname=="baseline_year_1_arm_1"
replace period = 2 if eventname=="1_year_follow_up_y_arm_1"
replace period = 3 if eventname=="2_year_follow_up_y_arm_1"
replace period = 4 if eventname=="3_year_follow_up_y_arm_1"

sort subjectkey period

foreach v of varlist reshist_addr1_adi_pov reshist_addr1_adi_b138 reshist_addr1_adi_sp reshist_addr1_adi_in_dis reshist_addr1_adi_home_v reshist_addr1_adi_rent reshist_addr1_adi_wsum reshist_addr1_adi_perc{
	replace `v' = `v'[_n-1] if ver_addw2a==1 & eventname=="1_year_follow_up_y_arm_1" & `v'[_n+1]==`v'[_n-1] & `v'[_n]==.
	replace `v' = `v'[_n-1] if ver_addw2a==1 & eventname=="1_year_follow_up_y_arm_1" & `v'[_n+1]==`v'[_n-1] & `v'[_n]==.
	
	replace `v' = `v'[_n-1] if ver_addw3a==1 & eventname=="1_year_follow_up_y_arm_1" & `v'[_n+2]==`v'[_n-1] & `v'[_n]==.
	replace `v' = `v'[_n-1] if ver_addw3a==1 & eventname=="2_year_follow_up_y_arm_1" & `v'[_n+1]==`v'[_n-1] & `v'[_n]==.
}

keep 	subjectkey src_subject_id eventname 										///
		reshist_addr1_adi_pov reshist_addr1_adi_b138 reshist_addr1_adi_sp 			///
		reshist_addr1_adi_in_dis reshist_addr1_adi_home_v reshist_addr1_adi_rent 	///
		reshist_addr1_adi_wsum reshist_addr1_adi_perc
		
tempfile residential_h
save `residential_h'		
	

**************************************************************************************
*************************************** 59 *******************************************
**************************************************************************************
**** Loading data on Social Development Parent Neighborhood
clear
import delimited "$data\abcd_socdev_p_nbh01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

replace eventname="1_year_follow_up_y_arm_1" if eventname=="sd_wave1_arm_3"

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


keep 	subjectkey src_subject_id eventname 										///
		socialdev_pneigh_01-socialdev_pneigh_25
		
tempfile neighb1_cohesion
save `neighb1_cohesion'
	

**************************************************************************************
*************************************** 60 *******************************************
**************************************************************************************
**** Loading data on Youth Pubertal Development Scale and Menstrual Cycle Survey History (PDMS)
clear
import delimited "$data\abcd_ypdms01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1

** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day
gen uno = 1
bysort subjectkey: gen wave = sum(uno) 
drop uno

foreach v of varlist pds_ht2_y pds_skin2_y pds_bdyhair_y pds_f4_2_y pds_f5_y pds_ht2_y pds_skin2_y pds_bdyhair_y pds_m4_y pds_m5_y{
    replace `v'=. if `v'==777 | `v'==999 
}

egen pubertyf_v = rowmean(pds_ht2_y pds_skin2_y pds_bdyhair_y pds_f4_2_y pds_f5_y) if sex=="F"
egen pubertym_v = rowmean(pds_ht2_y pds_skin2_y pds_bdyhair_y pds_m4_y pds_m5_y) if sex=="M"

gen 	puberty_v = pubertyf_v if sex=="F"
replace puberty_v = pubertym_v if sex=="M"

keep 	subjectkey src_subject_id wave eventname 										///
		pds_sex_y-menstrualcycle6_y pubertyf_v pubertym_v puberty_v
		
tempfile puberty
save `puberty'	

	
**************************************************************************************
**************************************** 61 ******************************************
**************************************************************************************
** ASR profile

**** Loading the database
clear
import delimited "$data\pasr01.txt", varnames(1) encoding(Big5) 

** Labeling variables
foreach var of varlist * {
  label variable `var' "`=`var'[1]'"
  replace `var'="" if _n==1
  destring `var', replace
}

drop in 1


** Interview Date
gen interview_day = substr(interview_date, 4,2)
gen interview_month = substr(interview_date, 1,2)
gen interview_year = substr(interview_date, 7,4)

destring interview_day interview_month interview_year, replace 

** Identifying periods on the Panel data
sort subjectkey interview_year interview_month interview_day


*******************
*Syndrome scales - 	Anxious/Depressed, Withdrawn/Depressed, Somatic Complaints -> Internalizing Behavior
*+					Social problems, Thought Problems, Attention Problems
*+					Rul-Breaking Behavior, Aggressive Behavior -> Externalizing Behavior


global anxdepress2 		"asr_q12_p asr_q13_p asr_q14_p asr_q22_p asr_q31_p asr_q33_p asr_q34_p asr_q35_p asr_q45_p asr_q47_p asr_q50_p asr_q52_p asr_q71_p asr_q91_p asr_q103_p asr_q107_p asr_q112_p asr_q113_p"
global withdranx 		"asr_q25_p asr_q30_p asr_q42_p asr_q48_p asr_q60_p asr_q65_p asr_q67_p asr_q69_p asr_q111_p"
global somatic1 		"asr_q51_p asr_q54_p asr_q56a_p asr_q56b_p asr_q56c_p asr_q56d_p asr_q56e_p asr_q56f_p asr_q56g_p asr_q56h_p asr_q56i_p asr_q100_p"
global internalizing 	$anxdepress2 $withdranx $somatic1
global thoughtprob		"asr_q09_p asr_q18_p asr_q36_p asr_q40_p asr_q46_p asr_q63_p asr_q66_p asr_q70_p asr_q84_p asr_q85_p"
global attentionprob	"asr_q01_p asr_q08_p asr_q11_p asr_q17_p asr_q53_p asr_q59_p asr_q61_p asr_q64_p asr_q78_p asr_q101_p asr_q102_p asr_q105_p asr_q108_p asr_q119_p asr_q121_p"
global aggressive		"asr_q03_p asr_q05_p asr_q16_p asr_q28_p asr_q37_p asr_q55_p asr_q57_p asr_q68_p asr_q81_p asr_q86_p asr_q87_p asr_q95_p asr_q97_p asr_q116_p asr_q118_p"
global rulebreaker		"asr_q06_p asr_q20_p asr_q23_p asr_q26_p asr_q39_p asr_q41_p asr_q43_p asr_q76_p asr_q82_p asr_q90_p asr_q92_p asr_q114_p asr_q117_p asr_q122_p"
global intrusive		"asr_q07_p asr_q19_p asr_q74_p asr_q93_p asr_q94_p asr_q104_p"
global externalizing	$rulebreaker $aggressive $intrusive

****************
** CBCL Score 1: Summing across all responses
egen asr_anxdep1 = rowtotal($anxdepress2)
egen asr_witanx1 = rowtotal($withdranx)
egen asr_somatc1 = rowtotal($somatic1)
egen asr_intern1 = rowtotal($internalizing)
egen asr_though1 = rowtotal($thoughtprob)
egen asr_attent1 = rowtotal($attentionprob)
egen asr_rulebr1 = rowtotal($rulebreaker)
egen asr_aggres1 = rowtotal($aggressive)
egen asr_extern1 = rowtotal($externalizing)
egen asr_intrsv1 = rowtotal($intrusive)

****************
** CBCL Score 2: Summing across dichotomized responses (Not true = 0; often or sometimes true = 1)
foreach v of varlist $anxdepress2 $withdranx $somatic1 $thoughtprob $attentionprob $rulebreaker $aggressive $intrusive {
	rename `v' `v'temp
	gen `v' = cond(`v'temp>=1,1,0)
}

egen asr_anxdep2 = rowtotal($anxdepress2)
egen asr_witanx2 = rowtotal($withdranx)
egen asr_somatc2 = rowtotal($somatic1)
egen asr_intern2 = rowtotal($internalizing)
egen asr_though2 = rowtotal($thoughtprob)
egen asr_attent2 = rowtotal($attentionprob)
egen asr_rulebr2 = rowtotal($rulebreaker)
egen asr_aggres2 = rowtotal($aggressive)
egen asr_extern2 = rowtotal($externalizing)
egen asr_intrsv2 = rowtotal($intrusive)

foreach v of varlist $anxdepress2 $withdranx $somatic1 $thoughtprob $attentionprob $rulebreaker $aggressive $intrusive {
	drop `v'
	rename `v'temp `v'
}

****************
** CBCL Score 3: Principal Component analysis
pca $anxdepress2
predict asr_anxdep3
pca $withdranx
predict asr_witanx3
pca $somatc1
predict asr_somatc3
pca $internalizing
predict asr_intern3
pca $thoughtprob
predict asr_though3
pca $attentionprob
predict asr_attent3
pca $rulebreaker
predict asr_rulebr3
pca $aggressive
predict asr_aggres3
pca $externalizing
predict asr_extern3
pca $intrusive
predict asr_intrsv3

****************
** DMS Score 4: Percentile of ASR Score 1

foreach v in asr_anxdep asr_witanx asr_somatc asr_intern asr_though asr_attent asr_rulebr asr_aggres asr_extern asr_intrsv {
	xtile 	`v'4a = `v'1 if eventname=="baseline_year_1_arm_1", nq(100) 
	xtile 	`v'4c = `v'1 if eventname=="2_year_follow_up_y_arm_1", nq(100) 
	gen 	`v'4 = `v'4a if eventname=="baseline_year_1_arm_1"
	replace	`v'4 = `v'4c if eventname=="2_year_follow_up_y_arm_1"
	drop `v'4a `v'4c
}

**************************************************************************************
**************************************************************************************
** DSM Oriented Scales - Depressive Problems, Anxiety Problems, Somatic Problems,
*+						Oppositional Defiant Problems, Conduct Problems

global depressive 		"asr_q14_p asr_q18_p asr_q24_p asr_q35_p asr_q52_p asr_q54_p asr_q60_p asr_q77_p asr_q78_p asr_q91_p asr_q100_p asr_q102_p asr_q103_p asr_q107_p"
global anxious 			"asr_q22_p asr_q29_p asr_q45_p asr_q50_p asr_q72_p asr_q112_p"
global somatic2 		"asr_q56a_p asr_q56b_p asr_q56c_p asr_q56d_p asr_q56e_p asr_q56f_p asr_q56g_p asr_q56h_p asr_q56i_p"
global avoidantpers 	"asr_q25_p asr_q42_p asr_q47_p asr_q67_p asr_q71_p asr_q75_p asr_q111_p"
global attentiondef 	"asr_q01_p asr_q08_p asr_q10_p asr_q36_p asr_q41_p asr_q59_p asr_q61_p asr_q89_p asr_q105_p asr_q108_p asr_q115_p asr_q118_p asr_q119_p"
global antisocpers		"asr_q03_p asr_q05_p asr_q16_p asr_q21_p asr_q23_p asr_q26_p asr_q28_p asr_q37_p asr_q39_p asr_q43_p asr_q57_p asr_q76_p asr_q82_p asr_q92_p asr_q95_p asr_q97_p asr_q101_p asr_q114_p asr_q120_p asr_q122_p"

alpha $depressive if eventname=="baseline_year_1_arm_1"
alpha $depressive if eventname=="2_year_follow_up_y_arm_1"

****************
** DMS Score 1: Summing across all responses
egen asr_dsm_depres1 = rowtotal($depressive)
egen asr_dsm_anxiou1 = rowtotal($anxious)
egen asr_dsm_somati1 = rowtotal($somatic2)
egen asr_dsm_avoidt1 = rowtotal($avoidantpers)
egen asr_dsm_attent1 = rowtotal($attentiondef)
egen asr_dsm_antiso1 = rowtotal($antisocpers)

****************
** DMS Score 2: Summing across dichotomized responses (Not true = 0; often or sometimes true = 1)
foreach v of varlist $depressive $anxious $somatic2 $avoidantpers $attentiondef $antisocpers {
	rename `v' `v'temp
	gen `v' = cond(`v'temp>=1,1,0)
}

egen asr_dsm_depres2 = rowtotal($depressive)
egen asr_dsm_anxiou2 = rowtotal($anxious)
egen asr_dsm_somati2 = rowtotal($somatic2)
egen asr_dsm_avoidt2 = rowtotal($avoidantpers)
egen asr_dsm_attent2 = rowtotal($attentiondef)
egen asr_dsm_antiso2 = rowtotal($antisocpers)

foreach v of varlist $depressive $anxious $somatic2 $avoidantpers $attentiondef $antisocpers {
	drop `v'
	rename `v'temp `v'
}

****************
** DMS Score 3: Principal Component analysis
pca $depressive 
predict asr_dsm_depres3
pca $anxious 
predict asr_dsm_anxiou3
pca $somatic2 
predict asr_dsm_somati3
pca $avoidantpers 
predict asr_dsm_avoidt3
pca $attentiondef 
predict asr_dsm_attent3
pca $antisocpers
predict asr_dsm_antiso3

****************
** DMS Score 4: Percentile of DMS Score 1 (Check do-file accountability paper - PSU)

foreach v in asr_dsm_depres asr_dsm_anxiou asr_dsm_somati asr_dsm_attent asr_dsm_avoidt asr_dsm_antiso {
	xtile 	`v'4a = `v'1 if eventname=="baseline_year_1_arm_1", nq(100) 
	xtile 	`v'4c = `v'1 if eventname=="2_year_follow_up_y_arm_1", nq(100) 
	gen 	`v'4 = `v'4a if eventname=="baseline_year_1_arm_1"
	replace	`v'4 = `v'4c if eventname=="2_year_follow_up_y_arm_1"
	drop `v'4a `v'4c
}

rename sex gender

keep subjectkey src_subject_id interview_date interview_age gender eventname		///
		$thoughtprob $attentionprob $rulebreaker $aggressive $intrusive 			///
		$depressive $anxious $somatic2 $avoidantpers $attentiondef $antisocpers		///
		asr_dsm_depres1 asr_dsm_anxiou1 asr_dsm_somati1 asr_dsm_attent1 asr_dsm_avoidt1 asr_dsm_antiso1		///
		asr_dsm_depres2 asr_dsm_anxiou2 asr_dsm_somati2 asr_dsm_attent2 asr_dsm_avoidt2 asr_dsm_antiso2		///
		asr_anxdep1 asr_witanx1 asr_somatc1 $anxdepress2 $withdranx $somatic1 		///
		$internalizing asr_anxdep2 asr_witanx2 asr_somatc2

		
tempfile pasri
save `pasri'
	
	
	
	
/** Delinquent behavior (available starting at one-year follow-up)
clear
import delimited "$data\abcd_y10ids01.txt", varnames(1) encoding(Big5) 

clear
import delimited "$data\abcd_socdev_p_rde01.txt", varnames(1) encoding(Big5) 

clear
import delimited "$data\abcd_socdev_child_rde01.txt", varnames(1) encoding(Big5) 

clear
import delimited "$data\abcd_bpm01.txt", varnames(1) encoding(Big5) 
**/


**************************************************************************************
**************************************************************************************
**************************************************************************************
**** Merging the databases

use `cbclsc', clear
merge 1:1 subjectkey src_subject_id eventname using `cbclsum'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `bullyy'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `bullyp'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `anthro'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `weight'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `discrimin'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `paccept'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `smri1'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `smri2'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `demog'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `mhsp'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `mhsy'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `asrs'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `fesy'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `autis'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `condd'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `posemo'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `ywill'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `prosocp'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `prosocy'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `phyactiv'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `sportact'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `dsm5dgnsp'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `dsm5dgnsy'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `prodromalp'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `cogn_ab'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `latent'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `ncrimey'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `phillbl'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `phillfu'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `adcl'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `school_rk'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `parent_mon'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `ptsd_x'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `family_hist'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `medication'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `sleepdis'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `temperam'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `subsuse'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `subsuse_bl'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `subsuse_fu'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `pearson_t'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `nback_perf'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `p_levents'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `y_levents'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `peer_influence'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `peerh_influence'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `briefh_poa'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `ksadb_fup'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `emotion_regp'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `emotion_regy'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `emotion_stroop'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `emotionst_task'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `neigh_cohesion'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `close_friendsr'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `residential_h'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `neighb1_cohesion'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `puberty'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `pasri'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `siteID'
drop if _merge==2
drop _merge


gen 	wave1 = 1 if eventname=="baseline_year_1_arm_1"
replace wave1 = 2 if eventname=="1_year_follow_up_y_arm_1"
replace wave1 = 3 if eventname=="2_year_follow_up_y_arm_1"
replace wave1 = 4 if eventname=="3_year_follow_up_y_arm_1"

gen 	wave2 = 1 if eventname=="baseline_year_1_arm_1"
replace wave2 = 2 if eventname=="6_month_follow_up_arm_1"
replace wave2 = 3 if eventname=="1_year_follow_up_y_arm_1"
replace wave2 = 4 if eventname=="18_month_follow_up_arm_1"
replace wave2 = 5 if eventname=="2_year_follow_up_y_arm_1"
replace wave2 = 6 if eventname=="30_month_follow_up_arm_1"
replace wave2 = 7 if eventname=="3_year_follow_up_y_arm_1"
replace wave2 = 8 if eventname=="42_month_follow_up_arm_1"


**************************************************************************************
**************************************************************************************
**************************************************************************************
**** Processing the data

*** Loading data on exclusion restrictions for structural imaging data

preserve

	clear
	import delimited "$data\abcd_mrfindings02.txt", varnames(1) encoding(Big5) 

	** Labeling variables
	foreach var of varlist * {
	  label variable `var' "`=`var'[1]'"
	  replace `var'="" if _n==1
	  destring `var', replace
	}

	drop in 1
	
	gen exclusion1 = (mrif_score==3 | mrif_score==4)
	
	keep subjectkey src_subject_id eventname exclusion1
	
	tempfile exclusion1
	save `exclusion1'

restore 
/*
preserve

	clear
	import delimited "$dexclusion\mriqcrp102.txt", varnames(1) encoding(Big5) 

	** Labeling variables
	foreach var of varlist * {
	  label variable `var' "`=`var'[1]'"
	  replace `var'="" if _n==1
	  destring `var', replace
	}

	drop in 1
	
	gen exclusion2 = (iqc_t1_ok_ser==0)
	gen exclusion3 = (iqc_t2_ok_ser==0)
	
	keep subjectkey src_subject_id eventname exclusion2 exclusion3
	
	tempfile exclusion2_3
	save `exclusion2_3'

restore 
*/
preserve

	clear
	import delimited "$data\freesqc01.txt", varnames(1) encoding(Big5) 

	** Labeling variables
	foreach var of varlist * {
	  label variable `var' "`=`var'[1]'"
	  replace `var'="" if _n==1
	  destring `var', replace
	}

	drop in 1
	
	gen exclusion4 = (fsqc_qc == 0)
	
	keep subjectkey src_subject_id eventname exclusion4
	
	tempfile exclusion4
	save `exclusion4'

restore 

preserve

	clear
	import delimited "$data\abcd_auto_postqc01.txt", varnames(1) encoding(Big5) 

	** Labeling variables
	foreach var of varlist * {
	  label variable `var' "`=`var'[1]'"
	  replace `var'="" if _n==1
	  destring `var', replace
	}

	drop in 1
	
	drop visit
	
	gen exclusion5 = (apqc_smri_t2w_regt1_rigid >= 10)
	
	keep if exclusion5==1
	
	keep subjectkey src_subject_id eventname exclusion5
	
	tempfile exclusion5
	save `exclusion5'

restore 

* Summary inclusion/exclusion criteria
preserve

	clear
	import delimited "$data\abcd_imgincl01.txt", varnames(1) encoding(Big5) 

	** Labeling variables
	foreach var of varlist * {
	  label variable `var' "`=`var'[1]'"
	  replace `var'="" if _n==1
	  destring `var', replace
	}

	drop in 1
	
	keep subjectkey src_subject_id eventname imgincl_t1w_include imgincl_t2w_include
	
	tempfile exclusion_c
	save `exclusion_c'

restore 


* Merging inclusion criteria
merge 1:1 subjectkey src_subject_id eventname using `exclusion1'
drop _merge
*merge 1:1 subjectkey src_subject_id eventname using `exclusion2_3'
*drop _merge
merge 1:1 subjectkey src_subject_id eventname using `exclusion4'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `exclusion5'
drop _merge
merge 1:1 subjectkey src_subject_id eventname using `exclusion_c'
drop _merge

*gen inclusion_t1w = (exclusion1==1 | exclusion2==1 | exclusion4==1)
*gen inclusion_t2w = (exclusion1==1 | exclusion2==1 | exclusion3==1 | exclusion4==1 | exclusion5==1)

*drop if inclusion_t1w==1
*drop if inclusion_t2w==1


**** Loading data on discrimination

preserve

	clear
	import delimited "$data\abcd_sscey01.txt", varnames(1) encoding(Big5) 

	** Labeling variables
	foreach var of varlist * {
	  label variable `var' "`=`var'[1]'"
	  replace `var'="" if _n==1
	  destring `var', replace
	}

	drop in 1
		
	keep subjectkey src_subject_id eventname dim_y_ss_mean crpbi_y_ss_parent
	rename crpbi_y_ss_parent pcwarmth
	rename dim_y_ss_mean ydiscrimin
	
	
	tempfile culture_env
	save `culture_env'

restore 

merge 1:1 subjectkey src_subject_id eventname using `culture_env'
drop _merge

**** Further data cleaning

*drop if imgincl_t1w_include == 0 & eventname=="baseline_year_1_arm_1"
*drop if imgincl_t2w_include == 0 & eventname=="baseline_year_1_arm_1"

foreach v of varlist smri_vol_cdk_cdacatelh-smri_vol_scs_subcorticalgv tfmri_nback_beh_switchflag-tfmri_nb_all_beh_ctotal_stdrt{
    replace `v' = . if (imgincl_t1w_include == 0 & eventname=="baseline_year_1_arm_1") | (imgincl_t2w_include == 0 & eventname=="baseline_year_1_arm_1")
}

/** Keeping the relevant sample: 
		1. Only baseline and one-year follow-up
		2. Only single-births (excluding siblings, twins, and triplets)
**/
*keep if eventname=="baseline_year_1_arm_1" | eventname=="2_year_follow_up_y_arm_1"

egen family_rel = max(rel_relationship), by(subjectkey)
*keep if family_rel==0
gen 	sibling = 0 if family_rel==0
replace sibling = 1 if family_rel>0

/* rel_ingroup_order: In-Group Order ID (twins and triplets in the same family and 
in the same group have different values) */
/* rel_group_id:	Group ID (twins and triplets in the same family share a group ID) */
/* rel_family_id: 	Family ID (participants belonging to the same family share a family ID). 
The family ID is autocalculated and will change after the addition/removal of subjects 
from the ABCD study. Family IDs will, therefore, differ between data releases*/
/* rel_relationship: 0 = single; 1 = sibling; 2 = twin; 3 = triplet */

**************************************************************************************
******************************** Main variables ***********************************
**************************************************************************************
***** Bullying definitions

/*
1. Poor peer relations index 1: Poor peer relations reported in Zucker (1997); Devries (2015); Levitan (2019)

2. Peer rejection index 2: van Gent (2011)
3. Teased a lot (Parents): cbcl_q38_p
4. Bullying index (Parents): b_invbul_p2 
	* cbcl_q16_p: Cruelty, bullying, or meanness to others
	* cbcl_q37_p: Gets in many fights
	* cbcl_q57_p: Physically attacks people
	* cbcl_q94_p: Teases a lot
5. Victimization index (Parents): b_invvic_p2
	* cbcl_q25_p: Doesn't get along with other kids
	* cbcl_q34_p: Feels others are out to get him/her
	* cbcl_q38_p: Gets teased a lot
	* cbcl_q48_p: Not liked by other kids
6. Discriminated against (Youth): discr_ag
	* dim_yesno_q1: In the past 12 months, have you felt discriminated against: because of your race
	* dim_yesno_q2: In the past 12 months, have you felt discriminated against: because you are (or where you are from)
	* dim_yesno_q3: In the past 12 months, have you felt discriminated against: because someone thought you were gay
	* dim_yesno_q4: In the past 12 months, have you felt discriminated against: because of your weight
*/
**** 1. Bullying involvement
* kbi_p_c_bully: 	Does your child have any problems with bullying at school or in your neighborhood?
* ksads_bully_~26: 	Do you have any problems with bullying at school or in your neighborhood?

*************************
** 1. Poor peer relations

egen peer1 	= rowmean(cbcl_q25_p cbcl_q38_p cbcl_q48_p)
egen peer1b = rowtotal(cbcl_q25_p cbcl_q38_p cbcl_q48_p), miss

alpha cbcl_q25_p cbcl_q38_p cbcl_q48_p if eventname=="baseline_year_1_arm_1"

***************************************************************************************************************************** 
*** 2. Peer rejection

egen peer2 	= rowmean(cbcl_q25_p cbcl_q34_p cbcl_q38_p cbcl_q48_p)
egen peer2b = rowtotal(cbcl_q25_p cbcl_q34_p cbcl_q38_p cbcl_q48_p), miss

alpha cbcl_q25_p cbcl_q34_p cbcl_q38_p cbcl_q48_p if eventname=="baseline_year_1_arm_1"

***************************************************************************************************************************** 
*** 3. Bully others 1

gen peer3 	= ksads_cdr_478_p

***************************************************************************************************************************** 
*** 4. Bully others 2

** Aggressiveness
* cbcl_q16_p: Cruelty, bullying, or meanness to others
* cbcl_q57_p: Physically attacks people
* cbcl_q94_p: Teases a lot
 
egen peer4 	= rowmean(cbcl_q16_p cbcl_q57_p cbcl_q94_p cbcl_q97_p)
egen peer4b = rowtotal(cbcl_q16_p cbcl_q57_p cbcl_q94_p cbcl_q97_p), miss

*alpha cbcl_q16_p cbcl_q57_p cbcl_q94_p cbcl_q97_p if eventname=="baseline_year_1_arm_1", item
alpha cbcl_q16_p cbcl_q57_p cbcl_q94_p cbcl_q97_p if eventname=="baseline_year_1_arm_1"

gen 	feels_lone = 1 if cbcl_q12_p==1 | cbcl_q12_p==2
replace feels_lone = 0 if cbcl_q12_p==0

global bullying_vars 	"peer1 peer4 feels_lone ydiscrimin cbcl_q25_p cbcl_q38_p cbcl_q48_p"


******************************************************************************************************************************
******************************************************************************************************************************
******************************************************************************************************************************
***** Parental acceptance definitions (and family conflict)

*** 1. Family: p_accept12 (Maximum of total scores between primary and secondary caregiver)
	* crpbi_parent1_y (Youth): Makes me feel better after talking over my worries with him/her
	* crpbi_parent2_y (Youth): Smiles at me very often
	* crpbi_parent3_y (Youth): Is able to make me feel better when I am upset
	* crpbi_parent4_y (Youth): Believes in showing his/her love for me
	* crpbi_parent5_y (Youth): Is easy to talk tot_siblings

egen non_missf = rownonmiss(crpbi_parent1_y crpbi_parent2_y crpbi_parent3_y crpbi_parent4_y crpbi_parent5_y) if  eventname=="baseline_year_1_arm_1"
egen non_misss = rownonmiss(crpbi_caregiver12_y crpbi_caregiver13_y crpbi_caregiver14_y crpbi_caregiver15_y crpbi_caregiver16_y) if  eventname=="baseline_year_1_arm_1"
	
egen p_acceptance = rowmean(crpbi_parent1_y crpbi_parent2_y crpbi_parent3_y crpbi_parent4_y crpbi_parent5_y crpbi_caregiver12_y crpbi_caregiver13_y crpbi_caregiver14_y crpbi_caregiver15_y crpbi_caregiver16_y) if (non_missf==4 | non_missf==5) & (non_misss==4 | non_misss==5)
egen first_acc = rowmean(crpbi_parent1_y crpbi_parent2_y crpbi_parent3_y crpbi_parent4_y crpbi_parent5_y) if (non_missf==4 | non_missf==5)
egen secon_acc = rowmean(crpbi_caregiver12_y crpbi_caregiver13_y crpbi_caregiver14_y crpbi_caregiver15_y crpbi_caregiver16_y) if (non_misss==4 | non_misss==5)
gen p_accept12 = (first_acc+secon_acc)/2

alpha 	crpbi_parent1_y crpbi_parent2_y crpbi_parent3_y crpbi_parent4_y crpbi_parent5_y 	///
		crpbi_caregiver12_y crpbi_caregiver13_y crpbi_caregiver14_y crpbi_caregiver15_y 	///
		crpbi_caregiver16_y if eventname=="baseline_year_1_arm_1"
		
alpha 	crpbi_parent1_y crpbi_parent2_y crpbi_parent3_y crpbi_parent4_y crpbi_parent5_y 	///
		if eventname=="baseline_year_1_arm_1"		

egen both_accept = rowmin(first_acc secon_acc)
egen any_accept = rowmax(first_acc secon_acc)
egen aver_accept = rowmean(first_acc secon_acc)
egen sum_accept = rowtotal(first_acc secon_acc)

*Who is the second caregiver?
label define crpbi_caregiver2_y 1 "mother" 2 "father" 3 "grandmother" 4 "grandfather" 5 "aunt" 6 "uncle" 7 "other"
label values crpbi_caregiver2_y crpbi_caregiver2_y 

egen mom_accept_aux1 = rowmean(crpbi_parent1_y crpbi_parent2_y crpbi_parent3_y crpbi_parent4_y crpbi_parent5_y) if crpbi_caregiver2_y>=2 & crpbi_caregiver2_y<.
egen mom_accept_aux2 = rowmean(crpbi_caregiver12_y crpbi_caregiver13_y crpbi_caregiver14_y crpbi_caregiver15_y crpbi_caregiver16_y) if crpbi_caregiver2_y==1
gen 	mom_accept = mom_accept_aux1 if crpbi_caregiver2_y>=2 & crpbi_caregiver2_y<.
replace mom_accept = mom_accept_aux2 if crpbi_caregiver2_y==1

egen dad_accept_aux1 = rowmean(crpbi_parent1_y crpbi_parent2_y crpbi_parent3_y crpbi_parent4_y crpbi_parent5_y) if crpbi_caregiver2_y==1 | (crpbi_caregiver2_y>=3 & crpbi_caregiver2_y<.)
egen dad_accept_aux2 = rowmean(crpbi_caregiver12_y crpbi_caregiver13_y crpbi_caregiver14_y crpbi_caregiver15_y crpbi_caregiver16_y) if crpbi_caregiver2_y==2
gen 	dad_accept = dad_accept_aux1 if crpbi_caregiver2_y==1 | (crpbi_caregiver2_y>=3 & crpbi_caregiver2_y<.)
replace dad_accept = dad_accept_aux2 if crpbi_caregiver2_y==2

gen 	getal_careg = 1 if kbi_p_conflict==1
replace getal_careg = 0 if kbi_p_conflict==2 | kbi_p_conflict==3

** Family conflict

alpha 	fes_youth_q1 fes_youth_q2 fes_youth_q3 fes_youth_q4 fes_youth_q5 fes_youth_q6 		///
		fes_youth_q7 fes_youth_q8 fes_youth_q9 if eventname=="baseline_year_1_arm_1"
		

global family_vars 	"p_acceptance first_acc secon_acc aver_accept dad_accept mom_accept fam_confav getal_careg pcwarmth crpbi_parent1_y crpbi_parent2_y crpbi_parent3_y crpbi_parent4_y crpbi_parent5_y crpbi_caregiver12_y crpbi_caregiver13_y crpbi_caregiver14_y crpbi_caregiver15_y crpbi_caregiver16_y fes_youth_q1 fes_youth_q2 fes_youth_q3 fes_youth_q4 fes_youth_q5 fes_youth_q6 fes_youth_q7 fes_youth_q8 fes_youth_q9"

******************************************************************************************************************************
******************************************************************************************************************************
******************************************************************************************************************************
***** Close friends

egen n_friends = rowtotal(resiliency5a_y resiliency6a_y), miss
egen n_cfriends = rowtotal(resiliency5b_y resiliency6b_y), miss

global friend_vars 	"n_friends n_cfriends h_bfriend"

******************************************************************************************************************************
******************************************************************************************************************************
******************************************************************************************************************************
***** School environment

gen 	getal_teacher = 1 if school_3_y==3 | school_3_y==4
replace getal_teacher = 0 if school_3_y==1 | school_3_y==2

rename school_positive sch_pos
egen school_positive = rowmean(school_2_y school_3_y school_4_y school_5_y school_7_y school_10_y)

alpha 	school_2_y school_3_y school_4_y school_5_y school_7_y school_10_y		///
		if eventname=="baseline_year_1_arm_1"

alpha 	school_2_y school_3_y school_4_y school_5_y school_7_y school_10_y		///
		if eventname=="1_year_follow_up_y_arm_1"

** Opportunities for prosocial behavior
*school_2_y: In my school, students have lots of chances to help decide things like class activities
*school_5_y: There are lots of chances for students in my school to get involved in sports (and others)
*school_10_y: There are lots of chances to be part of class discussions or activities

** Rewards for prosocial behavior
*school_3_y: I get along with my teachers
*school_4_y: My teacher(s) notices when I am doing a good job and lets me know about it
*school_7_y: The school lets my parents know when I have done something well

global school_vars 	"getal_teacher school_positive st_engaged school_2_y school_3_y school_4_y school_5_y school_7_y school_10_y"


******************************************************************************************************************************
******************************************************************************************************************************
******************************************************************************************************************************
***** Neighboorhood environment

foreach v of varlist comc_phenx_close_knit_p-comc_phenx_budget_p{
	replace `v' = . if `v'>5
}
egen nhood_cohes = rowmean(comc_phenx_close_knit_p-comc_phenx_budget_p)

global nhood_vars 	"neighborhood_crime_y nhood_cohes reshist_addr1_adi_wsum reshist_addr1_adi_perc"
*reshist_addr1_adi_in_dis reshist_addr1_adi_pov reshist_addr1_adi_b138


******************************************************************************************************************************
******************************************************************************************************************************
******************************************************************************************************************************
***** Emotion regulation

global emoreg_vars 	"poa_y_ss_sum tfmri_nb_all_beh_ctotal_nt"

******************************************************************************************************************************
******************************************************************************************************************************
******************************************************************************************************************************
***** Traumatic events (or life negative events?) OR ***History of trauma exposure
*
egen trauma_ev = rowmean(ksads_ptsd_raw_754_p ksads_ptsd_raw_755_p ksads_ptsd_raw_756_p ksads_ptsd_raw_757_p ksads_ptsd_raw_758_p ksads_ptsd_raw_759_p ksads_ptsd_raw_760_p ksads_ptsd_raw_761_p ksads_ptsd_raw_764_p ksads_ptsd_raw_767_p ksads_ptsd_raw_768_p)

egen trauma_eva = rowmean(ksads_ptsd_raw_754_p ksads_ptsd_raw_755_p ksads_ptsd_raw_756_p ksads_ptsd_raw_757_p ksads_ptsd_raw_758_p ksads_ptsd_raw_759_p ksads_ptsd_raw_760_p ksads_ptsd_raw_761_p ksads_ptsd_raw_762_p ksads_ptsd_raw_763_p ksads_ptsd_raw_764_p ksads_ptsd_raw_765_p ksads_ptsd_raw_766_p ksads_ptsd_raw_767_p ksads_ptsd_raw_768_p ksads_ptsd_raw_769_p ksads_ptsd_raw_770_p)

egen trauma_evb = rowmean(ksads_ptsd_raw_754_p ksads_ptsd_raw_755_p ksads_ptsd_raw_756_p ksads_ptsd_raw_757_p ksads_ptsd_raw_758_p ksads_ptsd_raw_759_p ksads_ptsd_raw_760_p ksads_ptsd_raw_761_p ksads_ptsd_raw_762_p ksads_ptsd_raw_763_p ksads_ptsd_raw_764_p ksads_ptsd_raw_765_p ksads_ptsd_raw_766_p ksads_ptsd_raw_767_p ksads_ptsd_raw_768_p ksads_ptsd_raw_769_p)

*egen Trauma_ev = rowtotal(ksads_ptsd_raw_754_p ksads_ptsd_raw_755_p ksads_ptsd_raw_756_p ksads_ptsd_raw_757_p ksads_ptsd_raw_758_p ksads_ptsd_raw_759_p ksads_ptsd_raw_760_p ksads_ptsd_raw_761_p ksads_ptsd_raw_764_p ksads_ptsd_raw_767_p ksads_ptsd_raw_768_p), miss

egen Trauma_ev = rowtotal(ksads_ptsd_raw_754_p ksads_ptsd_raw_755_p ksads_ptsd_raw_756_p ksads_ptsd_raw_757_p ksads_ptsd_raw_758_p ksads_ptsd_raw_759_p ksads_ptsd_raw_760_p ksads_ptsd_raw_761_p ksads_ptsd_raw_762_p ksads_ptsd_raw_763_p ksads_ptsd_raw_764_p ksads_ptsd_raw_765_p ksads_ptsd_raw_766_p ksads_ptsd_raw_767_p ksads_ptsd_raw_768_p ksads_ptsd_raw_769_p ksads_ptsd_raw_770_p), miss

egen Trauma_eva = rowtotal(ksads_ptsd_raw_754_p ksads_ptsd_raw_755_p ksads_ptsd_raw_756_p ksads_ptsd_raw_757_p ksads_ptsd_raw_758_p ksads_ptsd_raw_759_p ksads_ptsd_raw_760_p ksads_ptsd_raw_761_p ksads_ptsd_raw_762_p ksads_ptsd_raw_763_p ksads_ptsd_raw_764_p ksads_ptsd_raw_765_p ksads_ptsd_raw_766_p ksads_ptsd_raw_767_p ksads_ptsd_raw_768_p ksads_ptsd_raw_769_p ksads_ptsd_raw_770_p), miss

egen Trauma_evb = rowtotal(ksads_ptsd_raw_754_p ksads_ptsd_raw_755_p ksads_ptsd_raw_756_p ksads_ptsd_raw_757_p ksads_ptsd_raw_758_p ksads_ptsd_raw_759_p ksads_ptsd_raw_760_p ksads_ptsd_raw_761_p ksads_ptsd_raw_762_p ksads_ptsd_raw_763_p ksads_ptsd_raw_764_p ksads_ptsd_raw_765_p ksads_ptsd_raw_766_p ksads_ptsd_raw_767_p ksads_ptsd_raw_768_p ksads_ptsd_raw_769_p), miss

gen 	Trauma_sex = 0 if Trauma_eva!=.
replace Trauma_sex = 1 if ksads_ptsd_raw_767_p==1 | ksads_ptsd_raw_768_p==1 | ksads_ptsd_raw_769_p==1

gen 	Trauma_osex = 0 if Trauma_eva==0
replace Trauma_osex = 1 if ksads_ptsd_raw_754_p==1 | ksads_ptsd_raw_755_p==1 | ksads_ptsd_raw_756_p==1 | ksads_ptsd_raw_757_p==1 |  ksads_ptsd_raw_758_p==1 |  ksads_ptsd_raw_759_p==1 |  ksads_ptsd_raw_760_p==1 |  ksads_ptsd_raw_761_p==1 |  ksads_ptsd_raw_762_p==1 | ksads_ptsd_raw_763_p==1 | ksads_ptsd_raw_764_p==1 | ksads_ptsd_raw_765_p==1 | ksads_ptsd_raw_766_p==1 | ksads_ptsd_raw_770_p==1
replace Trauma_osex = 2 if ksads_ptsd_raw_767_p==1 | ksads_ptsd_raw_768_p==1 | ksads_ptsd_raw_769_p==1

** Items excluded
*ksads_ptsd_raw_762_p: 		Shot, stabbed, or beaten brutally by a grown up in the home
*ksads_ptsd_raw_763_p:		Beaten to the point of having bruises by a grown up in the home
*ksads_ptsd_raw_765_p:		A family member threatened to kill your child
*ksads_ptsd_raw_766_p:		Witness the grownups in the home push, shove or hit one another
*ksads_ptsd_raw_769_p:		A peer forced your child to do something sexually
*ksads_ptsd_raw_770_p:		Learned about the sudden unexpected death of a loved one	(Almost 25% of children suffered it)


** Negative life events (new sibling, school, parents out of a job, more parental fights)
*ple_y_ss_total_bad: 		Total Number of Bad Events: Validation: No Minimum
*ple_y_ss_affected_bad_sum: How Much Affected Bad - Sum: Validation: No Minimum
*global ple_vars 		"ple_y_ss_total_bad ple_y_ss_affected_bad_sum ple_p_ss_affected_bad_sum ple_p_ss_total_bad"

******************************************************************************************************************************
******************************************************************************************************************************
******************************************************************************************************************************
***** Potential mediators, moderators, other outcomes

	* First set of moderators
		* nihtbx_fluidcomp_fc: 				Cognition Fluid Composite Fully-Corrected T-score
		* nihtbx_cryst_fc:					Crystallized Composite Fully-Corrected T-score
		* nihtbx_totalcomp_fc:				Cognition Total Composite Score Fully-Corrected T-score
		* latent_factor_ss_general_ses:		General latent factor of economic, social, and physiological well-being
		* latent_factor_ss_social:			Latent factor for youth perceived social support
		* latent_factor_ss_perinatal:		Latent factor for perinatal health

	* Second set of moderators		
		* h_bfriend: 						Has a best friend
			gen 	h_bfriend = 1 if kbi_p_c_best_friend==1
			replace h_bfriend = 0 if kbi_p_c_best_friend==0 
			* kbi_p_c_best_friend==3 is the not sure category - I will exclude it
		
		* l_bfriend:						Length friendship with best friend
			gen 	l_bfriend = kbi_p_c_best_friend_len
			replace l_bfriend = 0 if h_bfriend==0
		
		* pro_socialy:						Prosocial behavior - Youth responses
		* pro_socialp:						Prosocial behavior - caregiver responses
		* neighborhood_crime_y:				My neighborhood is safe from crime
		* at_risk_sod:						At risk of social exclusion - obese + LGBTQ + Immigrant
			
			* Another alternative is to use parents' report: kbi_p_c_gay (=1 or 2 vs. 3) kbi_p_c_trans (=1 or 2 vs. 3)
			gen 	trans = 1 		if kbi_y_trans_id==1 | kbi_y_trans_id==2
			replace trans = 0		if kbi_y_trans_id==3
			gen 	lgb = 1 		if kbi_y_sex_orient==1 | kbi_y_sex_orient==2 
			replace lgb = 0			if kbi_y_sex_orient==3
			egen immigrant = max(foreign_y), by(subjectkey)
			*obes_weight (=1)
			
			gen 	at_risk_sod = 1 	if trans==1 | lgb==1 | immigrant==1 | obes_weight==1
			replace at_risk_sod = 0 	if at_risk_sod==.

	* Third set of moderators
		* physical_activity1_y: 			During the past 7 days, on how many days were you physically active for a total
		* nosportp:							Has not participated EVER in any of 28 sports
		* bis_y_ss_bis_sum:					BIS/BAS: BIS Sum:  bisbas1_y + bisbas2_y + bisbas3_y + bisbas4_y + bisbas5_y + b
		* bis_y_ss_bas_rr:					BIS/BAS: BAS Reward Responsiveness:  bisbas8_y + bisbas9_y + bisbas10_y + bisba
		* bis_y_ss_bas_drive: 				BIS/BAS: BAS drive:  bisbas13_y + bisbas14_y + bisbas15_y + bisbas16_y; Validat
		* bis_y_ss_bas_fs: 					BIS/BAS: BAS Fun Seeking: bisbas17_y + bisbas18_y + bisbas19_y + bisbas20_y; Val

	* Fourth set of moderators
		* White: 							White race
			egen white = max(demo_race_a_p___10), by(subjectkey)
			egen care_white = max(demo_prnt_race_a_v2___10), by(subjectkey)

		* Black:							Black race
			egen black = max(demo_race_a_p___11), by(subjectkey)
			egen care_black = max(demo_prnt_race_a_v2___11), by(subjectkey)

		* Native:							Native race
			gen 	native_aux = 1 if demo_race_a_p___12==1 | demo_race_a_p___13==1 | demo_race_a_p___14==1 | demo_race_a_p___15==1 | demo_race_a_p___16==1 | demo_race_a_p___17==1
			replace native_aux = 0 if native_aux==.
			egen 	native = max(native_aux), by(subjectkey)

		* Asian:							Asian race
			gen 	asian_aux = 1 if demo_race_a_p___18==1 | demo_race_a_p___19==1 | demo_race_a_p___20==1 | demo_race_a_p___21==1 | demo_race_a_p___22==1 | demo_race_a_p___23==1 | demo_race_a_p___24==1
			replace asian_aux = 0 if asian_aux==.
			egen 	asian = max(asian_aux), by(subjectkey)

		* Other race: 				BIS/BAS: BAS drive:  bisbas13_y + bisbas14_y + bisbas15_y + bisbas16_y; Validat
			egen other_r = max(demo_race_a_p___25), by(subjectkey)

		* Hispanic: 					BIS/BAS: BAS Fun Seeking: bisbas17_y + bisbas18_y + bisbas19_y + bisbas20_y; Val
			gen 	hisp_lat_aux = 1 if demo_ethn_v2==1
			replace hisp_lat_aux = 0 if demo_ethn_v2==2
			egen 	hisp_lat = max(hisp_lat_aux), by(subjectkey)

	* Fifht set of moderators (UPSS plus physical health at baseline)
		* upps_y_ss_negative_urgency:				UPPS-P for Children Short Form (ABCD-version), Negative Urgency: upps7_y + upps1
		* upps_y_ss_lack_of_planning:				UPPS-P for Children Short Form (ABCD-version), Lack of Planning: upps6_y + upps
		* upps_y_ss_sensation_seeking:              UPPS-P for Children Short Form (ABCD-version), Sensation Seeking: upps12_y + upp
		* upps_y_ss_positive_urgency:				UPPS-P for Children Short Form (ABCD-version), Positive Urgency: upps35_y + upps
		* upps_y_ss_lack_of_perseverance:			UPPS-P Lack of Perseverance (GSSF) upps15_y plus upps19_y plus upps22_y plus upps2
		* demo_prnt_prtnr_v2: has a partner
		replace demo_prnt_prtnr_v2 = . if demo_prnt_prtnr_v2>3

	* Vulnerabilities
	gen 	obese = 1 if over_weight==1 | obes_weight==1
	replace obese = 0 if undr_weight==1 | norm_weight==1
	
	gen 	p_immigr = 1 if foreign_p==1
	replace p_immigr = 0 if foreign_p==0
	
	gen 	m_race = 1 if black==1 | native==1 
	replace m_race = 0 if black!=1 & native!=1
	
	* Has a partner
	gen 	partner = 1 if demo_prnt_prtnr_v2==1
	replace	partner = 0 if demo_prnt_prtnr_v2==2
	
	* Married + living with a partner
	gen 	cohabit = 1 if demo_prnt_marital_v2==1 | demo_prnt_marital_v2==6
	replace cohabit = 0 if demo_prnt_marital_v2>=2 & demo_prnt_marital_v2<=5

**********************
***History of problems

** History of tought problems
* Mania
rename famhx_ss_fath_prob_ma_p 	fatherh_mania
rename famhx_ss_moth_prob_ma_p 	motherh_mania
rename famhx_ss_parent_ma_p 	fmtherh_mania
rename famhx_ss_patgf_prob_ma_p patgraf_mania
rename famhx_ss_patgm_prob_ma_p patgram_mania
rename famhx_ss_matgf_prob_ma_p matgraf_mania
rename famhx_ss_matgm_prob_ma_p matgram_mania

egen floadp_mania = rowtotal(fatherh_mania motherh_mania), miss
egen floadgp_mania = rowtotal(patgraf_mania patgram_mania matgraf_mania matgram_mania), miss
/*
gen 	hist_mania = 0 if fatherh_mania==0 & motherh_mania==0 & patgraf_mania==0 & patgram_mania==0 & matgraf_mania==0 & matgram_mania==0 & eventname=="baseline_year_1_arm_1"
replace hist_mania = 1 if fatherh_mania==1 & floadp_mania==1 & eventname=="baseline_year_1_arm_1"
replace hist_mania = 2 if motherh_mania==1 & floadp_mania==1 & eventname=="baseline_year_1_arm_1"
replace hist_mania = 3 if floadp_mania==2 & eventname=="baseline_year_1_arm_1"
replace hist_mania = 4 if hist_mania==. & floadgp_mania>0 & floadgp_mania<. & eventname=="baseline_year_1_arm_1"
replace hist_mania = 5 if floadp_mania>0 & floadp_mania<. & floadgp_mania>0 & floadgp_mania<. & eventname=="baseline_year_1_arm_1"

label define hist_mania 0 "No family load" 1 "Father load" 2 "Mother load" 3 "Both parents load" 4 "Any grandparent load" 5 "Parents and grandparent load"
label values hist_mania hist_mania
*/

gen 	hist_mania = 0 if floadp_mania==0 & floadgp_mania==0
replace hist_mania = 1 if floadp_mania>=1 & floadp_mania<. & floadgp_mania==0
replace hist_mania = 2 if floadp_mania==0 & floadgp_mania>=1 & floadgp_mania<.
replace hist_mania = 3 if floadp_mania>=1 & floadp_mania<. & floadgp_mania>=1 & floadgp_mania<.

label define hist_mania 0 "No family load" 1 "Parental load" 2 "Grand parents generation load" 3 "Both parents and grandparents load" 
label values hist_mania hist_mania

* Paranoia
rename famhx_ss_fath_prob_vs_p 	fatherh_paran
rename famhx_ss_moth_prob_vs_p 	motherh_paran
rename famhx_ss_parent_vs_p 	fmtherh_paran
rename famhx_ss_patgf_prob_vs_p patgraf_paran
rename famhx_ss_patgm_prob_vs_p patgram_paran
rename famhx_ss_matgf_prob_vs_p matgraf_paran
rename famhx_ss_matgm_prob_vs_p matgram_paran

egen floadp_paran = rowtotal(fatherh_paran motherh_paran), miss
egen floadgp_paran = rowtotal(patgraf_paran patgram_paran matgraf_paran matgram_paran), miss
/*
gen 	hist_paran = 0 if fatherh_paran==0 & motherh_paran==0 & patgraf_paran==0 & patgram_paran==0 & matgraf_paran==0 & matgram_paran==0 & eventname=="baseline_year_1_arm_1"
replace hist_paran = 1 if fatherh_paran==1 & floadp_paran==1 & eventname=="baseline_year_1_arm_1"
replace hist_paran = 2 if motherh_paran==1 & floadp_paran==1 & eventname=="baseline_year_1_arm_1"
replace hist_paran = 3 if floadp_paran==2 & eventname=="baseline_year_1_arm_1"
replace hist_paran = 4 if hist_paran==. & floadgp_paran>0 & floadgp_paran<. & eventname=="baseline_year_1_arm_1"
replace hist_paran = 5 if floadp_paran>0 & floadp_paran<. & floadgp_paran>0 & floadgp_paran<. & eventname=="baseline_year_1_arm_1"

label define hist_paran 0 "No family load" 1 "Father load" 2 "Mother load" 3 "Both parents load" 4 "Any grandparent load" 5 "Parents and grandparent load"
label values hist_paran hist_paran
*/

gen 	hist_paran = 0 if floadp_paran==0 & floadgp_paran==0
replace hist_paran = 1 if floadp_paran>=1 & floadp_paran<. & floadgp_paran==0
replace hist_paran = 2 if floadp_paran==0 & floadgp_paran>=1 & floadgp_paran<.
replace hist_paran = 3 if floadp_paran>=1 & floadp_paran<. & floadgp_paran>=1 & floadgp_paran<.

label define hist_paran 0 "No family load" 1 "Parental load" 2 "Grand parents generation load" 3 "Both parents and grandparents load" 
label values hist_paran hist_paran


* Depressive symptoms
rename famhx_ss_fath_prob_dprs_p 	fatherh_dprsv
rename famhx_ss_moth_prob_dprs_p 	motherh_dprsv
rename famhx_ss_parent_dprs_p 		fmtherh_dprsv
rename famhx_ss_patgf_prob_dprs_p 	patgraf_dprsv
rename famhx_ss_patgm_prob_dprs_p 	patgram_dprsv
rename famhx_ss_matgf_prob_dprs_p 	matgraf_dprsv
rename famhx_ss_matgm_prob_dprs_p 	matgram_dprsv

egen floadp_dprsv = rowtotal(fatherh_dprsv motherh_dprsv), miss
egen floadgp_dprsv = rowtotal(patgraf_dprsv patgram_dprsv matgraf_dprsv matgram_dprsv), miss


gen 	hist_dprsv = 0 if floadp_dprsv==0 & floadgp_dprsv==0
replace hist_dprsv = 1 if floadp_dprsv>=1 & floadp_dprsv<. & floadgp_dprsv==0
replace hist_dprsv = 2 if floadp_dprsv==0 & floadgp_dprsv>=1 & floadgp_dprsv<.
replace hist_dprsv = 3 if floadp_dprsv>=1 & floadp_dprsv<. & floadgp_dprsv>=1 & floadgp_dprsv<.

label define hist_dprsv 0 "No family load" 1 "Parental load" 2 "Grand parents generation load" 3 "Both parents and grandparents load" 
label values hist_dprsv hist_dprsv
*famhx_ss_fath_prob_dprs_p famhx_ss_moth_prob_dprs_p famhx_ss_momdad_dprs_p famhx_ss_parent_dprs_p

* Externalizing symptoms
rename famhx_ss_fath_prob_trb_p 	fatherh_trbl
rename famhx_ss_moth_prob_trb_p 	motherh_trbl
rename famhx_ss_parent_trb_p 		fmtherh_trbl
rename famhx_ss_patgf_prob_trb_p 	patgraf_trbl
rename famhx_ss_patgm_prob_trb_p 	patgram_trbl
rename famhx_ss_matgf_prob_trb_p 	matgraf_trbl
rename famhx_ss_matgm_prob_trb_p 	matgram_trbl

egen floadp_trbl = rowtotal(fatherh_trbl motherh_trbl), miss
egen floadgp_trbl = rowtotal(patgraf_trbl patgram_trbl matgraf_trbl matgram_trbl), miss


gen 	hist_trbl = 0 if floadp_trbl==0 & floadgp_trbl==0
replace hist_trbl = 1 if floadp_trbl>=1 & floadp_trbl<. & floadgp_trbl==0
replace hist_trbl = 2 if floadp_trbl==0 & floadgp_trbl>=1 & floadgp_trbl<.
replace hist_trbl = 3 if floadp_trbl>=1 & floadp_trbl<. & floadgp_trbl>=1 & floadgp_trbl<.

label define hist_trbl 0 "No family load" 1 "Parental load" 2 "Grand parents generation load" 3 "Both parents and grandparents load" 
label values hist_trbl hist_trbl


* At least one parent (or both) is category 3
foreach f in famhx_ss_parent_alc_p famhx_ss_parent_dg_p fmtherh_dprsv fmtherh_mania fmtherh_paran fmtherh_trbl famhx_ss_parent_nrv_p famhx_ss_parent_prf_p famhx_ss_parent_hspd_p famhx_ss_parent_scd_p{
	*replace `f' = 4 if `f'==3
	replace `f' = 3 if `f'==-1 | `f'==-2 
}

egen internal_p = rowmax(fmtherh_dprsv famhx_ss_parent_nrv_p)
egen thougth_p = rowmax(fmtherh_mania fmtherh_paran)
egen external_p = rowmax(fmtherh_trbl famhx_ss_parent_alc_p famhx_ss_parent_dg_p)

*** Mental health children
gen 	any_dschiz = 1 if uschizoph_c==1 | hallucina_c==1 | delusionsp_c==1 | psychotic_c==1
replace any_dschiz = 0 if any_dschiz==. & (uschizoph_c==0 | hallucina_c==0 | delusionsp_c==0 | psychotic_c==0)

* Psychosis severity
gen 	pps_ss_mean_severityc = pps_ss_mean_severity
replace pps_ss_mean_severityc = 0 if pps_ss_mean_severity==. & pps_y_ss_number==0


global health_speccbcl 	"cbcl_scr_syn_external_t cbcl_scr_syn_internal_t cbcl_scr_syn_internal_r cbcl_scr_syn_thought_r cbcl_scr_syn_attention_r cbcl_scr_syn_external_r"
*global health_subfact 	"sex_problems;eating_problems;fear;distress;mania;substance_abuse;antisocial_behavior"
global health_syndcbcl 	"cbcl_scr_dsm5_depress_r cbcl_scr_dsm5_anxdisord_r cbcl_scr_dsm5_somaticpr_r cbcl_scr_dsm5_adhd_r cbcl_scr_dsm5_opposit_r cbcl_scr_07_sct_r cbcl_scr_07_ocd_r cbcl_scr_07_stress_r"
global health_syndcbclt "cbcl_scr_dsm5_depress_t cbcl_scr_dsm5_anxdisord_t cbcl_scr_dsm5_somaticpr_t cbcl_scr_dsm5_adhd_t cbcl_scr_dsm5_opposit_t cbcl_scr_07_sct_t cbcl_scr_07_ocd_t cbcl_scr_07_stress_t"

global dsm5_MDD "ksads_1_1_p ksads_1_3_p ksads_1_5_p ksads_22_141_p ksads_23_143_p ksads_23_145_p ksads_23_147_p ksads_23_149_p ksads_1_157_p ksads_1_159_p ksads_1_161_p ksads_1_163_p ksads_1_165_p ksads_1_167_p ksads_1_169_p ksads_1_171_p ksads_1_173_p ksads_1_175_p ksads_1_177_p ksads_1_179_p ksads_1_181_p ksads_1_183_p"

global dsm5y_MDD "ksads_1_1_t ksads_1_3_t ksads_1_5_t ksads_22_141_t ksads_23_143_t ksads_23_145_t ksads_23_147_t ksads_23_149_t ksads_1_157_t ksads_1_159_t ksads_1_161_t ksads_1_163_t ksads_1_165_t ksads_1_167_t ksads_1_169_t ksads_1_171_t ksads_1_173_t ksads_1_175_t ksads_1_177_t ksads_1_179_t ksads_1_181_t ksads_1_183_t dpry_eating dpry_sleep dpry_motor dpry_energy drpy_worth drpy_decis drpy_suic"

** Non CBCL scales
* Sip of alcohol
gen 	sip_alcohol = tlfb_alc_sip if eventname=="baseline_year_1_arm_1"
replace sip_alcohol = tlfb_alc_sip_l if eventname!="baseline_year_1_arm_1"

* Tried cigarrettes
gen 	puff_cig = tlfb_tob_puff if eventname=="baseline_year_1_arm_1"
replace puff_cig = tlfb_tob_puff_l if eventname!="baseline_year_1_arm_1"

global health_syndr 	"Dsm5_mdd Dsm5_mddP dsm5_mddvm dsm5_mddvmP Dsm5_dys Dsm5_manic Dsm5_psyc Dsm5_psycr Dsm5_sepx Dsm5_anxpb Dsm5_eatd Dsm5_adhdina Dsm5_adhdimp Dsm5_adhd Dsm5_odd Dsm5_condd Dsm5_suicb Dsm5y_mdd Dsm5y_mddP dsm5y_mddvm dsm5y_mddvmP Dsm5y_dys Dsm5y_manic Dsm5y_anxpb Dsm5y_suicb pps_ss_mean_severityc pgbi_p_ss_score mddy_diagn dsm5_adhdinaP dsm5_adhdimpP dsm5_adhdP"
*drpy_suic
** Syndromes/disorders
global health_psychs 	"pps_y_ss_number pps_ss_mean_severityc psychotic_c any_dschiz"
global health_mania 	"pgbi_p_ss_score bpimanic_c bpidepre_c bpihyman_c bpiidepre_c bpiihyman_c bpunspec_c"

global asr_depre 		"asr_q14_p asr_q18_p asr_q24_p asr_q35_p asr_q52_p asr_q54_p asr_q60_p asr_q77_p asr_q78_p asr_q91_p asr_q100_p asr_q102_p asr_q103_p asr_q107_p"

/** Notes
	. sup_y_ss_sum: 7up mania only available for one-year follow-up
	. ssrs: severity of social impairment within the autism spectrum only available for one-year follow-up
	. poa_nihtb: Positive emotions only available for one-year follow-up (abcd_yssbpm01)
	. ywpss01: self-control and planning only available for one-year follow-up
	. abcd_bpm01: Normed multi-informant monitoring of children's functioning, youth report only available for one-year follow-up (abcd_yssbpm01)
	. abcd_eatqp01: Early Adolescent Temperament only available for two-year follow-up
	. upps_y_ss: Impulsivity measured at baseline and two-year follow-up (not one-year follow-up)
	. bisbas_y_ss: Impulsivity measured at baseline and two-year follow-up (not one-year follow-up)
**/

*************************
***** Cortical regions

*** Frontal lobe: mPFC, dlPFC, ACC, OFC

** Regions in the Prefrontal Cortex

* Frontal pole (part of the dorso lateral PFC)
gen fropl_ic = (smri_vol_cdk_frpolelh)/smri_vol_scs_intracranialv 		/* Frontal pole */
gen fropr_ic = (smri_vol_cdk_frpolerh)/smri_vol_scs_intracranialv 		/* Frontal pole */
gen frop_ic = (fropl_ic+fropr_ic)/2 

/*
* Caudal Middle Frontal Cortex (MFC towards the tail)
gen cmfcl_ic = smri_vol_cdk_cdmdfrlh/smri_vol_scs_intracranialv 		/* Caudal Middle Frontal Cortex */
gen cmfcr_ic = smri_vol_cdk_cdmdfrrh/smri_vol_scs_intracranialv 		/* Caudal Middle Frontal Cortex */
gen cmfc_ic = (cmfcl_ic+cmfcr_ic)/2
*/
* Rostral Middle Frontal Cortex (MFC towards the tail)
gen rmfcl_ic = smri_vol_cdk_rrmdfrlh/smri_vol_scs_intracranialv 		/* Rostral Middle Frontal Cortex */
gen rmfcr_ic = smri_vol_cdk_rrmdfrrh/smri_vol_scs_intracranialv 		/* Rostral Middle Frontal Cortex */
gen rmfc_ic = (rmfcl_ic+rmfcr_ic)/2

/* Should we also add to the analysis the Superior Frontal Cortex?
variables: smri_vol_cdk_sufrlh smri_vol_cdk_sufrrh */

** Anterior Cingulate Cortex
* Caudal Anterior Cingulate Cortex (ACC towards the tail)
gen caccl_ic = smri_vol_cdk_cdacatelh/smri_vol_scs_intracranialv 		/* Caudal anterior cingulate cortex */
gen caccr_ic = smri_vol_cdk_cdacaterh/smri_vol_scs_intracranialv 		/* Caudal anterior cingulate cortex */
gen cacc_ic = (caccl_ic+caccr_ic)/2

/*
* Rostral Anterior Cingulate Cortex (ACC towards the nose/beak)
gen raccl_ic = smri_vol_cdk_rracatelh/smri_vol_scs_intracranialv 		/* Rostral anterior cingulate cortex */
gen raccr_ic = smri_vol_cdk_rracaterh/smri_vol_scs_intracranialv 		/* Rostral anterior cingulate cortex */
gen racc_ic = (raccl_ic+raccr_ic)/2
*/

** Orbitofrontal Cortex (OFC)
* Medial Orbitofrontal Cortex (OFC around the midline)
gen morbfl_ic = (smri_vol_cdk_mobfrlh)/smri_vol_scs_intracranialv 		/* Medial orbitofrontal */
gen morbfr_ic = (smri_vol_cdk_mobfrrh)/smri_vol_scs_intracranialv 		/* Medial orbitofrontal */
gen morbf_ic = (morbfl_ic+morbfr_ic)/2

* Lateral Orbitofrontal Cortex (OFC away from the midline)
gen lorbfl_ic = (smri_vol_cdk_lobfrlh)/smri_vol_scs_intracranialv 		/* Lateral orbitofrontal */
gen lorbfr_ic = (smri_vol_cdk_lobfrrh)/smri_vol_scs_intracranialv 		/* Lateral orbitofrontal */
gen lorbf_ic = (lorbfl_ic+lorbfr_ic)/2

* Insula
gen insul_ic = smri_vol_cdk_insulalh/smri_vol_scs_intracranialv 		/* Insula subdivisions not available - Mid and posterior seem to be more important for mental health */
gen insur_ic = smri_vol_cdk_insularh/smri_vol_scs_intracranialv 		/* Insula subdivisions not available - Mid and posterior seem to be more important for mental health */
gen insu_ic = (insul_ic+insur_ic)/2 	


***************************
** Subcortical regions
gen amygl_ic = smri_vol_scs_amygdalalh/smri_vol_scs_intracranialv		/* Amygdala */
gen amygr_ic = smri_vol_scs_amygdalarh/smri_vol_scs_intracranialv		/* Amygdala */
gen amyg_ic = (amygl_ic+amygr_ic)/2 	

gen hippl_ic = smri_vol_scs_hpuslh/smri_vol_scs_intracranialv			/* Hippocampus */
gen hippr_ic = smri_vol_scs_hpusrh/smri_vol_scs_intracranialv			/* Hippocampus */
*gen hipp_ic = (hippl_ic+hippr_ic)/2 
gen hipp_ic = (hippl_ic+hippr_ic)

gen thall_ic = smri_vol_scs_tplh/smri_vol_scs_intracranialv				/* Thalamus (subdivisions not available. It seems dorsomedial is relevant for mental health) */
gen thalr_ic = smri_vol_scs_tprh/smri_vol_scs_intracranialv				/* Thalamus (subdivisions not available. It seems dorsomedial is relevant for mental health) */
gen thal_ic = (thall_ic+thalr_ic)/2 	
	

***************************
** Basal Ganglia regions
gen stril_ic = (smri_vol_scs_putamenlh+smri_vol_scs_caudatelh+smri_vol_scs_aal)/smri_vol_scs_intracranialv
gen strir_ic = (smri_vol_scs_putamenrh+smri_vol_scs_caudaterh+smri_vol_scs_aar)/smri_vol_scs_intracranialv
gen stri_ic = (stril_ic+strir_ic)/2 	

gen dstril_ic = (smri_vol_scs_putamenlh+smri_vol_scs_caudatelh)/smri_vol_scs_intracranialv
gen dstrir_ic = (smri_vol_scs_putamenrh+smri_vol_scs_caudaterh)/smri_vol_scs_intracranialv
gen dstri_ic = (dstril_ic+dstrir_ic)/2 	

gen vstril_ic = (smri_vol_scs_aal)/smri_vol_scs_intracranialv 
gen vstrir_ic = (smri_vol_scs_aar)/smri_vol_scs_intracranialv 
gen vstri_ic = (vstril_ic+vstrir_ic)/2 	

gen dvstril_ic = (smri_vol_scs_putamenlh+smri_vol_scs_aal)/smri_vol_scs_intracranialv 
gen dvstrir_ic = (smri_vol_scs_putamenrh+smri_vol_scs_aar)/smri_vol_scs_intracranialv
gen dvstri_ic = (dvstril_ic+dvstrir_ic)/2 	

gen putamenl_ic = (smri_vol_scs_putamenlh)/smri_vol_scs_intracranialv
gen putamenr_ic = (smri_vol_scs_putamenrh)/smri_vol_scs_intracranialv
gen putamen_ic = (putamenl_ic+putamenr_ic)/2 

gen caudatel_ic = (smri_vol_scs_caudatelh)/smri_vol_scs_intracranialv
gen caudater_ic = (smri_vol_scs_caudaterh)/smri_vol_scs_intracranialv
gen caudate_ic = (caudatel_ic+caudater_ic)/2 	


global brain_cortical 		"frop_ic rmfc_ic cacc_ic morbf_ic lorbf_ic insu_ic"
*cmfc_ic racc_ic
global brain_subcortical 	"amyg_ic hippl_ic hippr_ic hipp_ic thal_ic smri_vol_scs_hpuslh smri_vol_scs_hpusrh smri_vol_scs_intracranialv"
global basal_ganglia 		"vstri_ic putamen_ic caudate_ic"


** Regression adjustments

** Sample adjustment
egen acs_raked_propensity_score_ay = max(acs_raked_propensity_score), by(subjectkey)
global weights			"acs_raked_propensity_score_ay"

**************************************************************************************
** New variables
encode subjectkey, gen(id_subj)

gen 	period = 1 if eventname=="baseline_year_1_arm_1"
*replace period = 2 if eventname=="2_year_follow_up_y_arm_1"
replace period = 2 if eventname=="1_year_follow_up_y_arm_1"
replace period = 3 if eventname=="2_year_follow_up_y_arm_1"
keep if period !=.

gen 	sex = 1 if gender=="F"
replace sex = 0 if gender=="M"

gen age = interview_age

global control_vars 	"hist_paran hist_mania hist_dprsv hist_trbl trauma_ev trauma_eva trauma_evb Trauma_ev Trauma_eva Trauma_evb Trauma_sex Trauma_osex fam_income_pc white sex age asr_scr_somatic_r internal_p thougth_p external_p famhx_ss_parent_alc_p famhx_ss_parent_dg_p fmtherh_dprsv fmtherh_mania fmtherh_paran fmtherh_trbl famhx_ss_parent_nrv_p famhx_ss_parent_prf_p famhx_ss_parent_hspd_p famhx_ss_parent_scd_p sibling asr_scr_perstr_t asr_scr_anxdep_t asr_scr_withdrawn_t asr_scr_somatic_t asr_scr_thought_t asr_scr_attention_t asr_scr_aggressive_t asr_scr_rulebreak_t asr_scr_intrusive_t asr_scr_internal_t asr_scr_external_t asr_scr_totprob_t asr_scr_depress_t asr_scr_anxdisord_t asr_scr_somaticpr_t asr_scr_avoidant_t asr_scr_adhd_t asr_scr_antisocial_t asr_scr_inattention_t asr_scr_hyperactive_t educ_lev puberty_v partner cohabit"
global elevel			"rel_family_id site_id_l"


* Keeping relevant variables
keep id_subj period $health_speccbcl $health_syndcbcl $health_syndcbclt $health_syndr $bullying_vars $family_vars $friend_vars $school_vars $nhood_vars $emoreg_vars $dsm5y_MDD $asr_depre $brain_subcortical $control_vars $elevel $weights

reshape wide $health_speccbcl $health_syndcbcl $health_syndcbclt $health_syndr $bullying_vars $family_vars $friend_vars $school_vars $nhood_vars $emoreg_vars $dsm5y_MDD $asr_depre $brain_subcortical $control_vars $elevel $weights, i(id_subj) j(period)

save "DestinationFolder\ABCD_AnalyticSample.dta", replace
