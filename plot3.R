# This code reads the data and generate Plot 3 Energy Sub Metering Line Graphs
# for 2 days

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
png("plot3.png", width = 480, height = 480, units = "px")

## Plots the 3 line graphs
par(mar = c(4,5,2,2))
plot(data$datetime,data$Sub_metering_1,
     type = "n",
     xlab = " ",
     ylab = "Energy sub metering")
lines(data$Sub_metering_1 ~ data$datetime, col = "black")
lines(data$Sub_metering_2 ~ data$datetime, col = "red")
lines(data$Sub_metering_3 ~ data$datetime, col = "blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col = c("black","red","blue"),lty = 1)

## Closes the png file
dev.off()
