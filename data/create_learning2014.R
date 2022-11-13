#IODS course project
#Aapo Virtanen
#Assignment 2 data wranlging file

#Downloading data 
lrn14 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", sep="\t", header=TRUE)
dim(lrn14)
#The dimensions of the data are 183 observations and 60 variables.

str(lrn14)
# The structure shows that each variable is given values from 0 to 5.

#Creating additional combination variables 
lrn14$attitude <- lrn14$Attitude / 10
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D06",  "D15", "D23", "D31")
lrn14$deep <- rowMeans(lrn14[, deep_questions])
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
lrn14$surf <- rowMeans(lrn14[, surface_questions])
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")
lrn14$stra <- rowMeans(lrn14[, strategic_questions])

#Alternative1 - Creating a data set with the variables gender, age, attitude, deep, stra, surf and points
lrn14 %>% dplyr::select(gender, Age, attitude, deep, stra, surf, Points)

#Alternative2 - Creating a data set with the variables gender, age, attitude, deep, stra, surf and points
keep_columns <- c("gender","Age","attitude", "deep", "stra", "surf", "Points")

#Naming the new data set
learning2014 <- select(lrn14, one_of(keep_columns))

#Changing all column names to lower case
colnames(learning2014)[2] <- "age"
colnames(learning2014)[7] <- "points"

#Excluding observations where the exam points variable is zero
learning2014 <- filter(learning2014, points > 0)

#Checking that the dimensions of the new data set match the assignment
dim(learning2014)

#Saving the data
write_csv(learning2014,"data/learning2014.csv") 

#Reading the data
read_csv("data/learning2014.csv") 

#Making sure that the structure of the data is correct
str("data/learning2014.csv")
head("data/learning2014.csv")
