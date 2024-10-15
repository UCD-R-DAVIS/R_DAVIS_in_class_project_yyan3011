set.seed(15)
hw2 <- runif(50, 4, 50)
hw2 <- replace(hw2, c(4,12,22,27), NA)

hw2[!is.na(hw2)]

!is.na(hw2)
na.omit(hw2)
hw2[complete.cases(hw2)]

prob1 <- hw2[!is.na(hw2) & hw2 >= 14 & hw2 <= 38]
prob1

hw2[c(14:38)] #just looking at the 14th to 38th values. Index value


## vector math ----
times3 <- prob1 * 3
plus10 <- times3 + 10
plus10


str(plus10)

a <- cbind(hw2, hw2, hw2 + hw2)
class(a)

cbind(hw2, plus10, hw2 + plus10)

mean(hw2) # returns NA cause there's NA in hw2
mean(hw2, na.rm = T) # calculate mean of hw2 with NA removed 

final <- plus10[c(T, F)] #only uppercase TRUE is recognized as a logical value. Samething for NA.
final

final[c(true, false)] 


## Other data types ----

### Lists----
c(4, 6, "dog") #coerced 4 and 6 as characters/strings
a <- list(4, 6, "dog") #list won't coerce, it will store each value as vector
class(a)
str(a)

### data.frames----
letters
data.frame(letters)
df <- data.frame(letters)
length(df)
dim(df) #dimension: rows, columns
nrow(df) #number of rows

as.data.frame(t(df)) #transpose?

## factors----
#character values with some order in them
animals <- factor(c("duck", "duck", "goose", "goose"))
animals #the first level is duck and the second level is goose, based on alphabetics

animals2 <- factor(c("pig", "duck", "goose", "goose"))
animals2

class(animals)
levels(animals)
levels(animals2)
nlevels(animals)

# if you want to change the order 
animals2 <- factor(x = animals2, levels = c("goose", "pig", "duck")) #use tab to see what functions are available
animals2

year <- factor(c(1978, 1980, 1934, 1979))
year
class(year)
#convert to numeric
as.numeric(year) #the numbers represent the levels
levels(year)


as.numeric(animals)
as.character(animals) 

year <- as.numeric(as.character(year)) #loose the order information
year
