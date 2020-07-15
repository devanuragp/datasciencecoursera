y_test <- read.table("test/y_test.txt", sep = ";")

names(y_test)[1] <-"activity" 

ylabelconv <- function(x){
  n <- sub("1","Walking",x)
  n <- sub("2","Walking Upstairs",n)
  n <- sub("3","Walking Downstairs",n)
  n <- sub("4","Sitting",n)
  n <- sub("5","Standing",n)
  n <- sub("6","Laying",n)
  n
}

final_y_test <- as.data.frame(apply(y_test,2,ylabelconv))

#write.csv(final_y_test,"D:\\My Documents\\Coursera\\Data Science\\Course Projects\\Getting and Cleaning data -UCI HAR Dataset\\test\\y_test.csv", 
#         row.names = FALSE)