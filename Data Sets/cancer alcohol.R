head(esoph)
library(tidyverse)

unique_groups <- length(unique(esoph$agegp))  # Assuming you're referring to the 'agegp' group
print(unique_groups)

num_cases <- nrow(esoph)
print(num_cases)

head(esoph, 100)

sum_ncases <- sum(esoph$ncases)
print(sum_ncases)

sum_ncontrols <- sum(esoph$ncontrols)
print(sum_ncontrols)

# Filter the dataset for the highest alcohol consumption group
highest_alcohol_group <- esoph[esoph$alcgp == "120+", ]  # Assuming "120+" is the highest group

# Calculate the total number of subjects in the highest alcohol consumption group
total_subjects <- sum(highest_alcohol_group$ncases + highest_alcohol_group$ncontrols)

# Calculate the number of cancer cases (ncases) in the highest alcohol consumption group
cancer_cases <- sum(highest_alcohol_group$ncases)

# Calculate the probability of a subject being a cancer case in this group
probability <- cancer_cases / total_subjects
print(probability)

lowest_alcohol_group <- esoph[esoph$alcgp == "0-39", ]
total_subjects1 <- sum(lowest_alcohol_group$ncases + lowest_alcohol_group$ncontrols)
cancer_cases1 <- sum(lowest_alcohol_group$ncases)
probability <- cancer_cases1 / total_subjects1
print(probability)

# Filter for the lowest alcohol consumption group
lowest_alcohol_group <- esoph[esoph$alcgp == "0-39g/day", ]  # This is the lowest group in the dataset

# Calculate total subjects in this group
total_subjects <- sum(lowest_alcohol_group$ncases + lowest_alcohol_group$ncontrols)

# Calculate number of cancer cases
cancer_cases <- sum(lowest_alcohol_group$ncases)

# Calculate probability
probability <- cancer_cases / total_subjects
print(probability)

# Total number of control subjects
total_controls <- sum(esoph$ncontrols)

# Number of controls in the highest tobacco group
controls_highest_tob <- sum(esoph$ncontrols[esoph$tobgp == "30+"])

# Conditional probability
probability <- controls_highest_tob / total_controls
print(probability)

# Total number of control subjects
total_controls <- sum(esoph$ncontrols)

# Number of controls in both highest alcohol and tobacco groups
controls_both_highest <- sum(esoph$ncontrols[esoph$alcgp == "120+" & esoph$tobgp == "30+"])

# Conditional probability
probability <- controls_both_highest / total_controls
print(probability)


# Total number of control subjects
total_controls <- sum(esoph$ncontrols)

# Number of controls in the highest alcohol group
controls_highest_alc <- sum(esoph$ncontrols[esoph$alcgp == "120+"])

# Number of controls in the highest tobacco group
controls_highest_tob <- sum(esoph$ncontrols[esoph$tobgp == "30+"])

# Number of controls in both the highest alcohol and tobacco groups
controls_both <- sum(esoph$ncontrols[esoph$alcgp == "120+" & esoph$tobgp == "30+"])

# Conditional probability using inclusion-exclusion
probability <- (controls_highest_alc + controls_highest_tob - controls_both) / total_controls
print(probability)

# Total number of cancer cases and controls
total_cases <- sum(esoph$ncases)
total_controls <- sum(esoph$ncontrols)

# Number of cases in the highest alcohol group or highest tobacco group
cases_highest_alc_or_tob <- sum(esoph$ncases[esoph$alcgp == "120+" | esoph$tobgp == "30+"])

# Number of controls in the highest alcohol group or highest tobacco group
controls_highest_alc_or_tob <- sum(esoph$ncontrols[esoph$alcgp == "120+" | esoph$tobgp == "30+"])

# Conditional probabilities
prob_case_highest_alc_or_tob <- cases_highest_alc_or_tob / total_cases
prob_control_highest_alc_or_tob <- controls_highest_alc_or_tob / total_controls

# Likelihood ratio
likelihood_ratio <- prob_case_highest_alc_or_tob / prob_control_highest_alc_or_tob
print(likelihood_ratio)

