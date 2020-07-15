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