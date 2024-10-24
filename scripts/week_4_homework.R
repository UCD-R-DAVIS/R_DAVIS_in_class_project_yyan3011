#By now you should be in the rhythm of pulling from your git repository and then creating new homework script. This week the homework will review data manipulation in the tidyverse.

library(tidyverse)

#Create a tibble named surveys from the portal_data_joined.csv file.
surveys <- read_csv("data/portal_data_joined.csv") #read the file. "read_csv" is from tidyverse, it reads the csv file as a tibble. "read.csv" is base R, it reads the file as a data frame.
class(surveys)


#Subset surveys using Tidyverse methods to keep rows with weight between 30 and 60, and print out the first 6 rows.
surveys %>% filter(weight >30 & weight < 60)
head(surveys %>% filter(weight >30 & weight < 60))
# "head" / "tail" prints out the top/bottom 6 rows of a data frame.
# "filter" is the tidyverse method to select specific rows from a data frame.
# %>% is the "pipe" operator, it takes the output of one function (left) and pipes it into the next function (right). Here it pipes the survey data into the filter function. And the filter function filters out the rows that have weight > 30 and < 60.

#Create a new tibble showing the maximum weight for each species + sex combination and name it biggest_critters. 
biggest_critters <- surveys %>% #takes the survey data and pipes it into the next function "filter"
  filter(!is.na(weight)) %>%  #removes the rows where the weight data is NA, and pipes these rows into the next function "group_by"
  group_by(species_id, sex) %>% # groups the data by species_id and sex, and pipes the results to "summarize" 
  summarize(max_weight = max(weight)) # for each group (species_id + M; species_id + F; species_id + NA), get the maximum weight using max(weight), and store the result in a new column called "max_weight".


#Sort the tibble to take a look at the biggest and smallest species + sex combinations. HINT: it’s easier to calculate max if there are no NAs in the dataframe…

biggest_critters %>% arrange(max_weight) #arrange by max_weight, ascending
biggest_critters %>% arrange(-(max_weight)) #arrange by max_weight, descending


#Try to figure out where the NA weights are concentrated in the data- is there a particular species, taxa, plot, or whatever, where there are lots of NA values? There isn’t necessarily a right or wrong answer here, but manipulate surveys a few different ways to explore this. Maybe use tally and arrange here.

?tally # brings up the help file of tally. Basically tally counts the number of values in each group once grouping is done.

surveys %>% 
  filter(is.na(weight)) %>% #selects the rows where the weight is NA.
  group_by(species) %>% #group by species
  tally() %>% #count the number of each species. 
  arrange(desc(n)) #arrange by the number of each species, descending.
#the species "harrisi" has 437 NAs. 

surveys %>% 
  filter(is.na(weight)) %>% #selects the rows where the weight is NA.
  group_by(species_id) %>% #group by species_id
  tally() %>% #count the number of each species. 
  arrange(desc(n)) #arrange by the number of each species_id, descending.
#the species_id "AH" has 437 NAs.

surveys %>% 
  filter(is.na(weight)) %>% #selects the rows where the weight is NA.
  group_by(taxa) %>% #group by taxa
  tally() %>% #count the number of each taxa 
  arrange(desc(n)) #arrange by the number of each taxa, descending.
#the taxa "Rodent" has 1964 NAs.

surveys %>% 
  filter(is.na(weight)) %>% #selects the rows where the weight is NA.
  group_by(plot_id) %>% #group by plot_id
  tally() %>% #count the number of each plot_id 
  arrange(desc(n)) #arrange by the number of each plot_id, descending.
#the plot_id "13" has 160 NAs.


#Take surveys, remove the rows where weight is NA and add a column that contains the average weight of each species+sex combination to the full surveys dataframe. Then get rid of all the columns except for species, sex, weight, and your new average weight column. Save this tibble as surveys_avg_weight.
  
surveys_avg_weight <- surveys %>% 
  filter(!is.na(weight)) %>% #remove rows where the weight is NA. 
  group_by(species_id, sex) %>% #group by species_id and sex
  mutate(avg_weight = mean(weight)) %>% #calculate the average weight of each species_sex combination using mean(weight), and create a new column in the "survey" data frame called "avg_weight" to store that data.
  select(species_id, sex, weight, avg_weight) # select the columns by name. 
   

#Take surveys_avg_weight and add a new column called above_average that contains logical values stating whether or not a row’s weight is above average for its species+sex combination (recall the new column we made for this tibble).
surveys_avg_weight <- surveys_avg_weight %>% #pipe the result from the previous step, which is saved as a new vector called "surveys_avg_weight" into the following mutate function.
  mutate(above_average = weight > avg_weight) # "weight > avg_weight" is used to decide if a row's weight is above average for its species+sex combination. If yes, it will return the result TRUE, otherwise will return FALSE. This data is saved in a new column called above_average.
