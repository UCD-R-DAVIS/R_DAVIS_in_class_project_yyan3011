# Question 1 ----
# Create a tibble named surveys from the portal_data_joined.csv file. 

library(tidyverse) #load tidyverse package
surveys <- read_csv("data/portal_data_joined.csv") #create a new tibble called surveys. The surveys data is imported the csv file. 

#Then manipulate surveys to create a new dataframe called surveys_wide with a column for genus and a column named after every plot type, with each of these columns containing the mean hindfoot length of animals in that plot type and genus. 

surveys_long <- surveys %>%  # create a new dateframe called surveys_long. The original data is in a long format. We can work with the long format and then pivot it into the wide format.
  filter(!is.na(hindfoot_length)) %>%  # remove NA values in the hindfoot_lenghth column, so the mean value can be calculated
  group_by(genus, plot_type) %>% # Group by genus and plot_type
  summarize(mean_hindfoot_length = mean(hindfoot_length)) #summarize to calculate mean hindfoot lenghth for each genus+plot type combination.

surveys_long #print the new datafram "surveys_long"
str(surveys_long) #check the structure of the new dataframe
unique(surveys_long$plot_type) #check the unique values in the plot_type column of the new dataframe.

#So every row has a genus and then a mean hindfoot length value for every plot type. The dataframe should be sorted by values in the Control plot type column. This question will involve quite a few of the functions you’ve used so far, and it may be useful to sketch out the steps to get to the final result.

# convert the new dataframe "surveys_long" to a wide format.

# The "surveys_long" dataframe has three column: genus, plot_type, and mean_hindfoot_length. There are 5 plot types. Each genus has some of the plot types, and each plot type for a certain genus is saved in its own row (so one genus has multiple rows depending on the plot type it has.).

# The question asks us to convert the long dataframe into a wide one, where each of the unique plot type becomes its own column, and each genus will have just one row and the change. At the intersection of each genus and plot_type, the value of mean_hindfoot_length for that genus and plot_type combination is show. Therefore in the pivot_wide command, names_from should be the plot_type, values_from should be mean_hindfoot_length.  

surveys_wide <- surveys_long %>% 
  pivot_wider(names_from = plot_type, values_from = mean_hindfoot_length) %>% # convert the long datagframe to wide dataframe.
  arrange(Control) # arrange the dataframe by the values in the "Control" column
                                  
# Question 2 ----
# Using the original surveys dataframe, use the two different functions we laid out for conditional statements, ifelse() and case_when(), to calculate a new weight category variable called weight_cat. 
# For this variable, define the rodent weight into three categories, where “small” is less than or equal to the 1st quartile of weight distribution, “medium” is between (but not inclusive) the 1st and 3rd quartile, and “large” is any weight greater than or equal to the 3rd quartile.
# (Hint: the summary() function on a column summarizes the distribution). For ifelse() and case_when(), compare what happens to the weight values of NA, depending on how you specify your arguments.

# get the weight distribution
summary(surveys$weight)

# Using ifelse()
surveys$weight_cat <- ifelse(surveys$weight <= 20.00, yes = "small", #first define the category for small, it is for the weight less than or equal to the 1st quartile, which is 20.00
                             ifelse(surveys$weight >= 48.00, yes = "large", no = "medium")) #then define the category for large, it is for the weight greater than or equal to the 3rd quartile, which is 48. And the rest are medium.

# When using ifelse(), if the weight is NA, then it is still stored as NA in the weight_cat column.


# Using case_when().
# The new column will be saved with the name weight_cat_cw to differiate from the column created using ifelse() function.
surveys<- surveys %>% 
  mutate(weight_cat_cw =case_when(weight <= 20.00 ~ "small", 
                                  weight >= 48.00 ~ "large",
                                  weight < 48.00 & weight > 20.00 ~ "medium"))

# Using the case_when() functions, since the last condition defines the medium as weight between 20 and 48, all NA values are not captured. However, if the last condition says T ~ "medium", it will catch everything left from the previous condition, therefore NAs will be categorized as medium.


# Bonus ----
# How might you soft code the values (i.e. not type them in manually) of the 1st and 3rd quartile into your conditional statements in question 2?

# using the quantile() to calculate the 1st and 3rd quantile values.
surveys<- surveys %>% 
  mutate(weight_cat_cw_2 =case_when(weight <= quantile(weight, 0.25, na.rm = TRUE ) ~ "small", 
                                  weight >= quantile(weight, 0.75, na.rm = TRUE) ~ "large",
                                  weight < quantile(weight, 0.75, na.rm = TRUE) & weight > quantile(weight, 0.25, na.rm = TRUE) ~ "medium"))

