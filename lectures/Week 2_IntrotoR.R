3+4
2*
  4 + 8 * 3 ^ 2
4 + (8 * 3) ^ 2
4E3
4e3


exp(1)
elephant1_kg <- 3492
elephant2_lb <- 7757

elephant1_lb <- elephant1_kg * 2.2

elephant2_lb > elephant1_lb

myelephants <- c(elephant1_lb, elephant2_lb)

which(myelephants == max(myelephants))

2+2

getwd() #get working directory
setwd() #set working directory, need to put a path in the ()

d <- read.csv("./data/tail_length.csv") #relative file path: the . represents the file path to the R project folder

dir.create("./lectures")    #create a new folder in the directory

# how R thinks about data----

## Vectors----
weight_g <- c(50, 60, 65, 82)
weight_one_value <- c(50)      
animals <- c("mouse", "rat", "dog") #single quotes and double quotes don't matter most of the time. 
animals_test <- c("mouse 'name'", "rat", "dog")

## inspection -----
length(weight_g)
str(weight_g) #structure

weight_g <- c(weight_g, 90)
weight_g #print this vector

##challenge----
num_char <- c(1, 2, 3, "a") # vector needs to be the SAME class of values. choose loweset common denominator
class(num_char)

num_logical <- c(1, 2, 3, TRUE)

char_logical <- c("a", "b", "c", TRUE)

tricky <- c(1, 2, 3, "4")

combined_logical <- c(num_logical, char_logical)


## Subsetting ----
animals <- c("mouse", "rat", "dog", "cat")
animals
animals[2] #pull the second one from the vector
animals[c(2,3)] #pull the second and third item from the vector
animals[c(2,2)] # indexing: taking items from a vector and create a new combination of values

## Conditional subsetting ----
weight_g <- c(21, 34, 39, 54, 55)
weight_g > 50
weight_g[weight_g >50]

## Symbols ----
# %in%  meaning "within" a bucket
# == pairwise mathing -- ORDER MATTERS



animals %in% c("rat", "cat", "dog", "duck", "goat") #the first animal in the vector "animals" in mouse, and mouse is 
#not in this new concatenation ("rat", "cat", "dog", "duck", "goat"), so the first return value is FALSE
# just to see is it in the bucket

animals == c("rat", "cat", "dog", "duck", "goat") #compare the first with the first, second with the second, all the way down
# == means has to be matched pairwise.


