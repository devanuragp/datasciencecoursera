library(dplyr)
###########################################################

x_train <- read.table("train/x_train.txt", sep = ";")

xconvtolist <- function(x){
  n <- gsub("  "," ",x)
  n <- strsplit(n," ")
  n <- as.list(n[[1]])
  n <- n[-1]
  n
}

final_x <- data.frame(matrix(unlist(apply(x_train, 1, xconvtolist)),nrow = 7352
                             ,byrow = T),stringsAsFactors = FALSE)

meanindex <- c(1,2,3,41,42,43,81,82,83,121,122,123,161,162,163,201,214,227,240,253,266,267,268,345,346,347,424,425,426,503,516,529,542)
stdindex <- c(4,5,6,44,45,46,84,85,86,124,125,126,164,165,166,202,215,228,241,254,269,270,271,348,349,350,427,428,429,504,517,530,543)
meanname <- c("t_body_acc_mean_x","t_body_acc_mean_y","t_body_acc_mean_z","t_gravity_acc_mean_x","t_gravity_acc_mean_y","t_gravity_acc_mean_z","t_body_acc_jerk_mean_x","t_body_acc_jerk_mean_y","t_body_acc_jerk_mean_z","t_body_gyro_mean_x","t_body_gyro_mean_y","t_body_gyro_mean_z","t_body_gyro_jerk_mean_x","t_body_gyro_jerk_mean_y","t_body_gyro_jerk_mean_z","t_body_acc_mag_mean","t_gravity_acc_mag_mean","t_body_acc_jerk_mag_mean","t_body_gyro_mag_mean","t_body_gyro_jerk_mag_mean","f_body_acc_mean_x","f_body_acc_mean_y","f_body_acc_mean_z","f_body_acc_jerk_mean_x","f_body_acc_jerk_mean_y","f_body_acc_jerk_mean_z","f_body_gyro_mean_x","f_body_gyro_mean_y","f_body_gyro_mean_z","f_body_acc_mag_mean","f_body_acc_jerk_mag_mean","f_body_gyro_mag_mean","f_body_gyro_jerk_mag_mean")
stdname <- c("t_body_acc_std_x","t_body_acc_std_y","t_body_acc_std_z","t_gravity_acc_std_x","t_gravity_acc_std_y","t_gravity_acc_std_z","t_body_acc_jerk_std_x","t_body_acc_jerk_std_y","t_body_acc_jerk_std_z","t_body_gyro_std_x","t_body_gyro_std_y","t_body_gyro_std_z","t_body_gyro_jerk_std_x","t_body_gyro_jerk_std_y","t_body_gyro_jerk_std_z","t_body_acc_mag_std","t_gravity_acc_mag_std","t_body_acc_jerk_mag_std","t_body_gyro_mag_std","t_body_gyro_jerk_mag_std","f_body_acc_std_x","f_body_acc_std_y","f_body_acc_std_z","f_body_acc_jerk_std_x","f_body_acc_jerk_std_y","f_body_acc_jerk_std_z","f_body_gyro_std_x","f_body_gyro_std_y","f_body_gyro_std_z","f_body_acc_mag_std","f_body_acc_jerk_mag_std","f_body_gyro_mag_std","f_body_gyro_jerk_mag_std")

names(final_x)[meanindex] <- meanname
names(final_x)[stdindex] <- stdname

final_x <- select(final_x, meanindex, stdindex)

#write.csv(final_x,"D:\\My Documents\\Coursera\\Data Science\\Course Projects\\Getting and Cleaning data -UCI HAR Dataset\\train\\x_train.csv", 
#          row.names = FALSE)

###########################################################

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

###########################################################

x_test <- read.table("test/x_test.txt", sep = ";")

xconvtolist <- function(x){
  n <- gsub("  "," ",x)
  n <- strsplit(n," ")
  n <- as.list(n[[1]])
  n <- n[-1]
  n
}

final_x_test <- data.frame(matrix(unlist(apply(x_test, 1, xconvtolist)),nrow = 2947
                                  ,byrow = T),stringsAsFactors = FALSE)

