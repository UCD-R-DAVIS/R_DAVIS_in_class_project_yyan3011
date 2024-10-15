# Load your survey data frame with the read.csv() function. 
surveys <- read.csv("data/portal_data_joined.csv")

# Create a new data frame called surveys_base with only the species_id, the weight, 
# and the plot_type columns. 
surveys_base <- surveys[c("species_id", "weight", "plot_type")] #select the columns by name. The other way
# to do it is selecting by the number of columns. eg. species_id is the 6th column, weight is the 9th column.
# and the plot_type is the 13th column. surveys[c(6, 9, 13)]

class(surveys_base) # check the class of the new variable "surveys_base.
str(surveys_base) # check the structure.

# Have this data frame only be the first 5,000 rows.
surveys_base <- surveys_base[1:5000,] #[,] specifies the rows and columns for indexing. left of the comma
# is the row number, right of the comma is the column number. row/column can be a range, in this case 1:5000
# which means the first 5000 rows. If we want to select the first 5000 rows and all columns, leave the right 
# side of the comma blank (But the comma needs to remain!).

#Convert both species_id and plot_type to factors. 
surveys_base$species_id <- as.factor(surveys_base$species_id) # as the converted data back into the data frame 
# (use the factor to replace the original character data)
surveys_base$plot_type <- as.factor(surveys_base$plot_type)

class(surveys_base$species_id) # check the class
class(surveys_base$plot_type) # check the class
levels(surveys_base$species_id) # check the levels
levels(surveys_base$plot_type) # check the levels

surveys_base
str(surveys_base) # check the structure

#Remove all rows where there is an NA in the weight column. 
surveys_base <- surveys_base[!is.na(surveys_base$weight), ] # left of the comma defines the rows to be indexed.
#!is.na(surveys_base$weight) means indexing the rows where there is not an NA in the weight column (removes the rows with an NA).

# Explore these variables and try to explain why a factor is different from a character. 
# Why might we want to use factors? Can you think of any examples?

# Factors look a lot like 1-dimensional character vectors, however, characters are just string of text without numeric 
# values attached to them, while factors are actually integer vectors with character labels attached to them.

# Factors may be useful for categorical data. For example, if we have a column for plant coverage of residential front yards,
# and the data contains three categories: low, medium, and high. This column can be converted to a factor, which
# assigns 3 levels to the data. We can then use the three levels for further analysis, such as running regression
# models to assess the correlation between different levels of plant coverage and water consumption/household income...

# CHALLENGE: Create a second data frame called challenge_base that only consists of 
# individuals from your surveys_base data frame with weights greater than 150g.

challenge_base <- surveys_base[surveys_base$weight > 150,]
challenge_base

