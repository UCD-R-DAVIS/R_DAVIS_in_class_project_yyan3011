library (tidyverse)

surveys <- read.csv("data/portal_data_joined.csv")

# 1. Using a for loop, print to the console the longest species name of each taxon. Hint: the function nchar() gets you the number of characters in a string.----


unique (surveys$taxa) # check how many taxon are there.

for (i in unique(surveys$taxa)){
  each_taxon <- surveys[surveys$taxa == i,] %>% # select the rows for each species. 
    select(taxa, species) # select the columns needed
  longest_name <- each_taxon %>% 
    mutate(name_length = nchar(species)) %>% # calculate the number of characters in each species name.
    filter(name_length == max(name_length)) # get the species name that is the longest
  print(paste0("The longest species name(s) among", " ", i, "s is/are"))
  print(unique(longest_name$species)) # print the unique longest names for each species.
}


mloa <- read_csv("https://raw.githubusercontent.com/ucd-cepb/R-DAVIS/master/data/mauna_loa_met_2001_minute.csv")

# 2. Use the map function from purrr to print the max of each of the following columns: “windDir”,“windSpeed_m_s”,“baro_hPa”,“temp_C_2m”,“temp_C_10m”,“temp_C_towertop”,“rel_humid”,and “precip_intens_mm_hr”.----

mloa_2 <- mloa %>% 
  select("windDir", "windSpeed_m_s", "baro_hPa", "temp_C_2m", "temp_C_10m", "temp_C_towertop", "rel_humid", "precip_intens_mm_hr") # select the columns needed
mloa_2 %>% map_dbl(max) # print the max of each selected column, as doubles.

# 3. Make a function called C_to_F that converts Celsius to Fahrenheit. Hint: first you need to multiply the Celsius temperature by 1.8, then add 32. Make three new columns called “temp_F_2m”, “temp_F_10m”, and “temp_F_towertop” by applying this function to columns “temp_C_2m”, “temp_C_10m”, and “temp_C_towertop”. Bonus: can you do this by using map_df? Don’t forget to name your new columns “temp_F…” and not “temp_C…”!----

C_to_F <- function (x){
  x * 1.8 + 32
}

#Using "mutate"
mloa_temp <- mloa_2 %>% 
  mutate(temp_F_2m = C_to_F(temp_C_2m),
         temp_F_10m = C_to_F(temp_C_10m),
         temp_F_towertop = C_to_F(temp_C_towertop))

?map_df
#Using map_df
mloa_temp_2 <- mloa_2 %>% 
  select("temp_C_2m", "temp_C_10m", "temp_C_towertop") %>% # select the columns need to be converted
  map_df(C_to_F) %>% 
  rename("temp_F_2m" = "temp_C_2m",
         "temp_F_10m" = "temp_C_10m",
         "temp_F_towertop" = "temp_C_towertop") # the left of "=" is the new name and the right side is the original name.

# Challenge: Use lapply to create a new column of the surveys dataframe that includes the genus and species name together as one string.
?lapply
# lapply returns a list of the same length as X, each element of which is the result of applying FUN to the corresponding element of X.
surveys$genus_species <- lapply(1:nrow(surveys), #iterate over the rows in "surveys"
                                function(i){ # for each row, apply the function
                                  paste0(surveys$genus[i], " ", surveys$species[i]) # the function is paste the genus and species column together
                                })
  
