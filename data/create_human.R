
#IODS course project
#Aapo Virtanen
#Assignment 4 data wranlging file

#Downloading data 

install.packages("readr")
library(readr)
library(dplyr)
library(tidyverse)
library(scales)
hd <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/human_development.csv")
gii <- read_csv("https://raw.githubusercontent.com/KimmoVehkalahti/Helsinki-Open-Data-Science/master/datasets/gender_inequality.csv",na = "..")
hd<-rename(hd, GNI = "Gross National Income (GNI) per Capita", Life.Exp = "Life Expectancy at Birth", 
           Edu.Exp = "Expected Years of Education")
gii<-rename(gii, Mat.Mor="Maternal Mortality Ratio", Ado.Birth="Adolescent Birth Rate", 
            Parli.F="Percent Representation in Parliament", 
       Edu2.F="Population with Secondary Education (Female)", Edu2.M="Population with Secondary Education (Male)",
       Labo.F="Labour Force Participation Rate (Female)",
       Labo.M="Labour Force Participation Rate (Male)")
gii<-mutate(gii, Edu2.FM = Edu2.F/Edu2.M, Labo.FM = Labo.F/Labo.M)
#Joining data sets
human <- inner_join(gii, hd, by = "Country", suffix = c(".gii", ".hd"))
dim(human)
#The  joined data  has 195 rows or observations and 19 columns 
#Transform the Gross National Income (GNI) variable to numeric (using string manipulation). 
human$GNI<-as.numeric(human$GNI)
#Exclude unneeded variables:
keep <- c("Country", "Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")
human <- select(human, one_of(keep))
#Remove all rows with missing values.
human<-na.omit(human)
#Remove the observations which relate to regions instead of countries
last<-tail(human)
last <- nrow(human) - 7
human <- human[1:last,]
#Define the row names of the data by the country names and remove the country name column from the data. 
human<-as.data.frame(human)
rownames(human) <- human$Country
human<- select(human, -Country)
#str(human)
#View(human)
write_csv(human, "data/human.csv")

