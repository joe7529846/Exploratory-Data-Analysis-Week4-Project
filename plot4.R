NEI <- readRDS("C:/Users/joe/Documents/HW2/summarySCC_PM25.rds")
SCC <- readRDS("C:/Users/joe/Documents/HW2/Source_Classification_Code.rds")

#-- Find coal combustion-related sources
is.combustion.coal <- grepl("Fuel Comb.*Coal", SCC$EI.Sector)
combustion.coal.sources <- SCC[is.combustion.coal,]

#-- Find emissions from coal combustion-related sources
emissions <- NEI[(NEI$SCC %in% combustion.coal.sources$SCC), ]

#-- group emissions by year
emissions.by.year <- aggregate(Emissions ~ year, data=emissions, FUN=sum)

#-- Display results in a plot
library(ggplot2)
ggplot(emissions.by.year, aes(x=factor(year), y=Emissions)) +
  geom_bar(stat="identity") +
  xlab("year") +
  ylab(expression("Total PM"[2.5]*" Emissions")) +
  ggtitle("Emissions from Coal Combustion-Related Sources")

#Export the figure to wd
dev.copy(png, file="plot4.png")  
dev.off()
