NEI <- readRDS("C:/Users/joe/Documents/HW2/summarySCC_PM25.rds")
SCC <- readRDS("C:/Users/joe/Documents/HW2/Source_Classification_Code.rds")

#-- How have emissions from motor vehicle sources changed from 1999¡V2008 in Baltimore City?

#-- Get Baltimore emissions from motor vehicle sources
bmore.emissions <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]
bmore.emissions.aggr <- aggregate(Emissions ~ year, data=bmore.emissions, FUN=sum)

#-- Display results in a plot
library(ggplot2)
ggplot(bmore.emissions.aggr, aes(x=factor(year), y=Emissions)) +
  geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression("Total PM"[2.5]*" Emissions")) +
  ggtitle("Emissions from Motor Vehicle Sources in Baltimore City")

#Export the figure to wd
dev.copy(png, file="plot5.png")  
dev.off()
