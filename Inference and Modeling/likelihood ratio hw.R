head(esoph)
library(tidyverse)

# Filter for the lowest alcohol consumption group
lowest_alcohol_group <- esoph[esoph$alcgp == "0-39g/day", ]  # This is the lowest group in the dataset

# Calculate total subjects in this group
total_subjects <- sum(lowest_alcohol_group$ncases + lowest_alcohol_group$ncontrols)

# Calculate number of cancer cases
cancer_cases <- sum(lowest_alcohol_group$ncases)

# Calculate probability
probability <- cancer_cases / total_subjects
print(probability)

# Total number of cancer cases
total_cases <- sum(esoph$ncases)

# Cancer cases in smoking groups with 10g/day or more
cases_smoke_10plus <- sum(esoph$ncases[esoph$tobgp %in% c("10-19", "20-29", "30+")])

# Conditional probability
probability <- cases_smoke_10plus / total_cases
print(probability)

# Total number of controls
total_controls <- sum(esoph$ncontrols)

# Controls in smoking groups of 10g or more per day
controls_smoke_10plus <- sum(esoph$ncontrols[esoph$tobgp %in% c("10-19", "20-29", "30+")])

# Conditional probability
probability <- controls_smoke_10plus / total_controls


print(probability)

# Total number of cancer cases
total_cases <- sum(esoph$ncases)

# Cancer cases in the highest alcohol consumption group ("120+")
cases_highest_alcohol <- sum(esoph$ncases[esoph$alcgp == "120+"])

# Conditional probability
probability <- cases_highest_alcohol / total_cases
print(probability)



# Total number of cancer cases
total_cases <- sum(esoph$ncases)

# Cancer cases in both the highest alcohol and highest tobacco group
cases_highest_both <- sum(esoph$ncases[esoph$alcgp == "120+" & esoph$tobgp == "30+"])

# Conditional probability
probability <- cases_highest_both / total_cases
print(probability)


# Total number of cancer cases
total_cases <- sum(esoph$ncases)

# Number of cases in the highest alcohol group
cases_highest_alc <- sum(esoph$ncases[esoph$alcgp == "120+"])

# Number of cases in the highest tobacco group
cases_highest_tob <- sum(esoph$ncases[esoph$tobgp == "30+"])

# Number of cases in both highest alcohol and highest tobacco group
cases_both <- sum(esoph$ncases[esoph$alcgp == "120+" & esoph$tobgp == "30+"])

# Conditional probability using inclusion-exclusion
probability <- (cases_highest_alc + cases_highest_tob - cases_both) / total_cases
print(probability)

highest_alcohol_group <- esoph[esoph$alcgp == "120+", ]
total_subjects <- sum(highest_alcohol_group$ncases + highest_alcohol_group$ncontrols)
cancer_cases <- sum(highest_alcohol_group$ncontrols)
probability <- cancer_cases/total_subjects
print(probability)

# Total number of control subjects
total_controls <- sum(esoph$ncontrols)

# Controls in the highest alcohol consumption group
controls_highest_alcohol <- sum(esoph$ncontrols[esoph$alcgp == "120+"])

# Conditional probability
probability <- controls_highest_alcohol / total_controls
print(probability)

# Total number of cases and controls
total_cases <- sum(esoph$ncases)
total_controls <- sum(esoph$ncontrols)

# Number of cases and controls in the highest alcohol group
cases_highest_alc <- sum(esoph$ncases[esoph$alcgp == "120+"])
controls_highest_alc <- sum(esoph$ncontrols[esoph$alcgp == "120+"])

# Probabilities
prob_case_highest_alc <- cases_highest_alc / total_cases
prob_control_highest_alc <- controls_highest_alc / total_controls

# Likelihood ratio
likelihood_ratio <- prob_case_highest_alc / prob_control_highest_alc
print(likelihood_ratio)

# Total number of control subjects
total_controls <- sum(esoph$ncontrols)

# Number of controls in the highest tobacco group
controls_highest_tob <- sum(esoph$ncontrols[esoph$tobgp == "30+"])

# Conditional probability
probability <- controls_highest_tob / total_controls
print(probability)

