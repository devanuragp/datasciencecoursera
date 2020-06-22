complete <- function(directory, id=1:332){
  if(getwd() != directory){
    setwd(directory)
  }
  getdf <- function(id){
    monnobs <- data.frame(id=integer(),nobs=integer())
    for(i in id){
      filename <- paste(formatC(i, width=3, flag="0"),".csv",sep="")
      df <- read.csv(filename)
      good <- complete.cases(df)
      obs <- nrow(df[good,])
      newdf <- data.frame(id = i , nobs = obs)
      monnobs <- rbind(monnobs,newdf)
    }
    monnobs
  }
  coc <- getdf(id)
  coc
}