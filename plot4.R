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

png("plot4.png")

## Establish a 2x2 graph structure for the desired plots, filling the rows first

par(mfrow = c(2, 2))

## Construct the upper-left graph, Global_active_power versus datetime

with(select_power, plot(datetime, Global_active_power, xlab = "", ylab = "Global Active Power (kilowatts)", type = "n"))
with(select_power, lines(datetime, Global_active_power))

## Construct the upper-right graph, Voltage versus datetime

with(select_power, plot(datetime, Voltage, type = "n"))
with(select_power, lines(datetime, Voltage))

## Construct the lower-left graph, all three submetering levels versus datetime complete with legend

with(select_power, plot(datetime, Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "n"))
with(select_power, lines(datetime, Sub_metering_1))
with(select_power, lines(datetime, Sub_metering_2, col = "red"))
with(select_power, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##Construct the lower-right graph, Global_reactive_power versus datetime

with(select_power, plot(datetime, Global_reactive_power, type = "n"))
with(select_power, lines(datetime, Global_reactive_power))

## Close the graphics device

dev.off()