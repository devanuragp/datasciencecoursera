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

#plot4
par(mfrow = c(2,2),mgp=c(2,1,0))
with(new_df,plot(DateTime,Global_active_power,type = "l",
                 ylab = "Global Active Power"))
with(new_df,plot(DateTime,Voltage,type = "l",ylab = "Voltage"))
with(new_df,plot(DateTime,Sub_metering_1,type = "l",
                 ylab = "Energy Sub Metering"))
lines(new_df$DateTime,y=new_df$Sub_metering_2,col="red")
lines(new_df$DateTime,y=new_df$Sub_metering_3,col="blue")
legend("topright",lty = c(1,1,1),col=c("black","red","blue"),
       legend = c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_2"),cex = 0.7)
with(new_df,plot(DateTime,Global_reactive_power,type = "l",
                 ylab = "Global Reactive Power"))

dev.copy(png,file = "plot4.png")
dev.off()
