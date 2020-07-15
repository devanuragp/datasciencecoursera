y_train <- read.table("train/y_train.txt", sep = ";")

names(y_train)[1] <-"activity" 

ylabelconv <- function(x){
  n <- sub("1","Walking",x)
  n <- sub("2","Walking Upstairs",n)
  n <- sub("3","Walking Downstairs",n)
  n <- sub("4","Sitting",n)
  n <- sub("5","Standing",n)
  n <- sub("6","Laying",n)
  n
}

final_y <- as.data.frame(apply(y_train,2,ylabelconv))

#write.csv(final_y,"D:\\My Documents\\Coursera\\Data Science\\Course Projects\\Getting and Cleaning data -UCI HAR Dataset\\train\\y_train.csv", 
#          row.names = FALSE)

