#####################################################
####### Plot 2
####### Global Active Power over days
#####################################################

## Load libraries
library(sqldf)
library(tcltk)
library(datasets)

####################################################
##        Open File
####################################################

## Set file name - assuming that file was already downloaded and that 
## working directory is already set appropriately
fileName = "household_power_consumption.txt"

## Read the text file and only bring in 2/1/2007 and 2/2/2007
data <- read.csv.sql(fileName, sql = "select * from file where Date in ('1/2/2007','2/2/2007')", sep = ";", header=TRUE)
sqldf() ## Close connection

## Change the Date column to date/time
data$Date <- strptime(paste(data$Date,data$Time), "%d/%m/%Y %H:%M:%S")
  
###################################################
##      Build Graph
###################################################

## Set the Output device to a PNG file
png(file="plot2.png", width=480, height=480)

## Plot the chart with all appropriate parameters
plot(data$Date,data$Global_active_power,"l",xlab="", ylab="Global Active Power (kilowatts)")

## Close Output device
dev.off()