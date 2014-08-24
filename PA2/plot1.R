fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "tempdata.zip", method = "auto")
unzip("./tempdata.zip")

NEI <- readRDS("summarySCC_PM25.rds")
 
data_1 <- tapply(NEI$Emissions, NEI$year, sum) 

data_1$Emissions <- data_1$Emissions/1000


png("plot1.png")
plot(names(data_1), data_1, type="l", 
     xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions (thousand tons)"), 
     main=expression("Total US" ~ PM[2.5] ~ "Emissions by Year")) 

dev.off()
