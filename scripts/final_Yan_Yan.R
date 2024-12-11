library(tidyverse)

# Question 1 ----
# Read in the file tyler_activity_laps_12-6.csv from the class github page. This file is at url https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv, so you can code that url value as a string object in R and call read_csv() on that object. The file is a .csv file where each row is a “lap” from an activity Tyler tracked with his watch.

data <- read.csv("https://raw.githubusercontent.com/UCD-R-DAVIS/R-DAVIS/refs/heads/main/data/tyler_activity_laps_12-6.csv")

# Question 2----
# Filter out any non-running activities.

data <- data %>% 
  filter(sport == "running") # in the "sport" column, activities are labeled as running, cycling..., and only running activities need to be kept.

# Question 3----
# We are interested in normal running. You can assume that any lap with a pace above 10 minutes_per_mile pace is walking, so remove those laps. You should also remove any abnormally fast laps (< 5 minute_per_mile pace) and abnormally short records where the total elapsed time is one minute or less.

data <- data %>% 
  filter(minutes_per_mile <= 10, # remove laps that have a pace >10 minutes/mile means keep the laps with a pace >= 10 minutes/mile.
         minutes_per_mile >=5, # remove any abnormally fast laps (< 5 minute_per_mile pace) means keep those >=5 minute/mile
         total_elapsed_time_s > 60) # remove short records (total elapsed time <= 1 minute) means keep those > 60 seconds.

# Question 4----
# Group observations into three time periods corresponding to pre-2024 running, Tyler’s initial rehab efforts from January to June of this year, and activities from July to the present.

class(data$timestamp)

library(lubridate)
data <- data %>% 
  mutate(timestamp_2 = ymd_hms(timestamp)) # the original "timestamp" column in the data has character values. ymd_hms function in lubridate converts it into a date-time object.

data <- data %>% 
  mutate(time_period = case_when( # create a new column "time_period" that specify the time period the lap belongs to.
    timestamp_2 < ymd("2024-01-01") ~ "pre-2024",
    timestamp_2 <= ymd("2024-6-30") & timestamp_2 >= ymd("2024-01-01") ~ "Jan to June 2024 (initial rehab)",
    timestamp_2 >= ymd("2024-07-01") ~ "July 2024 to present"
  )) %>% 
  group_by(time_period)

# Question 5----
# Make a scatter plot that graphs SPM over speed by lap.

# calculate the speed (total_distance_m/total_elapsed_time_s)
data <- data %>% 
  mutate(speed_mps = total_distance_m/total_elapsed_time_s)

# make the plot
library(ggplot2)
ggplot(data, aes(x = speed_mps, y = steps_per_minute))+
  geom_point()
  
# Question 6 ----
# Make 5 aesthetic changes to the plot to improve the visual.
ggplot(data, aes(x = speed_mps, y = steps_per_minute, color = time_period))+ # 1. color the points by time_period 
  geom_point(size = 1, alpha = 0.75)+ # 2. change the size and transparency of the points.
  theme_bw()+ # 3. change the theme to black and white
  xlab("Speed (Miles Per Second)")+
  ylab("Steps Per Minute (SPM)")+
  ggtitle("Relationship Between Cadence and Speed")+ # 4. add title and name x-axis and y-axis.
  theme(plot.title = element_text(hjust = 0.5, face = "bold", color = "Navy" ),
        legend.position = "bottom") # 5. put the title in the center, change the text size, font, and color. Move the legend to the bottom.


# Question 7----
# Add linear (i.e., straight) trendlines to the plot to show the relationship between speed and SPM for each of the three time periods (hint: you might want to check out the options for geom_smooth())

unique(data$time_period)

data %>% 
  filter(!is.na(time_period)) %>% # remove rows when time_period = NA
  ggplot(aes(x = speed_mps, y = steps_per_minute, color = time_period))+
  geom_point(size = 1, alpha = 0.75)+ 
  geom_smooth(method = 'lm', aes(group = time_period), color = "black", linetype = 'dashed')+ # add the trendlines. group = time_period ensures that there are spearate treadlines for each time_period.
  theme_bw()+
  xlab("Speed (Miles Per Second)")+ 
  ylab("Steps Per Minute (SPM)")+
  ggtitle("Relationship Between Cadence and Speed")+
  theme(plot.title = element_text(hjust = 0.5, face = "bold", color = "Navy" ),
        legend.position = "bottom")

# Question 8----
# Does this relationship maintain or break down as Tyler gets tired? Focus just on post-intervention runs (after July 1, 2024). Make a plot (of your choosing) that shows SPM vs. speed by lap. Use the timestamp indicator to assign lap numbers, assuming that all laps on a given day correspond to the same run (hint: check out the rank() function). Select only laps 1-3 (Tyler never runs more than three miles these days). Make a plot that shows SPM, speed, and lap number (pick a visualization that you think best shows these three variables).


  


