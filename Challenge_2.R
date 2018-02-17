library(readr)
library(dplyr)

# Load data sets
pydemo <- read_csv('Physician_Compare_National_Downloadable_File.csv')
perfbyclin <- read_csv('Physician_Compare_2015_Individual_EP_Public_Reporting___Performance_Scores.csv')
pqrsperfbygroup <- read_csv('Physician_Compare_2015_Group_Public_Reporting___Performance_Scores.csv')
cahpsperfbygroup <- read_csv('Physician_Compare_2015_Group_Public_Reporting_-_Patient_Experience.csv')

pydemo$NPI <- as.character(pydemo$NPI)
colnames(pydemo)[2] <- 'PAC_ID'
colnames(pydemo)[11] <- 'Graduation_year'
colnames(pqrsperfbygroup)[2] <- 'Group_PAC_ID'
colnames(cahpsperfbygroup)[2] <- 'Group_PAC_ID'
colnames(perfbyclin)[8] <- 'Measure_Performance_Rate'

# Count distinct NPI & PAC_ID pairs; check for equality
ind_NPI <- n_distinct(pydemo['NPI'])
ind_PAC <- n_distinct(pydemo['PAC_ID'])
ind_NPI == ind_PAC

# Create a list of just NPI & PAC_IDs
clinicians <- select(pydemo, NPI, PAC_ID)
# Filter for only unique combinations
distinct_clinicians <- distinct(clinicians)

# Look for duplicate NPIs
duplicate_NPI <- distinct_clinicians %>% group_by(NPI) %>% filter(n()>1)
# Create list of duplicate NPIs
duplicate_NPI_list <- distinct(ungroup(duplicate_NPI['NPI']))
# Print list of names which contain multiple PAC_IDs but one NPI
pydemo_errors <- semi_join(pydemo, duplicate_NPI_list, by='NPI') %>% select(1:8) %>% print(n=23)

# Look for duplicate PAC_IDs; none found
duplicate_PAC <- distinct_clinicians %>% group_by(PAC_ID) %>% filter(n()>1)

# Create a list of unique NPIs
unique_clinicians <- select(pydemo, NPI, Gender, Credential) %>% distinct()
# Calculate ratio male to female clinicians
MF_ratio <- sum(unique_clinicians['Gender'] == 'M') / sum(unique_clinicians['Gender'] == 'F')

# Remove clinicians with no listed credential
clinicians_cred <-  pydemo %>% select(NPI, Credential, Gender) %>% filter(!is.na(pydemo$Credential)) %>% distinct()
clinicians_cred %>% group_by(Credential) %>% summarise(FM_ratio = sum(Gender == 'F') / sum(Gender == 'M')) %>% arrange(desc(FM_ratio))

# Sum healthcare facilities by state
pqrsperfbygroup %>% bind_rows(cahpsperfbygroup) %>% select(1:3) %>% distinct() %>% group_by(State) %>% summarise(State_total = sum(!is.na(State))) %>% arrange(State_total)

# Measure performance by clinician
perf_meas <- perfbyclin %>% group_by(NPI) %>% summarise(Total_rates = sum(!is.na(Measure_Performance_Rate)), Avg_Perf = mean(Measure_Performance_Rate)) %>% filter(Total_rates >= 10)
perf_meas$NPI <- as.character(perf_meas$NPI)
perf_meas_sd <- sd(perf_meas$Avg_Perf)

# Compare clinician performance to graduation year
grad_years <- perf_meas %>% left_join(pydemo, by='NPI') %>% select(NPI, Avg_Perf, Graduation_year) %>% filter(Graduation_year >= 1973 & Graduation_year <= 2003) %>% distinct() %>% group_by(Graduation_year) %>% summarise(Avg_Perf_year = mean(Avg_Perf))
plot(grad_years$Graduation_year, grad_years$Avg_Perf_year)
fit = lm(grad_years$Avg_Perf_year ~ grad_years$Graduation_year)
summary(fit)

# Compare average performance of MD vs. NP
perf_creds <- perf_meas %>% left_join(pydemo, by='NPI') %>% select(NPI, Avg_Perf, Credential) %>% distinct() %>% filter(Credential == 'MD' | Credential == 'NP') %>% group_by(Credential) %>% summarise(Avg_Perf_cred = mean(Avg_Perf))
Avg_perf_diff <- perf_creds$Avg_Perf_cred[1] - perf_creds$Avg_Perf_cred[2]

# Compute two tailed p-value of the difference in MD and NP performance rates
perf_creds_MD <- perf_meas %>% left_join(pydemo, by='NPI') %>% select(NPI, Avg_Perf, Credential) %>% distinct() %>% filter(Credential == 'MD')
perf_creds_NP <- perf_meas %>% left_join(pydemo, by='NPI') %>% select(NPI, Avg_Perf, Credential) %>% distinct() %>% filter(Credential == 'NP')
t.test(perf_creds_MD$Avg_Perf, perf_creds_NP$Avg_Perf)


