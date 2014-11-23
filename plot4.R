## read data
NEI <- readRDS("./summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
#filter coal
Coal = SCC[which(grepl("coal", SCC$Short.Name, ignore.case=TRUE) | grepl("coal", SCC$EI.Sector, ignore.case=TRUE)),]
## turn year into a factor
mydata <- transform(NEI, year = factor(year))
##filter data
mergedata <- merge(x=mydata, y=Coal, by='SCC')
## It assumes user has already installed plyr
library(plyr)
# sum by emissions for every year
plotdata <- ddply(mergedata, .(year), summarize, sum = sum(Emissions))

library(ggplot2)
png(filename='plot4.png')
ggplot(plotdata, aes(year, sum)) +
  geom_bar(stat = "identity", aes(fill=year)) + labs(x="YEAR", y="Total Coal Emissions")  
dev.off()
