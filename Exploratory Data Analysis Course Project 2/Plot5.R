library(ggplot2)

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


png("plot5.png", height = 600, width = 600)
qplot(Year, Total_Emissions, data = motorBaldf,
      geom = c("point","line"),group = 1,
      ylab = "Total Emissions in tons",
      main = "Emissions from motor vehicles in Baltimore City")
dev.off()


