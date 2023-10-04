####################
# 
# Programming assignment 3 
# function rankhospital - 
#
#####################


rankhospital <- function(state, outcome, num = "best") {
  ## read the outcome data
   outcome_data <- read.csv("outcome-of-care-measures.csv")
 
   # change outcome to lowercase
   outcome <- tolower(outcome)
   chosen_state <- state

  ## check that the state and outcome are valid
 if (is.na(match(state, unique(outcome_data$State)))){
   stop("invalid state")
 }
     
   if (!outcome %in% c("heart attack", "heart failure", "pneumonia")){
     stop("invalid outcome")
   }
  
  ## return hospital name in that state with lowest 30-day death
  
  if (outcome == "heart attack") {
    rate <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack" # 11 
  } else if (outcome == "heart failure"){
    rate <- "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure" # 17
  } else {
    rate <- "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia" # 23
  }

# subset the outcome data to chosen state      
outcome_data <- subset(outcome_data, State == chosen_state)
# outcome_data <- subset(outcome_data, State == "TX")
# head(outcome_data)



# simplify the output to only two columns, name and chosen rate  
outcome_data_short <- data.frame(as.character(outcome_data[,2]), as.numeric(outcome_data[,rate]))

# outcome_data_short <- data.frame(as.character(outcome_data[,2]), as.numeric(outcome_data[,17]))

   
# set rate to numeric    
# outcome_data_short[,2] <- suppressWarnings(as.numeric(outcome_data_short[,2]))
  
# remove NA values
outcome_data_short <- na.omit(outcome_data_short)
if(is.numeric(num) & num<= nrow(outcome_data)){
  rank <- num
} else if (num == "worst"){
  rank <- nrow(outcome_data_short)
} else if (num == "best") {
  rank <- 1
} else {
  stop("invalid number")
}
   
# order by column 2        
  order_data <- outcome_data_short [order(outcome_data_short [,2], outcome_data_short [,2], na.last = NA),]

  order_data <- data.frame(1:nrow(order_data), order_data)
  
  
# return name with lowest rate  
return(order_data[rank,2])

}