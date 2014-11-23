## read data
NEI <- readRDS("./summarySCC_PM25.rds")
## turn year into a factor
mydata <- transform(NEI, year = factor(year))
mydata <- transform(mydata, type = factor(type))
##filter data
datafiltered <- mydata[mydata$fips == "24510",]
## It assumes user has already installed plyr
library(plyr)
# sum by emissions for every year & type
plotdata <- ddply(datafiltered, .(year, type), summarize, sum = sum(Emissions))
#create multifacet ggplot chart
library(ggplot2)
png("plot3.png", width=1024, height=768, units='px')
ggplot(plotdata, aes(year, sum)) + facet_grid(. ~ type) + geom_bar(stat = "identity", aes(fill=type)) + labs(x="YEAR", y="Total Emissions")
dev.off()
