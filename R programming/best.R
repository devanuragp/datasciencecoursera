best <- function(state, outcome) {
  ## Read outcome data
  if (getwd() != "C:/Users/Anurag/DataScience Coursera using R/datasciencecoursera/Data files/hosptial data"){
    setwd("C:/Users/Anurag/DataScience Coursera using R/datasciencecoursera/Data files/hosptial data")
  }
  outcome1 <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
  ## Check that state is valid
  if(!any(outcome1$State == state)){
    return(stop("invalid state"))
  }
  
  ##to check if outcome is valid & match the outcome with its column name 
  if(outcome == "heart attack" ){
    colname <- c(names(outcome1[11]))
  }else if(outcome == "heart failure"){
    colname <- c(names(outcome1[17]))
  }else if( outcome == "pneumonia"){
    colname <- c(names(outcome1[23]))
  }else{
    return(stop("invalid outcome"))
  }
  
  ##getting a subset of all the hospital in select state and their outcome
  subnewoutcome <- subset(outcome1, State == state, c(Hospital.Name ,get(colname)))
  
  ##converting the outcome column to numeric in order to find the minimum
  ##and removing NA's
   
  subnewoutcome[,2] <-suppressWarnings(as.numeric(subnewoutcome[,2])) #suppress warning used to avoid NA coersion  
  subnewoutcome <- subnewoutcome[complete.cases(subnewoutcome),]
  
  ## Return hospital name in that state with lowest 30-day death
  
  besthosp <- subset(subnewoutcome,get(colname) == min(get(colname)), Hospital.Name)
  besthosp[order(besthosp$Hospital.Name),]
}