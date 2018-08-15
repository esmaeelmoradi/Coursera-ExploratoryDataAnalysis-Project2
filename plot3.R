library(ggplot2)

#do not forget to set the directory
#setwd("........")

## This first line will likely take a few seconds. Be patient!
if(!exists("NEI")){
        NEI <- readRDS("./data/summarySCC_PM25.rds")
}
if(!exists("SCC")){
        SCC <- readRDS("./data/Source_Classification_Code.rds")
}

#data we need:
NEI24510 <- subset(NEI, fips=="24510")

#this will group the emmissions value by year 
TotalEmmission <- aggregate(Emissions ~ year + type, NEI24510, sum)

png("plot3.png", width=640, height=480)
g <- ggplot(TotalEmmission, aes(year, Emissions, color = type))
g <- g + geom_line() +
        xlab("year") +
        ylab("Total PM2.5 Emissions") +
        ggtitle("Total PM2.5 emissions at various years")
print(g)
dev.off()