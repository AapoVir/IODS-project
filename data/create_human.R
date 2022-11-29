
#IODS course project
#Aapo Virtanen
#Assignment 4 data wranlging file

#Downloading data 

#install.packages("readr")
library(readr)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv",na = "..")
dim(hd)
#The Human development index data has 195 rows and 8 columns

dim(gii)
#The gender inequality data has 195 rows and 10 columns

library(dplyr)
library(tidyverse)

#Looking at the names of the variables in the hd data frame
names(hd)
#Original variable names: 
#"HDI Rank"                               "Country"                                "Human Development Index (HDI)"         
#"Life Expectancy at Birth"               "Expected Years of Education"            "Mean Years of Education"               
#"Gross National Income (GNI) per Capita" "GNI per Capita Rank Minus HDI Rank"    

hd<-rename(hd, GNI = "Gross National Income (GNI) per Capita", Life.Exp = "Life Expectancy at Birth", Edu.Exp = "Expected Years of Education")

names(gii)
#[1] "GII Rank"                                     "Country"                                      "Gender Inequality Index (GII)"               
#"Maternal Mortality Ratio"                     "Adolescent Birth Rate"                        "Percent Representation in Parliament"        
#"Population with Secondary Education (Female)" "Population with Secondary Education (Male)"   "Labour Force Participation Rate (Female)"    
#"Labour Force Participation Rate (Male)"  

gii<-rename(gii, Mat.Mor="Maternal Mortality Ratio", Ado.Birt="Adolescent Birth Rate", Parli.F="Percent Representation in Parliament", 
       Edu2.F="Population with Secondary Education (Female)", Edu2.M="Population with Secondary Education (Male)",Labo.F="Labour Force Participation Rate (Female)",
       Labo.M="Labour Force Participation Rate (Male)")

class(gii$Edu2.F)

#Adding new columns with mutate 
library(dplyr)
library(tidyverse)
library(scales)
gii<-mutate(gii, Edu.2FM = Edu2.F/Edu2.M, Labo.FM = Labo.F/Labo.M)

#Joining data sets
human <- inner_join(gii, hd, by = "Country", suffix = c(".gii", ".hd"))
dim(human)

#The new joined data set has 195 rows or observations and 19 columns or variables including the 2 new variables

#Saving the new data
write_csv(human, "data/human.csv")


