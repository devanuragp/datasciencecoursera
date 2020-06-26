rankall <- function(outcome, num = "best") {
  ## Read outcome data
  if (getwd() != "C:/Users/Anurag/DataScience Coursera using R/datasciencecoursera/Data files/hosptial data"){
    setwd("C:/Users/Anurag/DataScience Coursera using R/datasciencecoursera/Data files/hosptial data")
  }
  outcome1 <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
  
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
  subnewoutcome <- subset(outcome1, TRUE , c(Hospital.Name ,State ,get(colname)))
  
  ##converting the outcome column to numeric in order to find the minimum
  ##and removing NA's
  
  subnewoutcome[,3] <-suppressWarnings(as.numeric(subnewoutcome[,3])) #suppress warning used to avoid NA coersion  
  subnewoutcome <- subnewoutcome[complete.cases(subnewoutcome),]
  colnames(subnewoutcome)[3] <- "Rate"
  
  finalrank <- data.frame()
  
  rankhosp <-function(df, state, num = "best"){
    hospinstates <- subset(df, State == state , c(Hospital.Name ,State ,Rate))
    hospinstates <- hospinstates[order(hospinstates$Rate,hospinstates$Hospital.Name),]
    hospinstates <- cbind(hospinstates, Rank = 1:length(hospinstates$Hospital.Name))
    
    ##Name of Hospital asked in argument
    if (num == "best"){
      return(hospinstates[hospinstates$Rank== 1,c("Hospital.Name","State")])
    }else if(num == "worst"){
      return(hospinstates[hospinstates$Rank== length(hospinstates$Rank),c("Hospital.Name","State")])
    }else if(num > 1 && num < length(hospinstates$Rank)){
      return(hospinstates[hospinstates$Rank== num,c("Hospital.Name","State")])
    }else{
      return(c(NA,state))
    }
  }
  for(i in unique(subnewoutcome[[2]])){
    finalrank <- rbind(finalrank,rankhosp(subnewoutcome, i, num))
  }
  finalrank <- finalrank[order(finalrank$State),]
  finalrank
}
