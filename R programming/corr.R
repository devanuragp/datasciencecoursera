corr <- function(directory,threshold = 0){
  if(getwd() != directory){
    setwd(directory)
  }
  getvec <- function(threshold){
    veccorr <- numeric()
    for(i in list.files(directory)){
      df <- read.csv(i)
      df <- df[complete.cases(df),]
      obs <- nrow(df)
      if( obs > threshold){
        veccorr <- append(veccorr,cor(c(df[["sulfate"]]),c(df[["nitrate"]])))
      }
    }
    veccorr
  }
  ans <- getvec(threshold)
  ans
}