for (i in unique(surveys$taxa)){
  mytaxon <- surveys %>% filter(taxa == i)
  mytaxon$species
  myspecies <- unique(mytaxon$species)
  maxlength <- max(nchar(myspecies))
  print(mytaxon %>% filter(nchar(species) == maxlength) %>% 
    select(species) %>% unique())
  
}


#Using map_df
mloa_temp_2 <- mloa_2 %>% 
  select("temp_C_2m", "temp_C_10m", "temp_C_towertop") %>% # select the columns need to be converted
  map_df(C_to_F) %>% 
  rename("temp_F_2m" = "temp_C_2m",
         "temp_F_10m" = "temp_C_10m",
         "temp_F_towertop" = "temp_C_towertop") %>% 
  bind_cols(mloa_temp_2)# the left of "=" is the new name and the right side is the original name.

# bind_rows 

# string r

install.packages("stringr")

library(stringr)

str_replace("temp_F_2m", "_F_", "_C_")

colnames <- c("temp_F_2m", "temp_F_10m", "temp_F_towertop")
str_replace(colnames, "_F_", "_C_")



# cursor app (code editor)
# command K to pull up the text box the put instructions


claude_cloud