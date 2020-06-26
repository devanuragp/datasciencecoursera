rankhospital <- function(state, outcome, num = "best") {
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
  
  ##Hospitals according to their rank based on death rate of outcome
  colnames(subnewoutcome)[2] <- "Rate"
  subnewoutcome<- subnewoutcome[order(subnewoutcome$Rate,subnewoutcome$Hospital.Name),]
  subnewoutcome <- cbind(subnewoutcome, Rank = 1:length(subnewoutcome$Hospital.Name))
  
  ##Name of Hospital asked in argument
  if (num == "best"){
    return(subnewoutcome[subnewoutcome$Rank== 1,"Hospital.Name"])
  }else if(num == "worst"){
    return(subnewoutcome[subnewoutcome$Rank== length(subnewoutcome$Rank),"Hospital.Name"])
  }else if(num > 1 && num < length(subnewoutcome$Rank)){
    return(subnewoutcome[subnewoutcome$Rank== num,"Hospital.Name"])
  }else{
    return(NA)
  } 
}