fileUrl <- "https://d396qusza40orc.cloudfront.net/exNEI%2FNEI%2FNEI_NEI.zip"
download.file(fileUrl, destfile = "tempNEI.zip", method = "auto")
unzip("./tempNEI.zip")

NEI <- readRDS("summarySCC_PM25.rds")

library(reshape)
library(ggplot2)

sources<-aggregate(NEI$Emissions[NEI$fips==24510] ~ NEI$type[NEI$fips==24510]+NEI$year[NEI$fips==24510] , NEI, sum)

colnames(sources) <- c("type","year","emissions")
ggplot(sources, aes(x=factor(year),y=emissions,group=type)) + geom_line(aes(colour=type)) +
  ggtitle("Emissions in Baltimore City") + labs(x = "Years", y="Emissions")
ggsave(file="plot3.png")
