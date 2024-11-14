# For week 7, we’re going to be working on 2 critical ggplot skills: recreating a graph from a dataset and googling stuff.

library(tidyverse)
library(ggplot2)

# 1. To get the population difference between 2002 and 2007 for each country, it would probably be easiest to have a country in each row and a column for 2002 population and a column for 2007 population.

gapminder <- read_csv("https://ucd-r-davis.github.io/R-DAVIS/data/gapminder.csv") #bring in the data

pg <- gapminder %>% 
  select(country, year, pop, continent) %>% 
  filter(year > 2000) %>% 
  pivot_wider(names_from = year, values_from = pop)
  #mutate(pop_change_0207 = `2007` - `2002`)

pop_2002_2007 <- gapminder %>% 
  select(country, year, pop, continent) %>% 
  filter(year == 2002 | year == 2007) %>% 
  pivot_wider(names_from = "year", values_from = "pop") %>% 
  mutate(pop_change = `2007` - `2002`) # "2007" is treated as a character string, not a column name. For non-standard column names like '2007', using `2007` is correct for referring to a column named 2007 (the button on the left of "1")


# 2. Notice the order of countries within each facet. You’ll have to look up how to order them in this way.

# the countries are grouped by continent and then are ordered alphabetically.

unique(pop_2002_2007$continent) 
# check what continents are included in the data frame. There are five continents: Asia, Europe, Africa, Americas, and Oceania, but there are only four facets, four the four continents Asia, Europe, Africa, and Americas, respectively.


# 3. Also look at how the axes are different for each facet. Try looking through ?facet_wrap to see if you can figure this one out.
?facet_wrap

# The x-axis of the plots goes from the country with lease population change to the most population change. So I tried to order the data frame by the value of the pop_change column.
pop_2002_2007 %>% 
  filter(continent != "Oceania") %>% 
  arrange(pop_change) %>% # arrange the data frame by the value of pop_change, ascending.
  print()

# However, when trying to make the plot using the code below, the order of the x-axis is still alphabetical, not reflecting the order by pop_change.
pop_2002_2007 %>% 
  filter(continent != "Oceania") %>% 
  arrange(pop_change) %>%
  ggplot(aes(x = country, y = pop_change))+
  geom_col()+
  facet_wrap(~continent)

# When using ggplot2, the order of the x-axis isn't automatically determined by the order of the rows in the data frame, unless you explicitly set the factor levels of the column used for the x-axis, in this case the country column. 

pop_2002_2007 %>% 
  filter(continent != "Oceania") %>% 
  arrange(pop_change) %>%
  mutate(country = factor(country, levels = unique(country))) %>% 
  ggplot(aes(x = country, y = pop_change))+
  geom_col()+
  facet_wrap(~continent)

# Now the x-axis goes from the countries with lease to most pop change. But there are different numbers of countries in each continent, so we can to adjust the size of columns that represent each individual countries to make the plot look better.
# The y-axis of each plot are the same. However, the pop_change in each continent have huge differences, using the same scale for y-axis does not effectively represent the data. For continents where countries have relatively small pop changes, these values only occupy a small portion of the y-axis, making it hard to read. It is necessary to adjust the scale of y-axis for each facet. 

pop_2002_2007 %>% 
  filter(continent != "Oceania") %>% 
  arrange(pop_change) %>%
  mutate(country = factor(country, levels = unique(country))) %>% 
  ggplot(aes(x = country, y = pop_change))+
  geom_col(aes(fill = continent))+ # color the columns in each continent differently.
  facet_wrap(~continent, scale = "free") # scale = "free" sets both the x-axis and y-axis free for each facet, so they can be tailored to the data it displays. Using "free_x" or "free_y" to free only x or y axis.


