set.seed(15) 
# R has a random number generator. It will generate numbers randomly based on the given criteria.
# But to ensure reproducibility, set.seed can be used to set the starting point for the random number generator, 
# so it will give you the same numbers every time you run the code.

hw2 <- runif(50, 4, 50) # Define a vector called "hw2". This vector contains 50 numbers from 4 to 50.

hw2 <- replace(hw2, c(4,12,22,27), NA) # modifies the vector "hw2" that was defined by the previous line of code.
# replaces the 4th, 12th, 22nd, and 27th numbers in the original "hw2" vector with "NA".

hw2 #print the current vector "hw2".

## Question 1 ----
# Take your hw2 vector and removed all the NAs then select all the numbers between 14 and 38 inclusive, 
# call this vector prob1.

hw2_na_removed <- na.omit(hw2) #na.omit is the function that removes all "NAs" in a vector. 
# "hw2_na_removed" is a new vector defined as the vector "hw2" with all NAs removed.

# code from the answer key: prob1 <- hw2[!is.na(hw2)] 
# is.na function checks each number in "hw2" to see if it is an "NA". 
# "!" means NOT. !is.na(hw2) returns the numbers that are not NA in "hw2".


prob1 <- hw2_na_removed[c(hw2_na_removed>=14 & hw2_na_removed<=38)]
# the [] subsets the vector hw2_na_removed. The subset contains numbers in "hw2_na_removed" that are between 14 and 38 inclusive.
# the subset is called "prob1".

prob1 #print "prob1"

## Question 2 ----
# Multiply each number in the prob1 vector by 3 to create a new vector called times3. 
# Then add 10 to each number in your times3 vector to create a new vector called plus10.

times3 <- prob1 * 3 
times3

plus10 <- times3 + 10
plus10

## Question 3----
# Select every other number in your plus10 vector by selecting the first number, not the second, the third, not the fourth, etc. 

every_other <- plus10[c(TRUE, FALSE)] # The c(TRUE, FALSE) logical vector is recycled through the length of the plus10 vector. 
# The first number in the "plus10" vector is associated with TRUE, the second with FALSE, the third with TRUE, the fourth with FALSE, and so on. 
# As a result, this line of code concatenates all the numbers in "plus10" that are associated with TRUE, which are the every other number 
# starting from the first one.

every_other






