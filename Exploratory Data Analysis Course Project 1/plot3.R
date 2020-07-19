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

plot3 <- plot(new_df$DateTime,new_df$Sub_metering_1,type = "l",
              ylab = "Energy Sub reading",xlab = "")
lines(new_df$DateTime,y=new_df$Sub_metering_2,col="red")
lines(new_df$DateTime,y=new_df$Sub_metering_3,col="blue")
legend("topright",lty = c(1,1,1),col=c("black","red","blue"),
       legend = c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_2"))

dev.copy(png,file = "plot3.png")
dev.off()