NEI <- readRDS("C:/Users/joe/Documents/HW2/summarySCC_PM25.rds")
SCC <- readRDS("C:/Users/joe/Documents/HW2/Source_Classification_Code.rds")

#-- Compare emissions from motor vehicle sources in Baltimore City with emissions
#-- from motor vehicle sources in Los Angeles County, California (fips == "06037"). 
#-- Which city has seen greater changes over time in motor vehicle emissions?

normalize <- function(x) {(x-min(x)) / (max(x)-min(x))}

#-- Get Baltimore emissions from motor vehicle sources
bmore.emissions <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
bmore.emissions.aggr <- aggregate(Emissions ~ year, data=bmore.emissions, FUN=sum)

#-- Get Los Angeles emissions from motor vehicle sources
la.emissions <- NEI[(NEI$fips=="06037") & (NEI$type=="ON-ROAD"),]
la.emissions.aggr <- aggregate(Emissions ~ year, data=la.emissions, FUN=sum)

bmore.emissions.aggr$County <- "Baltimore City, MD"
la.emissions.aggr$County <- "Los Angeles County, CA"
both.emissions <- rbind(bmore.emissions.aggr, la.emissions.aggr)

#-- Display results in a plot
library(ggplot2)
ggplot(both.emissions, aes(x=factor(year), y=Emissions, fill=County)) +
  geom_bar(stat="identity") + 
  facet_grid(County  ~ ., scales="free") +
  ylab("Total Emissions (tons)") + 
  xlab("year") +
  ggtitle(expression("Motor vehicle emission variations in Baltimore and Los Angeles"))

#Export the figure to wd
dev.copy(png, file="plot6.png")  
dev.off()
