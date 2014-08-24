fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "tempdata.zip", method = "auto")
unzip("./tempdata.zip")

NEI <- readRDS("summarySCC_PM25.rds")

code <- readRDS("Source_Classification_Code.rds")

library(reshape)
library(ggplot2)

data_5 <-aggregate(NEI$Emissions[NEI$SCC %in% code$SCC[grep("Veh",code$Short.Name)] & NEI$fips==24510] ~ NEI$year[NEI$SCC %in% code$SCC[grep("Veh",code$Short.Name)] & NEI$fips==24510] , NEI, sum)
colnames(data_5)<-c("year","emissions")
ggplot(data_5, aes(x=factor(year),y=emissions)) + geom_bar(stat = "identity") +
  ggtitle("Emissions by vehicle sources in Baltimore City") + labs(x = "Years", y="Emissions")
ggsave(file="plot5.png")
