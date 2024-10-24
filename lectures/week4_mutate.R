
# Data Manipulation Part 1b ----
# Goals: learn about mutate, group_by, and summarize
library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")
str(surveys)


# Adding a new column
# mutate: adds a new column
surveys <- surveys %>%
  mutate(., weight_kg = weight/1000)

# Add other columns
surveys <- surveys %>%
  mutate(., 
         weight_kg = weight/1000,
         weight_kg2 = weight_kg*2)

str(surveys)

surveys$weight_kg2 = as.character(surveys$weight_kg2)
str(surveys)

# Filter out the NA's
ave_weight <- surveys %>% 
  filter(!is.na(weight)) %>% 
  mutate(mean_weight = mean(weight))

str(ave_weight)
nrow(ave_weight)
ave_weight$mean_weight

ave_weight <- surveys %>% 
  filter(complete.cases(.))
nrow(ave_weight)





# Group_by and summarize ----
# A lot of data manipulation requires us to split the data into groups, apply some analysis to each group, and then combine the results
# group_by and summarize functions are often used together to do this
# group_by works for columns with categorical variables 
# we can calculate mean by certain groups
df <- surveys %>%
  group_by(sex) %>%
  mutate(mean_weight = mean(weight, na.rm = TRUE)) 
table(df$mean_weight)

surveys %>%
  group_by(sex) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE)) 


# multiple groups
df <- surveys %>%
  group_by(sex, species_id) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))


# remove na's


# sort/arrange order a certain way
surveys %>%
  group_by(sex, species_id) %>%
  filter(sex !="") %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE)) %>% 
  arrange(mean_weight) #ascending

surveys %>%
  group_by(sex, species_id) %>%
  filter(sex !="") %>% 
  summarize(mean_weight = mean(weight, na.rm = TRUE)) %>% 
  arrange(-mean_weight) #descending



# Challenge
#What was the weight of the heaviest animal measured in each year? Return a table with three columns: year, weight of the heaviest animal in grams, and weight in kilograms, arranged (arrange()) in descending order, from heaviest to lightest. (This table should have 26 rows, one for each year)
heaviest <- surveys %>%
  select(., year, weight, weight_kg) %>% 
  group_by(year) %>%
  arrange(-weight)


heaviest2 <- surveys %>%
  select(., year, weight, weight_kg) %>% 
  group_by(year) %>%
  summarize(max_weight = max(weight, na.rm = TRUE),
            max_weight_kg = max(weight_kg, na.rm = T))

heaviest3 <- surveys %>%
  select(., year, record_id, weight) %>% 
  filter(!is.na(weight)) %>% 
  mutate(weight_kg = weight/1000) %>% 
  group_by(year) %>%
  summarize(max_weight_g = max(weight),
            max_weight_kg = max(weight_kg)) %>% 
  arrange()


#Try out a new function, count(). Group the data by sex and pipe the grouped data into the count() function. How could you get the same result using group_by() and summarize()? Hint: see ?n.