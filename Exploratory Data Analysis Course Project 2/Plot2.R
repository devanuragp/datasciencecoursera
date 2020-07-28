NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

totBal99 <- sum(subset(NEI, year == 1999 & fips == "24510","Emissions"))
totBal02 <- sum(subset(NEI, year == 2002 & fips == "24510","Emissions"))
totBal05 <- sum(subset(NEI, year == 2005 & fips == "24510","Emissions"))
totBal08 <- sum(subset(NEI, year == 2008 & fips == "24510","Emissions"))
totBaldf <- data.frame(rbind(totBal99,totBal02,totBal05,totBal08))

years <- c("1999","2002","2005","2008")
totBaldf <- cbind(totBaldf,years)
names(totBaldf)[1] <- "Total_Emission"

png("plot2.png", height = 600, width = 600)
with(totBaldf,plot(years, Total_Emission, type = "l",
              main = "Totak Emission for Baltimore City from 1999 - 2008",
              ylab = "Total Emission in tons",lwd = 2))
dev.off()
