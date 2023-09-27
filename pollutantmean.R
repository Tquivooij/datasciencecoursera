#####################################################################
# Data Science Specialization
# Tim Quivooij
# programming  ssignment 1 instructions air pollution
# function pollutantmean
#####################################################################

pollutantmean <- function(directory, pollutant, id = 1:332) {
## directory is a character vector of length 1 indicating
## the location of the CSV files

## pollutant is a character vetor of length 1 indicating
## the name of the pollutant for which we will calculate the mean
## either "sulfate" of "nitrate"

## id is an integer vectory indicating the monitoring ID numbers to be used  
## return the mean of the pollutant across all monitors list in the 'id' vector
## (ignoring NA values)
  
# list of all filenames in the diractory
list.filenames <- list.files(directory, pattern="*.csv")

#numercia list that stores all values, useful to determine the median
list.values <- numeric()

for(i in c(id) ) {

    #Determine full path an file name
    filename <- paste(directory, list.filenames[i], sep = "/")
 ##  filename <- paste("specdata", list.filenames[1], sep = "/")
    
    #load the file contents
  df.File <- read.csv(filename, head=TRUE, sep=",")
  

    #filter by sulfate or nitrate
    if(pollutant == "sulfate"){
      values <- df.File$sulfate[!is.na(df.File$sulfate)]
    }
    else{
      values <- df.File$nitrate[!is.na(df.File$nitrate)]
    }

    #It contains all values for each interaction
    list.values <- append(list.values, values)
  }
  #calculation of the mean
  return(mean(list.values))

}
