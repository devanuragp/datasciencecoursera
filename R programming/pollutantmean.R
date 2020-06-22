pollutantmean <- function(directory, pollutant, id=1:332){
  setwd(directory)
  getrows <- function(id){
    mondata <- data.frame()
    for(i in id){
      filename <- paste(formatC(i, width=3, flag="0"),".csv",sep="")
      df <- read.csv(filename)
      mondata <- rbind(mondata,df)
    }
    mondata
  }
  pollutantdata <- getrows(id)
  mean(pollutantdata[[pollutant]],na.rm = TRUE)
}