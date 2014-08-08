#####################################################
####### Plot 3
####### Energy Sub Metering over days
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
png(file="plot3.png",width=480, height=480)

## Build the chart with first measure
plot(data$Date,data$Sub_metering_1,"l",xlab="", ylab="Energy Sub Metering", col="black")
## add onto the chart with the second measure
with(data,points(Date,Sub_metering_2,"l",col="red"))
## add onto the chart with the third measure
with(data,points(Date,Sub_metering_3,"l",col="blue"))
## Add the legend
legend("topright",lty=c(1,1),col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

## Close the Output device
dev.off()