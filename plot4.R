# This code reads the data and generate Plot 4 which is a combination of
# 4 Graphs

## Reading data from 1/2/2007 00:00:00 to 3/2/2007 00:00:00
data<-read.table("household_power_consumption.txt",
                 header = FALSE,
                 sep = ";",
                 stringsAsFactors = FALSE,
                 col.names = c("Date","Time","Global_active_power",
                               "Global_reactive_power","Voltage",
                               "Global_intensity","Sub_metering_1",
                               "Sub_metering_2","Sub_metering_3"),
                 na.strings = "?",
                 colClasses = c("character","character","numeric","numeric",
                                "numeric","numeric","numeric","numeric",
                                "numeric"),
                 skip = grep("^31/1/2007;23:59:00", ##skips lines including this
                             readLines("household_power_consumption.txt")),
                 nrows = 2881)  ## 2881 corresponds to the number of minutes
                                ## from 1/2/2007 00:00:00 to 3/2/2007 00:00:00

## Adding "datetime" column with date/time class
data$datetime <- as.POSIXct(paste(data$Date,data$Time),
                            format="%d/%m/%Y %H:%M:%S")

## Creates png file
png("plot4.png", width = 480, height = 480, units = "px")

## Sets the parameters
par(mar = c(5,5,2,1), mfrow = c(2,2))

## Plots the 1st graph
plot(data$datetime,data$Global_active_power,
     type = "l",
     xlab = " ",
     ylab = "Global Active Power")

## Plots the 2nd graph
plot(data$datetime,data$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")

## Plots the 3rd graph
plot(data$datetime,data$Sub_metering_1,
     type = "n",
     xlab = " ",
     ylab = "Energy sub metering")
lines(data$Sub_metering_1 ~ data$datetime, col = "black")
lines(data$Sub_metering_2 ~ data$datetime, col = "red")
lines(data$Sub_metering_3 ~ data$datetime, col = "blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),lty = 1,bty = "n")

## Plots the 4th graph
plot(data$datetime,data$Global_reactive_power,
     type = "l",
     xlab = "datetime",
     ylab = "Global_reactive_power")

## Closes the png file
dev.off()
