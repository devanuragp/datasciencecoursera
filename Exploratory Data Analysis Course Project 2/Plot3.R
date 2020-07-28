library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

subpnt <- subset(NEI,type == "POINT",c("Emissions","year","type"))
subnpnt <- subset(NEI,type == "NONPOINT",c("Emissions","year","type"))
suboroad <- subset(NEI,type == "ON-ROAD",c("Emissions","year","type"))
subnroad <- subset(NEI,type == "NON-ROAD",c("Emissions","year","type"))

years <- c("1999","2002","2005","2008")


tot_point <- data.frame(tapply(subpnt$Emissions,
                               as.factor(subpnt$year),sum))
tot_point <- cbind(tot_point,years,subpnt$type[1:4])
names(tot_point)[1:3] <- c("Total_Emissions","Year","Type")

tot_npoint <- data.frame(tapply(subnpnt$Emissions,
                                as.factor(subnpnt$year),sum))
tot_npoint <- cbind(tot_npoint,years,subnpnt$type[1:4])
names(tot_npoint)[1:3] <- c("Total_Emissions","Year","Type")

tot_oroad <- data.frame(tapply(suboroad$Emissions,
                               as.factor(suboroad$year),sum))
tot_oroad <- cbind(tot_oroad,years,suboroad$type[1:4])
names(tot_oroad)[1:3] <- c("Total_Emissions","Year","Type")

tot_nroad <- data.frame(tapply(subnroad$Emissions,
                               as.factor(subnroad$year),sum))
tot_nroad <- cbind(tot_nroad,years,subnroad$type[1:4])
names(tot_nroad)[1:3] <- c("Total_Emissions","Year","Type")


tot_type <- rbind(tot_point,tot_npoint,tot_oroad,tot_nroad)

png("plot3.png", width = 750, height = 300)
qplot(Year, Total_Emissions, data=tot_type
      ,geom = c("point","line"),facets = .~Type
      ,group =1, colour = Type
      ,ylab = "Total Emission in tons"
      ,main = "Emission by types of source in Baltimore City")
dev.off()
