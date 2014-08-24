fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "tempdata.zip", method = "auto")
unzip("./tempdata.zip")

NEI <- readRDS("summarySCC_PM25.rds")

code <- readRDS("Source_Classification_Code.rds")

library(reshape)
library(ggplot2)

data_6<-aggregate(NEI$Emissions[NEI$SCC %in% code$SCC[grep("Veh",code$Short.Name)] & (NEI$fips==24510 | NEI$fips=="06037")] ~ NEI$year[NEI$SCC %in% code$SCC[grep("Veh",code$Short.Name)] & (NEI$fips==24510 | NEI$fips=="06037")] + NEI$fips[NEI$SCC %in% code$SCC[grep("Veh",code$Short.Name)] & (NEI$fips==24510 | NEI$fips=="06037")], NEI, sum)
colnames(data_6)<-c("year","fips","emissions")
ggplot(data_6, aes(x=factor(year),y=emissions,group=fips)) + geom_line(aes(colour=fips)) +
  ggtitle("Emissions by vehicle sources") + labs(x = "Years", y="Emissions") +
  scale_colour_manual (values=c("orange","black"), labels=c("Los Angeles County","Baltimore City"))
ggsave(file="plot6.png")
