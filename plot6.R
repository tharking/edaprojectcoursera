## read data
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#filter vehicles
Vehicles = SCC[which(grepl("Vehicle", SCC$Short.Name, ignore.case=TRUE)),]
## turn year into a factor
mydata <- transform(NEI, year = factor(year))
##filter data
datafiltered <- mydata[mydata$fips == "24510" | mydata$fips == "06037",]
datafiltered$city[datafiltered$fips == "24510"] <- "Baltimore"
datafiltered$city[datafiltered$fips == "06037"] <- "LosAngeles"
#merge data
mergedata <- merge(x=datafiltered, y=Vehicles, by='SCC')
## It assumes user has already installed plyr
library(plyr)
# sum by emissions for every year & city
plotdata <- ddply(mergedata, .(year, city), summarize, sum = sum(Emissions))
#plot it
library(ggplot2)
png(filename='plot6.png')
ggplot(plotdata, aes(year, sum)) + facet_grid(. ~ city) + geom_bar(stat = "identity", aes(fill=city)) + labs(x="YEAR", y="Total Vehicle Emissions")
dev.off()
