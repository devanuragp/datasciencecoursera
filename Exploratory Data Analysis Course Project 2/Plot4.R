library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

scc <- subset(SCC,
              EI.Sector == "Fuel Comb - Electric Generation - Coal"|
              EI.Sector == "Fuel Comb - Comm/Institutional - Coal",
              "SCC")

scc$SCC <- as.character(scc$SCC)

logicvalues <- NEI$SCC %in% scc$SCC
coalcombdf <- NEI[logicvalues,]

coalcombdf <- data.frame(tapply(coalcombdf$Emissions,
                            as.factor(coalcombdf$year),sum))
coalcombdf <-  cbind(coalcombdf,c("1999","2002","2005","2008"))
names(coalcombdf)[1:2] <- c("Total_Emissions","Year")

png("plot4.png", height = 600, width = 600)
qplot(Year, Total_Emissions, data = coalcombdf,
      geom = c("point","line"),group = 1,
      ylab = "Total Emissions in ton",
      main = "Emissions from Coal Combustion related sources")
dev.off()

