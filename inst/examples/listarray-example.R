
# some list
l <- mapply(list, x=1:12, i=rep(1:3, 4), j=rep(1:4, each=3), SIMPLIFY = FALSE) 
# create a list array from a list
la <- list_array(l, 3, 4)  


# a list array behaves like a matrix when subsetted
la[1,1]
la[1,1] <- 999
la
la[2,1] <- list(1,2,3)  # random list
la
la[2,4] <- mtcars  # dataframe are also lists
la

# get and change dimensions
dim(la)
nrow(la)
ncol(la)
dim(la) <- c(4,3)
la

# more behavior

# list_array will recycle the list passed to it
# to fill the whole r x c array
la <- list_array(list(a=1, b=2), 3, 4)  

# objects with any class other than list are wrapped 
# into a list and the recycled
la <- list_array(mtcars, 3, 4)  
