## read data
NEI <- readRDS("./summarySCC_PM25.rds")
## turn year into a factor
mydata <- transform(NEI, year = factor(year))
##filter data
datafiltered <- mydata[mydata$fips == "24510",]
## It assumes user has already installed plyr
library(plyr)
# same as plot 1 here, sum by emissions
plotdata <- ddply(datafiltered, .(year), summarize, sum = sum(Emissions))
#create bar chart
png("plot2.png")
barplot(plotdata$sum, names.arg=plotdata$year, xlab="YEAR", ylab="Total PM Emissions")
dev.off()