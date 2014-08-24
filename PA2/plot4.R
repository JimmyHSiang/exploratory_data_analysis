fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "tempdata.zip", method = "auto")
unzip("./tempdata.zip")

NEI <- readRDS("summarySCC_PM25.rds")

code <- readRDS("Source_Classification_Code.rds")

library(reshape)
library(ggplot2)

data_4 <-aggregate(NEI$Emissions[NEI$SCC %in% code$SCC[grep("Coal",code$Short.Name)]] ~ NEI$year[NEI$SCC %in% code$SCC[grep("Coal",code$Short.Name)]] , NEI, sum)
colnames(data_4)<-c("year","emissions")
ggplot(data_4, aes(x=factor(year),y=emissions)) + geom_bar(stat = "identity") +
  ggtitle("Emissions by Coal Combustion") + labs(x = "Years", y="Emissions")
ggsave(file="plot4.png")
