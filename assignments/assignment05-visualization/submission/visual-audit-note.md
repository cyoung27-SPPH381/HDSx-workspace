# Visual Audit Note

## Plot Question

How does BMI relate to income groups, and how does this relationship change over time?

## Issues Checked

 Issue 1: the draft used "scale_y_continuous
 (limits = c(24, 28)
 Category: Design
 Why it matters: scaling of the
 y-axis is between 24 and 28, BMI which does
 not start at 0, exagerating the differences
 between the groups. The y-axis should start 
 at 0 for a fair comparison. 
 Correction: replace the scale_y_continuous 
 with expand_limits(y = 0) allowing the 
 y axis to start at 0. 

 Issue 2: title = "Low income drives rising 
 obesity in American adults",
 subtitle = "Adults age 20-80: BMI climbed 
 steadily across every NHANES cycle",
 Category: Interpretation
 Why it matters: the title and subtitle of the plot
 creates a claim that the plot cannot support. This
 claim being that low income DRIVES RISING obesity 
 in American adults. This plot does not show causation
 nor does it accurately show a tread of rising obesity. 
 Without error bars, more data points, or some way 
 to show statistical significance, the plot cannot 
 support the claims made in the title and subtitle. 
 Correction: change the title to " Average BMI for 
 Varying Income Groups from 1999-2023, NHANES Health
 Equity classroom dataset" and change the subtitle to 
 " Adults age 20-80 in the prepared class dataset; 
 unweighted descriptive summary." The caption should 
 contain something similar ""Records with missing BMI,
 income, or cycle excluded; groups under n = 30 removed.
 \nDescriptive only, not a causal or population estimate.""

 Issue 3: flawed_summary <- nhanes |>
  filter(!is.na(BMI), !is.na(IncomeGroup), Cycle %in% endpoint_cycles) |>
  group_by(Cycle, IncomeGroup) |>
  summarise(
    mean_bmi = mean(BMI),
    .groups = "drop"
  )
 Category: Bias and aggregation:
 Why it matters: Because the data is aggregated to only show 
 the first and last cycles, it does not show the trend of BMI
 over time. This can lead to misinterpretation of the data as
 it does not provide a complete picture of how BMI has changed 
 across all cycles.
 Correction: delete the filter for endpoint_cycles and 
 instead group by all cycles to show the trend over time. 
 "flawed_summary <- nhanes |>
  filter(!is.na(BMI), !is.na(IncomeGroup)) |>
  group_by(Cycle, IncomeGroup) |>
  summarise(
    mean_bmi = mean(BMI),
    .groups = "drop"
  )"


## Final Caption

This figure shows BMI by income group across yearly cycles 
using the prepared NHANES Health Equity classroom dataset. 
The summary is descriptive and unweighted. Records with 
missing BMI or Income classes were excluded. The plot 
supports comparison of patterns, not causal claims or 
population-level estimates.


## AI-Use Check

AI helped with how to correct the code in Issue 3. 
AI prompt: "For this last issue 3, please help me determine
how to fix the filtering of flawed_summary (lines 26-32) 
so that instead of grouping by endpoint_cycles, the summary
will inclue and group by all cycles. The final graph should
have 3 data points (each of the income classes) for each 
of the cycle dates."
Verified: Used previous assignments and the Week03 page to 
check to see if the filter code setup by AI was accurate 
and would not produce errors. 


