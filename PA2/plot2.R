fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "tempdata.zip", method = "auto")
unzip("./tempdata.zip")

NEI <- readRDS("summarySCC_PM25.rds")

data_2 <- tapply(NEI$Emissions[NEI$fips==24510],NEI$year[NEI$fips==24510],sum)

png("plot2.png")
barplot(data_2,xlab="year",ylab="emissions in Baltimore City")
dev.off()
