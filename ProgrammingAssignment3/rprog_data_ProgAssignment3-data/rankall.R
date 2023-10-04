####################
# 
# Programming assignment 3 
# function rankall - 
#
#####################


rankall <- function(outcome, num = "best") {
  ## read the outcome data
   outcome_data <- read.csv("outcome-of-care-measures.csv")
   states <- unique(outcome_data$State)
   states <- sort(states)
#   outcome = "heart attack"
#   num = "worst"   
   
   # change outcome to lowercase
   outcome <- tolower(outcome)

  ## check that the state and rank are valid
   if (!outcome %in% c("heart attack", "heart failure", "pneumonia")){
     stop("invalid outcome")
   }
   if(is.numeric(num) & num<= nrow(outcome_data)){
     rank <- num
   } else if (num == "worst"){
     rank <- nrow(outcome_data)
   } else if (num == "best") {
     rank <- 1
   } else {
     stop("invalid number")
   }
  
  ## return hospital name in that state with lowest 30-day death
  
  if (outcome == "heart attack") {
    rate <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack" # 11 
  } else if (outcome == "heart failure"){
    rate <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure" # 17
  } else {
    rate <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia" # 23
  }




# simplify the output to only three columns, state, name and chosen rate  
outcome_data_short <- data.frame(as.character(outcome_data[,7]),as.character(outcome_data[,2]), as.numeric(outcome_data[,rate]))

# outcome_data_short <- data.frame(as.character(outcome_data[,7]),as.character(outcome_data[,2]), as.numeric(outcome_data[,11]))

   
# remove NA values and short thee dataframe
outcome_data_short <- na.omit(outcome_data_short)
outcome_data_short <- outcome_data_short [order(outcome_data_short [,3], outcome_data_short [,3], na.last = NA),]
outcome_data_short <- outcome_data_short [order(outcome_data_short [,1], outcome_data_short [,1], na.last = NA),]

   
# order by column 2       
# the best

result <- vector()
if (num == "best") {
  for (i in 1:length(states)){
  #  print(states[i])
    order_data <- subset(outcome_data_short, outcome_data_short$as.character.outcome_data...7.. == states[i])
    result <- append(result, c(order_data[rank, 2], states[i]))
  }
  }
if (num=="worst") {
  for (i in 1:length(states)){
    #  print(states[i])
    order_data <- subset(outcome_data_short, outcome_data_short$as.character.outcome_data...7.. == states[i])
    rank <- nrow(order_data)    
    result <- append(result, c(order_data[rank, 2], states[i]))
  }
  
} else {
  for (i in 1:length(states)){
    #  print(states[i])
    order_data <- subset(outcome_data_short, outcome_data_short$as.character.outcome_data...7.. == states[i])
    result <- append(result, c(order_data[rank, 2], states[i]))
  }
  
}


#  order_data <- data.frame(1:nrow(order_data), order_data)
  
  
# return names   
return(result)

}