#####################################################
####### Plot 4
####### Plot Matrix
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
png(file="plot4.png", width=480, height=480)

par(mfrow = c(2,2))  ## Setup a 2x2 matrix to hold the charts
with(data, {
  
  ## Plot 1
  plot(data$Date,data$Global_active_power,"l",xlab="", ylab="Global Active Power")
  
  ## Plot 2
  plot(data$Date,data$Voltage,"l",xlab="datetime", ylab="Voltage")
  
  ## Plot 3
  plot(data$Date,data$Sub_metering_1,"l",xlab="", ylab="Energy Sub Metering", col="black")
  with(data,points(Date,Sub_metering_2,"l",col="red"))
  with(data,points(Date,Sub_metering_3,"l",col="blue"))
  legend("topright",lty=c(1,1), bty="n", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
  
  ## Plot 4
  plot(data$Date,data$Global_reactive_power,"l",xlab="datetime", ylab="Global_reactive_power")      
  
})

## Close Output Device
dev.off()