# 4. The color scale is different from the default- feel free to try out other color scales, just don’t use the defaults!
pop_2002_2007 %>% 
  filter(continent != "Oceania") %>% 
  arrange(pop_change) %>%
  mutate(country = factor(country, levels = unique(country))) %>% 
  ggplot(aes(x = country, y = pop_change))+
  geom_col(aes(fill = continent))+ # color the columns in each continent differently.
  facet_wrap(~continent, scale = "free")+
  scale_fill_viridis_d() #change the default color palette. _d suffix in scale_fill_viridis_d() indicates that it's intended for discrete data.

display.brewer.all()

pop_2002_2007 %>% 
  filter(continent != "Oceania") %>% 
  arrange(pop_change) %>%
  mutate(country = factor(country, levels = unique(country))) %>% 
  ggplot(aes(x = country, y = pop_change))+
  geom_col(aes(fill = continent))+ # color the columns in each continent differently.
  facet_wrap(~continent, scale = "free")+
  scale_fill_brewer(palette = "Set1") #try another color palette from the RColorBrewer Palettes.

# 5. The theme here is different from the default in a few ways, again, feel free to play around with other non-default themes.

pop_2002_2007 %>% 
  filter(continent != "Oceania") %>% 
  arrange(pop_change) %>%
  mutate(country = factor(country, levels = unique(country))) %>% 
  ggplot(aes(x = country, y = pop_change))+
  geom_col(aes(fill = continent))+ # color the columns in each continent differently.
  facet_wrap(~continent, scale = "free")+
  scale_fill_brewer(palette = "Set1")+
  theme_bw() # change the default theme.

pop_2002_2007 %>% 
  filter(continent != "Oceania") %>% 
  arrange(pop_change) %>%
  mutate(country = factor(country, levels = unique(country))) %>% 
  ggplot(aes(x = country, y = pop_change))+
  geom_col(aes(fill = continent))+ # color the columns in each continent differently.
  facet_wrap(~continent, scale = "free")+
  scale_fill_brewer(palette = "Set1")+
  theme_minimal() # try another theme.

# 6. The axis labels are rotated! Here’s a hint: angle = 45, hjust = 1. It’s up to you (and Google) to figure out where this code goes!

pop_2002_2007 %>% 
  filter(continent != "Oceania") %>% 
  arrange(pop_change) %>%
  mutate(country = factor(country, levels = unique(country))) %>% 
  ggplot(aes(x = country, y = pop_change))+
  geom_col(aes(fill = continent))+
  facet_wrap(~continent, scale = "free")+
  scale_fill_brewer(palette = "Set1")+
  theme_bw()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) # adjust the labels on x-axis. hjust = 1 means the labels are right aligned with tick marks.

# 7. Is there a legend on this plot?
pop_2002_2007 %>% 
  filter(continent != "Oceania") %>% 
  arrange(pop_change) %>%
  mutate(country = factor(country, levels = unique(country))) %>% 
  ggplot(aes(x = country, y = pop_change))+
  geom_col(aes(fill = continent))+
  facet_wrap(~continent, scale = "free")+
  scale_fill_brewer(palette = "Set1")+
  theme_bw()+
  theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none")+ #remove the legend
  xlab("Country")+
  ylab("Change in Population Between 2002 and 2007")

  
# From the answers: instead of using mutate to modify the country column and make it a factor with level, use reorder when specifying the aesthetics in ggplot.
  
pop_2002_2007 %>% 
    filter(continent != "Oceania") %>% 
    ggplot(aes(x = reorder(country, pop_change), y = pop_change))+ # reorder the x-axis based on the population change, so the plot will display the x-axis as countries from least to most population changes.
    geom_col(aes(fill = continent))+
    facet_wrap(~continent, scale = "free")+
    scale_fill_brewer(palette = "Set1")+
    theme_bw()+
    theme(axis.text.x = element_text(angle = 45, hjust = 1), legend.position = "none")+ #remove the legend
    xlab("Country")+
    ylab("Change in Population Between 2002 and 2007")



