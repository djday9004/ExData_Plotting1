## Download the power consumption data file

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, destfile = "./consumption.zip")

## Read the household_power_consumption.txt file contained within the zip file into a data frame. Specifiy that
## the entries are separated by ";" and that NA's are represented by a "?"

power <- read.table(unz("consumption.zip", "household_power_consumption.txt"), header = TRUE, sep = ";", na.strings = "?")

## Concatentnate the Date and Time variables and store the result into a character variable called datetime

power$datetime <- paste(power$Date, power$Time)

## Convert the datetime variable from character to Date format

power$datetime <- strptime(power$datetime, "%d/%m/%Y %H:%M:%S")

## subset the dataframe so the results only include data from 02/02/2007 and 02/03/2007

select_power <- subset(power, datetime >= "2007-02-01" & datetime < "2007-02-03")

## Open the PNG graphics device

png("plot3.png")

## Construct the framework for the desired graph with only a y-axis label

plot(select_power$datetime, select_power$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n")

## Add the lines portion of the graph for each sub metering level

lines(select_power$datetime, select_power$Sub_metering_1)

lines(select_power$datetime, select_power$Sub_metering_2, col = "red")

lines(select_power$datetime, select_power$Sub_metering_3, col = "blue")

## Add the legend

legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Close the graphics device

dev.off()