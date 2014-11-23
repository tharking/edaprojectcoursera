## read data
NEI <- readRDS("./summarySCC_PM25.rds")
## turn year into a factor
mydata <- transform(NEI, year = factor(year))
## It assumes user has already installed plyr
library(plyr)
plotdata <- ddply(mydata, .(year), summarize, sum = sum(Emissions))
#create bar chart
png("plot1.png")
barplot(plotdata$sum, names.arg=plotdata$year, xlab="YEAR", ylab="Total PM Emissions")
dev.off()