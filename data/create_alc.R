My name is Aapo. This is a data wrangling R script related to course assignment 3.
create_alc.R

#Reading data files
math <- read.csv("data/student-mat.csv", sep=";", header = TRUE)

por <- read.csv("data/student-por.csv", sep=";", header = TRUE)

#Exploring the dimensions and structure of the data "data/student-mat.csv"
dim(math)
# there are 395 rows and 33 columns in the data 
# Explore the  structure of the data
str(math)
#Show the first 6 rows of the data
head(math)
#Show the summary of the variables and their characteristics
summary(math)

#Exploring the dimensions the data "data/student-por.csv"
dim(por)
# there are 649 rows and 33 columns in the data 
# Explore the  structure of the data
str(por)
#Show the first 6 rows of the data
head(por)
#Show the summary of the variables and their characteristics
summary(por)

#Joining datasets
# access the dplyr package
library(dplyr)

# give the columns that vary in the two data sets
free_cols <-c("failures", "paid", "absences", "G1", "G2", "G3")
free_cols

# the rest of the columns are common identifiers used for joining the data sets
join_cols <- setdiff(colnames(por), free_cols)

# join the two data sets by the selected identifiers
math_por <- inner_join(math, por, by = join_cols)

# look at the column names of the joined data set
names(math_por)


# glimpse at the joined data set
glimpse(math_por)
dim(math_por)

#create a new data frame of the joined data with only the joined columns
alc <- select(math_por, all_of(join_cols))
glimpse(alc)

#Get rid of the duplicate records in the joined data set

for(col_name in free_cols) {
  two_cols <- select(math_por, starts_with(col_name))
  first_col <- select(two_cols, 1)[[1]]
  if(is.numeric(first_col)) {
    alc[col_name] <- round(rowMeans(two_cols))
  } else {
    alc[col_name] <- first_col
  }
}


# define a new column alc_use by combining weekday and weekend alcohol use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

#create logical column for high alcohol use with 2 as cutoff 
alc <- mutate(alc, high_use = if_else(alc_use > 2,TRUE,FALSE))

#glimpse the data
glimpse(alc)
#Rows: 370
#Columns: 35

#write csv-file
write_csv(alc,"data/alc.csv") 
