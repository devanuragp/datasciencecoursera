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


