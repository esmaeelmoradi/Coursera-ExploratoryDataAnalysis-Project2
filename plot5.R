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
if(!exists("NEISCC")){
        NEISCC <- merge(NEI, SCC, by="SCC")
}

neededData <- subset(NEI, fips=="24510" & type=="ON-ROAD")

totalEmmission <- aggregate(Emissions ~ year, neededData, sum)


png("plot5.png", width=840, height=480)
g <- ggplot(totalEmmission, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
        xlab("year") +
        ylab(expression("Total PM2.5 Emissions")) +
        ggtitle('Total Emissions for Baltimore City, Maryland and for ON-ROAD type')
print(g)
dev.off()