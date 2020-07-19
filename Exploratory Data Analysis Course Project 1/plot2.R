library(lubridate)

hh_powerconsumption <- read.table("household_power_consumption.txt",
                                  sep = ";", header = TRUE)

household_pc_short <- subset(hh_powerconsumption,
                             Date == "1/2/2007" | Date == "2/2/2007")

household_pc_short[,"Date"] <- as.Date(household_pc_short$Date,
                                       format = "%d/%m/%Y")

x <- paste(household_pc_short$Date,household_pc_short$Time)
x <- strptime(x,format = "%Y-%m-%d %H:%M:%S", tz= "CET")

new_df <- cbind(household_pc_short,x)
names(new_df)[10] <- "DateTime"

plot(new_df$DateTime,new_df$Global_active_power,type = "l",
     ylab="Global Active Power (kilowatts)",xlab = "")