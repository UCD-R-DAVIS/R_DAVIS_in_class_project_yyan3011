library(tidyverse)

tail <- read_csv("data/tail_length.csv")
surveys <- read_csv("data/portal_data_joined.csv")

dim(tail)
dim(surveys)
head(tail)

surveys_inner <- inner_join(x = surveys, y = tail)
dim(surveys_inner)
head(surveys_inner)

#tail <- tail[sample(1:nrow(tail), 15e3)]


all(surveys$record_id %in% tail$record_id)
all(tail$record_id %in% surveys$record_id)



surveys_left <- left_join(x = surveys, y = tail)

surveys_right <- right_join(x = surveys, y = tail)

surveys_left_right_equivilent <- left_join(x = tail, y = surveys)

surveys_full <- full_join(surveys, tail)

dim(surveys_full)

tail %>% select(-record_id) #remove the column

left_join(surveys, tail %>% select(-record_id)) #cannot join since there's no common columns in two data frames

left_join(surveys, tail %>% rename(record_id2 = record_id)) #cannot join

left_join(surveys, tail %>% rename(record_id2 = record_id), by = c('record_id' = 'record_id2')) 
#work around

#cross join


?cross_join


#pivot = change shapes. 

surveys_mz <- surveys %>% 
  filter(!is.na(weight)) %>% 
  group_by(genus, plot_id) %>% 
  summarize(mean_weight = mean(weight))

surveys_mz %>% pivot_wider(id_cols = 'genus',
                           names_from = 'plot_id', 
                           values_from = 'mean_weight')