meanindex <- c(1,2,3,41,42,43,81,82,83,121,122,123,161,162,163,201,214,227,240,253,266,267,268,345,346,347,424,425,426,503,516,529,542)
stdindex <- c(4,5,6,44,45,46,84,85,86,124,125,126,164,165,166,202,215,228,241,254,269,270,271,348,349,350,427,428,429,504,517,530,543)
meanname <- c("t_body_acc_mean_x","t_body_acc_mean_y","t_body_acc_mean_z","t_gravity_acc_mean_x","t_gravity_acc_mean_y","t_gravity_acc_mean_z","t_body_acc_jerk_mean_x","t_body_acc_jerk_mean_y","t_body_acc_jerk_mean_z","t_body_gyro_mean_x","t_body_gyro_mean_y","t_body_gyro_mean_z","t_body_gyro_jerk_mean_x","t_body_gyro_jerk_mean_y","t_body_gyro_jerk_mean_z","t_body_acc_mag_mean","t_gravity_acc_mag_mean","t_body_acc_jerk_mag_mean","t_body_gyro_mag_mean","t_body_gyro_jerk_mag_mean","f_body_acc_mean_x","f_body_acc_mean_y","f_body_acc_mean_z","f_body_acc_jerk_mean_x","f_body_acc_jerk_mean_y","f_body_acc_jerk_mean_z","f_body_gyro_mean_x","f_body_gyro_mean_y","f_body_gyro_mean_z","f_body_acc_mag_mean","f_body_acc_jerk_mag_mean","f_body_gyro_mag_mean","f_body_gyro_jerk_mag_mean")
stdname <- c("t_body_acc_std_x","t_body_acc_std_y","t_body_acc_std_z","t_gravity_acc_std_x","t_gravity_acc_std_y","t_gravity_acc_std_z","t_body_acc_jerk_std_x","t_body_acc_jerk_std_y","t_body_acc_jerk_std_z","t_body_gyro_std_x","t_body_gyro_std_y","t_body_gyro_std_z","t_body_gyro_jerk_std_x","t_body_gyro_jerk_std_y","t_body_gyro_jerk_std_z","t_body_acc_mag_std","t_gravity_acc_mag_std","t_body_acc_jerk_mag_std","t_body_gyro_mag_std","t_body_gyro_jerk_mag_std","f_body_acc_std_x","f_body_acc_std_y","f_body_acc_std_z","f_body_acc_jerk_std_x","f_body_acc_jerk_std_y","f_body_acc_jerk_std_z","f_body_gyro_std_x","f_body_gyro_std_y","f_body_gyro_std_z","f_body_acc_mag_std","f_body_acc_jerk_mag_std","f_body_gyro_mag_std","f_body_gyro_jerk_mag_std")

names(final_x_test)[meanindex] <- meanname
names(final_x_test)[stdindex] <- stdname

final_x_test <- select(final_x_test, meanindex, stdindex)

#write.csv(final_x_test,"D:\\My Documents\\Coursera\\Data Science\\Course Projects\\Getting and Cleaning data -UCI HAR Dataset\\test\\x_test.csv", 
#          row.names = FALSE)


###########################################################

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

###########################################################

final_df_train <- cbind(final_x,final_y)
final_df_test <- cbind(final_x_test,final_y_test)

pre_final <- rbind(final_df_train,final_df_test)

x_as_numeric <- data.frame(apply(pre_final[1:66],2,as.numeric))

final <- cbind(x_as_numeric,pre_final$activity)

names(final)[67] <- "activity"

#write.csv(final,"D:\\My Documents\\Coursera\\Data Science\\Course Projects\\Getting and Cleaning data -UCI HAR Dataset\\merged.csv", 
#          row.names = FALSE)

###########################################################

walking_df <- filter(final,activity == "Walking")
avg_walking_df <- as.data.frame(t(apply(walking_df[,1:66],2,mean)),
                                row.names = "Walking")

walking_up_df <- filter(final,activity == "Walking Upstairs")
avg_walking_up_df <- as.data.frame(t(apply(walking_df[,1:66],2,mean)),
                                   row.names = "Walking Upstairs")

walking_down_df <- filter(final,activity == "Walking Downstairs")
avg_walking_down_df <- as.data.frame(t(apply(walking_df[,1:66],2,mean)),
                                     row.names = "Walking Downstairs")

sitting_df <- filter(final,activity == "Sitting")
avg_sitting_df <- as.data.frame(t(apply(walking_df[,1:66],2,mean)),
                                row.names = "Sitting")

standing_df <- filter(final,activity == "Standing")
avg_standing_df <- as.data.frame(t(apply(walking_df[,1:66],2,mean)),
                                 row.names = "Standing")

laying_df <- filter(final,activity == "Laying")
avg_laying_df <- as.data.frame(t(apply(walking_df[,1:66],2,mean)),
                               row.names = "Laying")

final_short <- as.data.frame(t(rbind(avg_walking_df,avg_walking_up_df,avg_walking_down_df,avg_sitting_df,
                                     avg_standing_df,avg_laying_df)))

forrenaming <- rownames(final_short)
newrownames <- paste("Avg_",forrenaming, sep = "")
rownames(final_short) <- newrownames

#write.csv(final_short,"D:\\My Documents\\Coursera\\Data Science\\Course Projects\\Getting and Cleaning data -UCI HAR Dataset\\averageOfVariables.csv", 
#          row.names = TRUE)

write.table(final_short,"D:\\My Documents\\Coursera\\Data Science\\Course Projects\\Getting and Cleaning data -UCI HAR Dataset\\tidy_set.txt",
            row.name = FALSE)
