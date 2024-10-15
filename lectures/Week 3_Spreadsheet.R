?read.csv #comma seperated 

getwd()

surveys <- read.csv("data/portal_data_joined.csv")
nrow(surveys)
ncol(surveys)

#or 
file_loc <- 'data/portal_data_joined.csv'
surveys <- read.csv(file_loc)
str(surveys)

# int = integer
# chr = character

dim(surveys)

summary(surveys) #summary of every single column
?summary
summary(surveys$record_id) #summary of the column of the "record_id"

#when specify a value in a data frame, you need a row value and a column value.

surveys[1, 5] #specify the row=1 and column=5

surveys[1: 5] #first 5 rows
surveys[c(1,5,24,3001),]

surveys[, 1] #give me the first column of the surveys, it a vector, one dimension

surveys[, 1:5] #same number of rows, but only 5 columns.
dim(surveys[, 1:5])

dim(surveys[1])
surveys[c('record_id', 'year', 'day')]
dim(surveys[c('record_id', 'year', 'day')])
#function use (), indexing use []

head(surveys, 1)  # head = viewing the top the data frame, printing a subset of the dataframe

tail(surveys) #print the last 6 rows

head(surveys) #print the first 6 rows

surveys[1:6,]
surveys[1,]

head(surveys["genus"]) #subsetting the datafrome, 
head(surveys[["genus"]]) #[[ ]] getting into the internal object, the second level. get the value in the vector.

head(surveys['genus',]) #give me the row called genus, but genus is a column not the row, so return NA

head(surveys[, 'genus']) 

# $ sign
surveys$genus #$ only operate on columns not rows
class(surveys$hindfoot_length)

install.packages('tidyverse')
library(tidyverse) #tidyverse is a package of several small packages

?read_csv #vs read.csv

t_surveys <- read_csv(file_loc)
t_surveys
class(t_surveys)
