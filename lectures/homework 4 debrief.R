library(tidyverse)
surveys <- read_csv("data/portal_data_joined.csv")

#part 2
#weight between 30 and 60
surveys %>% filter(weight >30 & weight < 60) %>% head(n = 5)

surveys %>% filter(weight %in% 30:60) %>% head() #%in% is inclusive


#part 3a
#new tibble showing max weight for each species + sex combination
biggest_critters_1 <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(species_id, sex) %>% #creates groups for each combination
  summarize(max_weight = max(weight))


#part 3b
#arrange 
biggest_critters_1 %>% arrange(max_weight) %>% head()
biggest_critters_1 %>% arrange(desc(max_weight)) %>% head()

#part 4
surveys %>% filter(is.na(weight)) %>% group_by(species) %>% tally() %>% arrange(-n)

#part 5
#remove na weight
#new column = avg weight of species+sex combination
surveys %>% filter(!is.na(weight)) %>% group_by(species_id, sex) %>% mutate(avg_weight = mean(weight))

#get rid of all columns except species, sex, weight, and avg_weight
surveys_avg_weight <- surveys %>% filter(!is.na(weight)) %>% group_by(species_id, sex) %>% mutate(avg_weight = mean(weight)) %>% select(species_id, sex, weight, avg_weight)

#how would we make a summary table?
surveys_mini <- surveys %>% filter(!is.na(weight)) %>% group_by(species_id, sex) %>% 
  summarize(avg_weight = mean(weight))

surveys_mini

#add more summary columns 
surveys_mini <- surveys %>% filter(!is.na(weight)) %>% group_by(species_id, sex) %>% 
  summarize(avg_weight = mean(weight), max_weight = max(weight))

surveys_mini


#part 6
#take surveys_avg_weight
#add new column
#called above_average

surveys_avg_weight %>% mutate(above_average = weight > avg_weight)
