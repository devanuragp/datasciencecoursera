final_df_train <- cbind(final_x,final_y)
final_df_test <- cbind(final_x_test,final_y_test)

pre_final <- rbind(final_df_train,final_df_test)

x_as_numeric <- data.frame(apply(pre_final[1:66],2,as.numeric))

final <- cbind(x_as_numeric,pre_final$activity)

names(final)[67] <- "activity"

#write.csv(final,"D:\\My Documents\\Coursera\\Data Science\\Course Projects\\Getting and Cleaning data -UCI HAR Dataset\\merged.csv", 
#          row.names = FALSE)