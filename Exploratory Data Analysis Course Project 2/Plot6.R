NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

scc <- subset(SCC,
              EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles"|
              EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles"|
              EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles"|
              EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles","SCC")

scc$SCC <- as.character(scc$SCC)

logicvalues <- NEI$SCC %in% scc$SCC
motordf <- NEI[logicvalues,]

motorBaldf <- subset(motordf,fips == "24510",c("Emissions","year"))

motorBaldf <- data.frame(tapply(motorBaldf$Emissions,
                                as.factor(motorBaldf$year),sum))
motorBaldf <-  cbind(motorBaldf,c("1999","2002","2005","2008"))
names(motorBaldf)[1:2] <- c("Total_Emissions","Year")

motorLAdf <- subset(motordf,fips == "06037",c("Emissions","year"))

motorLAdf <- data.frame(tapply(motorLAdf$Emissions,
                               as.factor(motorLAdf$year),sum))
motorLAdf <-  cbind(motorLAdf,c("1999","2002","2005","2008"))
names(motorLAdf)[1:2] <- c("Total_Emissions","Year")

motorfinaldf <- rbind(motorBaldf,motorLAdf)

png("plot6.png", height = 500 , width = 600)
with(motorfinaldf,plot(Year,Total_Emissions,type = "n"))
with(motorfinaldf[1:4,],points(Year, Total_Emissions, col = "blue"))
with(motorfinaldf[1:4,],lines(Year, Total_Emissions, col = "blue"))
with(motorfinaldf[5:8,],points(Year, Total_Emissions, col = "red"))
with(motorfinaldf[5:8,],lines(Year, Total_Emissions, col = "red"))
legend("right", pch = 1, col = c("blue", "red"),
       legend = c("Baltimore City", "Los Angeles"))
title(main = "Comparison of Emissions Between Baltimore City & Los Angeles")
dev.off()



