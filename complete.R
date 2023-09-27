#####################################################################
# Data Science Specialization
# Tim Quivooij
# programming assignment 1 instructions air pollution
#####################################################################

complete  <- function(directory, id = 1:332) {
## directory is a character vector of length 1 indicating
## the location of the CSV files
  
## id is an integer vector indicating the monitor ID numbers
## to be used

## return a data frame of the form:
## id nobs
## 1 117
## 2 1041
## 3 ..
## where id is the monitor id number and nobs is the number
## of complete cases

#We store all file names
list.filenames <- list.files(directory, pattern="*.csv")


  nr <- c()
  nobs <- c()
  
  for(i in c(id) ) {
    #file name processing
    filename <- paste(directory, list.filenames[i], sep = "/")

    #load the file contents
    df.File <- read.csv(filename, head=TRUE, sep=",")
    # id is monitor id number of the file
    nr <- c(nr, as.integer(substring(list.filenames[i], 0, 3)))
    # nobs uses na.omit to remove all unnecessary data
    nobs <- c(nobs, nrow(na.omit(df.File)))
  }
return(data.frame(nr=nr, nobs=nobs))
}
