#learning dplyr and tidyr: select, filter, and pipes
#only do this once ever:
#install.packages(
  #We've learned bracket subsetting
  #It can be hard to read and prone to error
  #dplyr is great for data table manipulation!
  #tidyr helps you switch between data formats
  
  #Packages in R are collections of additional functions
  #tidyverse is an "umbrella package" that
  #includes several packages we'll use this quarter:
  #tidyr, dplyr, ggplot2, tibble, etc.
  
  #benefits of tidyverse
  #1. Predictable results (base R functionality can vary by data type) 
  #2. Good for new learners, because syntax is consistent. 
  #3. Avoids hidden arguments and default settings of base R functions
  
  #To load the package type:
  library(tidyverse)
    #now let's work with a survey dataset
    surveys <- read_csv("data/portal_data_joined.csv")
      
      
      str(surveys)
        
        
        
        
        
        
        
        
        
        #select columns (select certain columns)
        month_day_year <- select(surveys, month, day, year)
          str(month_day_year)
          length(month_day_year) #3
          
          #filtering by equals (filter is for choosing certain rows)
          year_1981 <- filter(surveys, year == 1981)
          str(year_1981)
          sum(year_1981$year !=1981, na.rm = T)  
          year_1981_baser <- surveys[surveys$year == 1981, ] # $is the baser way, "filter" is the tidyverse function.
          length(year_1981_baser)
          length(year_1981)
          
          
            #filtering by range
          the80s <- surveys[surveys$year %in% 1981:1983, ]
          the80tidy <- filter(surveys, year %in% 1981:1983)
                   #5033 results
                   
                   
                   #review: why should you NEVER do:
                  the80srecycle <-  filter(surveys, year == c(1981:1983)) # == used here to filter will not give you the same result as using 
                                           # %in%. 
                 the80snotrecycle <-  filter(surveys, year %in%c(1981:1983))  
                      
                  
                          #1685 results
                          
                          #This recycles the vector 
                          #(index-matching, not bucket-matching)
                          #If you ever really need to do that for some reason,
                          #comment it ~very~ clearly and explain why you're 
                          #recycling!
                          
                          #filtering by multiple conditions
                          bigfoot_with_weight <- filter(surveys, hindfoot
                                                        
                                                        #multi-step process
                                                        small_animals <- filter(surveys, weight < 5) #intermediate variables. 
                                                                                #this is slightly dangerous because you have to remember 
                                                                                #to select from small_animals, not surveys in the next step
                                                                                small_animal_ids <- select(small_animals, record_id, plot_id, species_id)
                                                                                                           
                                                                                                           #same process, using nested functions
                                                                                                           small_animal_ids <- select(filter(surveys, weight <5), 
                                                                                                                                      record_id, plot_id, species_id)
                                                                                                             
                                                                                                             #same process, using a pipe
                                                                                                             #Cmd Shift M "%>%" 
                                                                                                             #or |>
                                                                                                             #note our select function no longer explicitly calls the tibble
                                                                                                             #as its first element
                                                                                                             small_animal_ids <- filter(surveys, weight < 5) %>% 
                                                                                                               select(
                                                                                                                 small_animal_ids <- surveys %>% filter(., weight <5)
                                                                                                                 # surveys get sent to where the . is.
                                                                                                                 small_animal_ids <- surveys %>% filter(., weight <5) %>% 
                                                                                                                 select(., record_id, plot_id, species_id) 
                                                                                                                 
                                                                                                                 
                                                                                                                    
                                                                                                                 #same as
                                                                                                              
                                                                                                                   
                                                                                                                   
                                                                                                                   
                                                                                                                   #how to do line breaks with pipes
                                                                                                                   surveys %>% filter(
                                                                                                                     
                                                                                                                     #good:
                                                                                                                     surveys %>% 
                                                                                                                       filter(month==1)
                                                                                                                     
                                                                                                                     #not good:
                                                                                                                     surveys 
                                                                                                                     %>% filter(month==1)
                                                                                                                     #what happened here?
                                                                                                                     
                                                                                                                     #line break rules: after open parenthesis, pipe,
                                                                                                                     #commas, 
                                                                                                                     #or anything that shows the line is not complete yet
                                                                                                                     
                                                                                                                     
                                                                                                                     
                                                                                                                     
                                                                                                                     #check out cute_rodent_photos!
                                                                                                                     #will be updated throughout the quarter
                                                                                                                     #as a bonus for checking out these videos
                                                                                                                     #and visiting the code demos on my repository
                                                                                                                     
                                                                                                                     
                                                                                                                     #one final review of an important concept we learned last week
                                                                                                                     #applied to the tidyverse
                                                                                                                     
                                                                                                                     mini <- surveys[190:209,]
                                                                                                                     table(mini$species_id)
                                                                                                                     #how many rows have a species ID that's either DM or NL?
                                                                                                                     nrow(mini)

                                                                                                                    test <-  mini %>% filter(species_id == c("DM", 'NL')) 
                                                                                                                    nrow(test)
                                                                                                                  
                                                                                                                    test2 <-  mini %>% filter(species_id %in% c("DM", 'NL')) 
                                                                                                                    nrow(test2)
                                                                                                                     
                                                                                                                     
                                                                                                                     
                                                                                                                     
                                                                                                                     
                                                                                                                     
                                                                                                                     
                                                                                                                     
                                                                                                                     
                                                                                                                     
                                                                                                                     