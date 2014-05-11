#reconstruct the plots

#household_power_consumption.txt shoule be stored in the working directory.

data <- read.table('household_power_consumption.txt', sep=';', header=T, 
                   colClasses = c('character', 'character', 'numeric',
                                  'numeric', 'numeric', 'numeric',
                                  'numeric', 'numeric', 'numeric'),
                   na.strings='?')
head(data)

data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")

data_1 <- subset(data, 
               as.Date(DateTime) >= as.Date("2007-02-01") & 
                 as.Date(DateTime) <= as.Date("2007-02-02"))
head(data_1)

## plot1: histgram
png("plot1.png", height=480, width=480)
hist(data_1$Global_active_power, col='orange', 
     xlab = 'Global Active Power (kilowatts)',
     main = 'Global Active Power')

dev.off()

## plot2
png("plot2.png", height=480, width=480)
plot(data_1$DateTime, 
     data_1$Global_active_power, 
     pch=NA, 
     xlab="", 
     ylab="Global Active Power (kilowatts)")
lines(data_1$DateTime, data_1$Global_active_power)

dev.off()

##plot3
png("plot3.png", height=480, width=480)
plot(data_1$DateTime, 
     data_1$Sub_metering_1, 
     pch=NA, 
     xlab="", 
     ylab="Energy sub metering")
lines(data_1$DateTime, data_1$Sub_metering_1)
lines(data_1$DateTime, data_1$Sub_metering_2, col='red')
lines(data_1$DateTime, data_1$Sub_metering_3, col='blue')
legend('topright', 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1),
       col = c('black', 'red', 'blue'))

dev.off()

## plot4

png("plot4.png", height=480, width=480)

par(mfrow=c(2,2))

#4.1 Global Active Power plot
plot(data_1$DateTime, 
     data_1$Global_active_power, 
     pch=NA, 
     xlab="", 
     ylab="Global Active Power (kilowatts)")
lines(data_1$DateTime, data_1$Global_active_power)

#4.2 Voltage plot
plot(data_1$DateTime, data_1$Voltage, ylab="Voltage", xlab="datetime", pch=NA)
lines(data_1$DateTime, data_1$Voltage)

#4.3 Submetering plot, actuallly it's the same to plot3
plot(data_1$DateTime, 
     data_1$Sub_metering_1, 
     pch=NA, 
     xlab="", 
     ylab="Energy sub metering")
lines(data_1$DateTime, data_1$Sub_metering_1)
lines(data_1$DateTime, data_1$Sub_metering_2, col='red')
lines(data_1$DateTime, data_1$Sub_metering_3, col='blue')
legend('topright', 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       lty = c(1,1,1),
       col = c('black', 'red', 'blue'),
       bty = 'n')

#4.4 Global reactive power plot
with(data_1, plot(DateTime, Global_reactive_power, xlab='datetime', pch=NA))
with(data_1, lines(DateTime, Global_reactive_power))

# Close PNG file
dev.off()
