# IODS
# AapoVir
# 7.12.2022
# Data wranglign chapter 6

library(readr)

BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep =" ", header = T)
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", header = TRUE, sep = '\t')

dim(BPRS)
# 40 obs. of  11 variables:
str(BPRS)
# All variables are integers: treatment, subject, week0-8
names(BPRS)
#variable names: "treatment" "subject"   "week0"     "week1"     "week2"     "week3"     
#"week4"     "week5"     "week6"     "week7"    "week8"    
summary(BPRS)
# We see that two different treatments were tested. There were 20 subjects per invervetions group. The week numbers correspond 
# to the treatment effect over time.

dim(RATS)
#16 obs. of  13 variables
str(RATS)
# All variables are integers
names(RATS)
# Variable names:"ID"    "Group" "WD1"   "WD8"   "WD15"  "WD22"  "WD29"  "WD36"  "WD43"  "WD44"  "WD50"  "WD57"  "WD64" 
summary(RATS)
# There are 16 rats (IDs) divided into 3 test groups. The follow-up spanned 64 days.

#Making categorical variables to factors
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)
RATS$ID <- factor(RATS$ID)
RATS$group <- factor(RATS$group)

#Converting into log form and addin the variables 'week' (BPRS) and 'Time' (RATS).
library(dplyr)
library(tidyr)
# Convert data to long form
BPRSL <-  pivot_longer(BPRS, cols=-c(treatment,subject),names_to = "weeks",values_to = "bprs") %>% arrange(weeks)
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))


RATSL <- pivot_longer(RATS, cols = -c(ID, Group), 
                      names_to = "WD",
                      values_to = "Weight") %>% 
  mutate(Time = as.integer(substr(WD,3,4))) %>%
  arrange(Time)

#Looking at the data in long form
glimpse(BPRSL)
dim(BPRSL)
str(BPRSL)
names(BPRSL)
# The BPRSL long format is now a tibble [360 × 5] containing 5 variables and 360 observations. The new variable names are:
#"treatment" "subject"   "weeks"     "bprs"      "week" 

glimpse(RATSL)
str(RATSL)
names(RATSL)
# The RATSL has now 176 rows and 5 columns in a tibble [176 × 5]
# The new variable names are:  "ID"     "Group"  "WD"     "Weight" "Time" 
# In the long format the values of the first column are repeated for each variable on a its own row. 
# In wide format the values of all variables are displayed on the same row for each observation.
# Visualizing multiple variables in a plot using R  typically requires data to be in long format. 

