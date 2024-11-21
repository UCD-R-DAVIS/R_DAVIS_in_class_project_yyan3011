library(tidyverse)
library(lubridate)


mloa <- read_csv("https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/main/data/mauna_loa_met_2001_minute.csv")


# In what time zone the data are reported?----

# The "readme" file says "Field 2:    [YEAR] The sample collection date and time in UTC." Therefore the data was reported in the UTC time zone.

unique(mloa$siteID)
# all the entries in the data frame "mloa" were collected at the site MLO. Below is the information about the station MLO:
# Country: United States Country Flag
# Latitude: 19.5362° North
# Longitude: 155.5763° West
# Elevation: 3397.00 masl
# Time Zone: Local Standard Time + 10.0 hour(s) = UTC



# How missing values are reported in each column?----
# Missing values for Field 6:    [WIND DIRECTION] are denoted by -999;
# Missing values for Field 7:    [WIND SPEED] are denoted by -999.9;
# Missing values for Field 8:    [WIND STEADINESS FACTOR] are denoted by -9;
# Missing values for Field 9:    [BAROMETRIC PRESSURE] are denoted by -999.90;
# Missing values for Field 10:    [TEMPERATURE at 2 Meters] are denoted by -999.9;
# Missing values for Field 11:    [TEMPERATURE at 10 Meters] are denoted by -999.9;
# Missing values for Field 12:    [TEMPERATURE at Tower Top] are denoted by -999.9;
# Missing values for Field 13:    [RELATIVE HUMIDITY] are denoted by -99;
# Missing values for Field 14:    [PRECIPITATION INTENSITY] are denoted by -99;



# With the mloa data.frame, remove observations with missing values in rel_humid, temp_C_2m, and windSpeed_m_s.
mloa_no_NA <- mloa %>% 
  filter(rel_humid != -99, temp_C_2m != -999.9, windSpeed_m_s != -999.9)

# Generate a column called “datetime” using the year, month, day, hour24, and min columns----
mloa_no_NA$datetime <- paste(mloa_no_NA$year, "-", 
                             mloa_no_NA$month, "-", 
                             mloa_no_NA$day, ", ", mloa_no_NA$hour24, ":",
                             mloa_no_NA$min, sep = "")

glimpse(mloa_no_NA)
# year, month, day, hour24 and min are dbl(numeric), but when pasted together, the column datetime is character. Need to have character value before convert the column into a date column.

mloa_no_NA$datetime_UTC <- ymd_hm(mloa_no_NA$datetime, 
                               tz = "UTC")

mloa_no_NA$datetime_UTC_test <- ymd_hm(as.character(mloa_no_NA$datetime), 
                                  tz = "UTC")
# Next, create a column called “datetimeLocal” that converts the datetime column to Pacific/Honolulu time (HINT: look at the lubridate function called with_tz()). ----

mloa_no_NA$datetimeLocal <- with_tz(mloa_no_NA$datetime_UTC, tz = "Pacific/Honolulu")



# Then, use dplyr to calculate the mean hourly temperature each month using the temp_C_2m column and the datetimeLocal columns. (HINT: Look at the lubridate functions called month() and hour()). ----
mloa_no_NA$localMonth <- month(mloa_no_NA$datetimeLocal, label = TRUE) # label = TRUE tells R to label the months using Jan, Feb, Mar... instead of 1, 2, 3... (numeric)
mloa_no_NA$localHour <- hour(mloa_no_NA$datetimeLocal)

mloa_no_NA_mean_temp <- mloa_no_NA %>% 
  group_by(localMonth, localHour) %>% 
  summarize(meanTemp = mean(temp_C_2m))

# Finally, make a ggplot scatterplot of the mean monthly temperature, with points colored by local hour.----
glimpse(mloa_no_NA_mean_temp)

ggplot(data = mloa_no_NA_mean_temp, aes(x = localMonth, y = meanTemp, color = localHour))+
  geom_point()+
  scale_color_viridis_c(option = "A")+ #scale_color_viridis_c is the color palette for continuous data.The localHour is integer, R treats numeric data as continuous. 
  theme_bw()
?scale_color_viridis_b
# Put all the steps together without creating the intermediate variables
localTime_mloa <- mloa %>% 
  filter(rel_humid != -99, temp_C_2m != -999.9, windSpeed_m_s != -999.9) %>% # remove NAs
  mutate(datetime = ymd_hm(paste(year, "-", 
                        month, "-", 
                       day, ", ", hour24, ":",
                     min, sep = ""), tz = "UTC"), # create the datetime column by pasting year, month, day, hour24 and min together, and convert this column into "date" using lubridate ymd_hm function.
         datetimeLocal = with_tz(datetime, tz="Pacific/Honolulu")) %>%  # create the datetimeLocal column by convert the timezone from UTC to Pacific/Honolulu
  mutate(localMonth = month(datetimeLocal, label = TRUE), # extract month the hour from the datetimeLocal column, label = TRUE means label the month using Jan, Feb... instead of numberic 1, 2, 3...
         localHour = hour(datetimeLocal)) %>% 
  group_by(localMonth, localHour) %>% 
  summarize(meanTemp = mean(temp_C_2m)) %>% # calculate the mean temperature
  ggplot(aes(x = localMonth, y = meanTemp, color = localHour))+
  geom_point()+ 
  scale_color_viridis_c(option = "A")+ #scale_color_viridis_c is the color palette for continuous data.The localHour is integer, R treats numeric data as continuous. Option A changes the colors.  
  theme_bw()+
  ggtitle("Mean Hourly Temperature in Each Month")+
  xlab("Month")+
  ylab("Mean Temperature in Celsius")

print(localTime_mloa)



