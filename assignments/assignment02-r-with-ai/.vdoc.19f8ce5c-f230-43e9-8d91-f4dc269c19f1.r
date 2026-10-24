#
#
#
#
#
#
#
#
install.packages("tidyverse")
#
#
#
#
#| message: false
#| warning: false
library(tidyverse)  # AI-EDIT(2026-06-23): tidyverse-default — consolidated core library() calls into library(tidyverse)
#
#
#
#
#
nhanes <- read_csv("examples/nhanes-equity/data/nhanes_equity_v6.csv", show_col_types = FALSE)
#
#
#
#
#
# How big is it? 
dim(nhanes) # rows x columns
names(nhanes) # What are the column names and types
glimpse(nhanes) # Quick summary statisitics 
colSums(is.na(nhanes)) # How much is missing?

# What I see is that there are 105,626 rows and 18 columns with most of the columns having at least some missing values. The columns with the amount of missing values are shown below  
# Cycle            BMI         Weight         Height          Waist 
#   0           9356           1690           8888          12737 
#     WeightMEC         Strata            PSU         Gender           Race 
#          0              0              0              0              0 
#     Education        Marital            Age            PIR EducationClean 
#         47251          46961              0           9415          47251 
#  MaritalClean    IncomeGroup           WHtR 
#         46961           9415          12979 

```
#
#
#
#
#
#
#
#
#

nhanes <- nhanes %>%
  mutate(Age = case_when(
    Age < 18 ~ "Child",
    Age >= 18 & Age < 65 ~ "Adult",
    Age >= 65 ~ "Senior",
    TRUE ~ NA_character_
  ))



bmi_by_age_summary <- nhanes |>
  filter(!is.na(BMI), !is.na(Age)) |>
  group_by(Age) |>
  summarise(
    n = n(),
    mean_bmi = mean(BMI),
    .groups = "drop"
  )


bmi_by_age_summary 
# AI was asked to explain an 
# error message in which the 
# prompt was: "Could you 
# explain this cell I am 
# working on and the error 
# message Error: unexpected 
# symbol in:
"
bmi_by_age_summary""


#
#
#
#
#
#
coefficient_of_variation <- function(x) {
  n <- sum(!is.na(x))
  mean_x <- mean(x, na.rm = TRUE)
  sd_x <- sd(x, na.rm = TRUE)

  cv <- if (is.na(mean_x) || mean_x == 0) NA_real_ else sd_x / mean_x

#It means:
#is.na(mean_x) checks whether
#the mean couldn’t be 
#calculated, for example 
#because there were no 
#non-missing values.
#mean_x == 0 checks whether 
#the mean is zero, which would 
#make sd_x / mean_x a division 
#by zero.
#|| means “or”: if either 
#condition is true, use 
#NA_real_.
#Otherwise, calculate the 
#coefficient of variation
#as sd_x / mean_x.
#NA_real_ is R’s missing value 
#specifically for numeric 
#results, so cv remains 
#numeric.

  tibble(
    n = n,
    mean = mean_x,
    sd = sd_x,
    cv = cv
  )
}
#Coeffcient of variation for BMI
coefficient_of_variation(nhanes$BMI)
#
#Coefficient of variation for Weight
coefficient_of_variation(nhanes$Weight)
#
#
#
#
#
dir.create("assignments/assignment02-r-with-ai/submission/output", recursive = TRUE, showWarnings = FALSE)
write_csv(bmi_by_age_summary, "assignments/assignment02-r-with-ai/submission/output/summary_table.csv")
#
#
#
#
#
#
#
#
