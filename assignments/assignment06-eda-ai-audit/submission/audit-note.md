---
title: "audit-note"
format: md
---


## Cohort


We decided to keep adults age 20-80 (inclusive) for the 
analysis. This allows us to summarize adult BMI summaries 
while avoiding children, adolescents, and extremely 
elderly records into our classroom table



## Missingness


The variables checked for missingness would be BMI, Age, 
IncomeGroup, Gender, Race, and Cycle


## Planted Issues


| Issue | Category | Why it matters | Corrected approach |
|---|---|---|---|
| analysis_df <- nhanes |> filter(Age > 20, Age < 80) |
>  | Correctness | The code 
 did not do what the prose said it would in that it 
 states that it covers all adults 20-80 INCLUSIVE. By 
 using the greater and less than signs instead of the 
 greater than or equal to and less than or equal to signs 
 they are actually excluding adults aged 20 and aged 80. 
 It is important to clearly and accurately define what 
 the code being written is explaining. | analysis_df <- 
 nhanes |> filter(Age >= 20, Age <= 80)|


|candidate_paths <- c(
 "C:/Users/analyst/Documents/nhanes_equity_v6.csv",)
  | Reproducibility | Someone would not be able to 
  reproduce this data if they did not have the file in 
  their users, analysts, documents folder | delete this 
  line of code as there are another paths already written 
  that achieve reproducibility |


| The author states statistical significance, states 
determination, and that results are complete and 
publication ready  | Interpretation | The author 
overclaims what the table reports. The table cannot show 
statistical significance due to the lack of a statistical 
test on the data and a p-value. The table cannot show 
determination/causation given that the data collected was 
not from an experimental approach that tested for 
causation, it can only show correlation. The results are 
not complete or ready to publish because they lack an 
explanation or adequate finding. | Interpretation: We 
used the prepared NHANES Health Equity classroom CSV
snapshot. The analysis cohort included records with age
20-80. We summarized BMI and age by income group using
unweighted descriptive statistics. Missing values were
checked before summarizing. These summaries describe the
prepared class dataset and should not be interpreted as
causal effects or population estimates. |


| The lack of a methods note which does not name the data 
source, access method, or the classroom-use contex| 
Stewardship | This is necessary so we can prove that the 
work respects data provenance, privacy, and classroom-use 
boundaries | We used the prepared NHANES Health Equity 
classroom CSV
Snapshot derived from public use NHANES files, for 
classroom learning only 


| table1 <- analysis_df |>
 group_by(IncomeGroup) |>
 summarise(
   N = n(),
   `BMI, mean (SD)` = sprintf("%.1f (%.1f)", mean(BMI), 
   var(BMI)),
   `Age, mean (SD)` = sprintf("%.1f (%.1f)", mean(Age), 
   var(Age)),
   .groups = "drop"
 )
 | Correctness | The code did not do what the prose said 
 it would in that it states that it would display the 
 mean with the STANDARD DEVIATION in parentheses. By 
 using the function var() they are actually displaying 
 the variation instead of the standard deviation in the 
 parentheses. It is important to clearly and accurately 
 define what the code being written is explaining.  | 
 mean_sd <- function(x) {
 sprintf("%.1f (%.1f)", mean(x, na.rm = TRUE), sd(x, na.
 rm = TRUE))
}


table1 <- analysis_df |>
   filter(!is.na(BMI) & !is.na(IncomeGroup)) |>
 group_by(IncomeGroup) |>
 summarise(
   N = n(),
   `BMI, mean (SD)` = mean_sd(BMI),
   `Age, mean (SD)` = mean_sd(Age),
   .groups = "drop"
 )
 |


## AI-Use Check

AI was not used
