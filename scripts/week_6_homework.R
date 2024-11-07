#For our week six homework, we are going to be practicing the skills we learned with ggplot during class. You will be happy to know that we are going to be using a brand new data set called gapminder. This data set is looking at statistics for a few different counties including population, GDP per capita, and life expectancy. Download the data using the code below. Remember, this code is looking for a folder called data to put the .csv in, so make sure you have a folder named data, or modify the code to the correct folder name.

library(tidyverse)

gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv") #ONLY change the "data" part of this path if necessary

# Question 1----

# First calculates mean life expectancy on each continent. Then create a plot that shows how life expectancy has changed over time in each continent. Try to do this all in one step using pipes! (aka, try not to create intermediate dataframes)

gapminder %>% 
  group_by(continent, year) %>% #group by continent and year so the mean life expectancy could be calculated for each continent in a certain year.
  mutate(mean_lifeExp = mean(lifeExp, na.rm = TRUE)) %>% # calculate the mean life expectancy and save it in a new column called mean_life_exp
  ggplot(aes(x = year, y = mean_lifeExp, color = continent)) + #use ggplot to plot the graph. x is the year, y is the calculated mean life expectancy from the last step, and color by continent ensures every continent gets its own line showing the change over years.
  geom_point()+ # points to represent the mean life expectancy for each continent of each year.
  geom_line() # lines to connect the point data for each continent to show the overall trend.

# Question 2----
# Look at the following code and answer the following questions. What do you think the scale_x_log10() line of code is achieving? What about the geom_smooth() line of code?
  
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()  

# In order to know what scale_x_log10 does, we can run the code without scale_x_log10()
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw()  

# Comparing the two plots (with and without scale_x_log10), the differences on the x-axis can be seen. In the plot generated without "scale_x_log10", the x-axis showing the originonal range of GDP per capita from 0 to 90000+, but the points are clustered on the lowered end (left side), mostly between 0 and 30000, and only very few point are on the ride side. The "scale_x_log10" takes the log of the x-axis, making the difference between the higher GPD per capita and lower GPD per capita not that big. log10(30000) is about 4.477, log10(60000) is about 4.778, and log10(90000) is about 4.954. Using the logarithmic values therefore spreads out the data points across the x-axis, making more room to show the points that are clustered on the left side and generates a better visualization of the data. 

# In order to know what geom_smooth does, we can also run the code without it.
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent), size = .25) + 
  scale_x_log10() +
  theme_bw()  

# Comparing the plots generated with and without the geom_smooth() code, the difference is that geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') adds a line based on the requirement specified in the () - black dashed line showing the linear regression result of the data. This line helps viewer understand the overall relationship between GDP per capita and life expectancy.

# Challenge! ----
# Modify the above code to size the points in proportion to the population of the country. Hint: Are you translating data to a visual feature of the plot?

ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, size = pop)) + # the population data of each country could be used to determine the size that represents each country.
  scale_x_log10() +
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') +
  theme_bw() 

# Question 3----
# Create a boxplot that shows the life expectency for Brazil, China, El Salvador, Niger, and the United States, with the data points in the backgroud using geom_jitter. Label the X and Y axis with “Country” and “Life Expectancy” and title the plot “Life Expectancy of Five Countries”.

gapminder %>% 
  filter(country%in%c("Brazil", "China", "El Salvador", "Niger", "United States")) %>% 
  ggplot(aes(x = country, y = lifeExp))+
  geom_jitter(alpha = 0.2) +
  geom_boxplot(alpha = 0.5) +
  labs(x = "Country",
       y = "Life Expectancy",
       title = "Life Expectancy of Five Countries")
