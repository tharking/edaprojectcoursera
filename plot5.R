## read data
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#filter vehicles
Vehicles = SCC[which(grepl("Vehicle", SCC$Short.Name, ignore.case=TRUE)),]
## turn year into a factor
mydata <- transform(NEI, year = factor(year))
##filter data
datafiltered <- mydata[mydata$fips == "24510",]
mergedata <- merge(x=datafiltered, y=Vehicles, by='SCC')
## It assumes user has already installed plyr
library(plyr)
# sum by emissions for every year
plotdata <- ddply(mergedata, .(year), summarize, sum = sum(Emissions))

library(ggplot2)
png(filename='plot5.png')
ggplot(plotdata, aes(year, sum)) +
  geom_bar(stat = "identity", aes(fill=year)) + labs(x="YEAR", y="Total Vehicle Emissions")  
dev.off()
