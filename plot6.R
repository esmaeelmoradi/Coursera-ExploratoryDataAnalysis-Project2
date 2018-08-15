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

neededData <- subset(NEI, (fips=="24510" | fips=="06037") & type=="ON-ROAD")

TotalEmmission <- aggregate(Emissions ~ year + fips, neededData, sum)
TotalEmmission$fips[TotalEmmission$fips=="24510"] <- "Baltimore, MD"
TotalEmmission$fips[TotalEmmission$fips=="06037"] <- "Los Angeles, CA"

png("plot6.png", width=1040, height=480)
g <- ggplot(TotalEmmission, aes(factor(year), Emissions))
g <- g + facet_grid(. ~ fips)
g <- g + geom_bar(stat="identity")  +
        xlab("year") +
        ylab(expression("Total PM 2.5 Emissions")) +
        ggtitle("Total Emissions Baltimore City, MD vs Los Angeles, CA")
print(g)
dev.off()



