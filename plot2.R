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
TotalEmmission <- aggregate(Emissions ~ year, NEI24510, sum)

#this will make the picture
png('plot2.png')
barplot(height=TotalEmmission$Emissions, names.arg=TotalEmmission$year, xlab="years", ylab='PM2.5 emission' ,main='Total PM2.5 emissions at various years')
dev.off()