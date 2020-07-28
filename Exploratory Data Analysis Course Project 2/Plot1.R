NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

tot99 <- sum(subset(NEI,year==1999,"Emissions"))
tot02 <- sum(subset(NEI,year==2002,"Emissions"))
tot05 <- sum(subset(NEI,year==2005,"Emissions"))
tot08 <- sum(subset(NEI,year==2008,"Emissions"))
totdf <- data.frame(rbind(tot99,tot02,tot05,tot08))

years <- c("1999","2002","2005","2008")
totdf <- cbind(totdf,years)
names(totdf)[1] <- "Total_Emissions"

png("plot1.png",height = 600,width = 600)
with(totdf,plot(years, Total_Emissions, type= "l",
                main = "Total PM2.5 Emission from all sources",
                ylab = "Total Emission in tons", lwd = 2))
dev.off()

