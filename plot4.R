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

# get all the names which matches coal
coalNames  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
coalNEISCC <- NEISCC[coalNames, ]

TotalEmmission <- aggregate(Emissions ~ year, coalNEISCC, sum)

png("plot4.png", width=640, height=480)
g <- ggplot(TotalEmmission, aes(factor(year), Emissions))
g <- g + geom_bar(stat="identity") +
        xlab("year") +
        ylab("Total PM2.5 Emissions") +
        ggtitle("Total Emissions for coal")
print(g)
dev.off()
