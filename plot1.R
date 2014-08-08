  #####################################################
  ####### Plot 1
  ####### Global Active Power Histogram
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
  
  ###################################################
  ##      Build Graph
  ###################################################
  ## Set the Output device to a PNG file
  png(file="plot1.png",width=480, height=480)
  
  ## Build the historgram with the appropriate parameters
  hist(data$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")

  ## Close Output device
  dev.off()