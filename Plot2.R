#Plot1.R
#Check to see if data is downloaded 
#if not download data from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
fileName <- "household_power_consumption.zip"
if(! file.exists(fileName)) {
        message("File doesn't exist. Downloading zipped file from the archive")
        fileURL="https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(url=fileURL,destfile=fileName)
}

#Extract the data from zipped file. 
if(! file.exists("household_power_consumption.txt")) {
        message("Extracting the data set files")
        unzip(zipfile=fileName)
}

# Data description is found here https://archive.ics.uci.edu/ml/datasets/Individual+household+electric+power+consumption
# Install required package "sqldf".
#This package allows usage of sql type statements to read only the part of file that is required for the analysis.   
#install.packages("sqldf)
#load sqldf package
library(sqldf)
#Set the file name
file <- "household_power_consumption.txt"
# set dates from 1/2/2007 to 2/2/2007 for SELECT statement
daterange <- "SELECT * from file WHERE Date = '1/2/2007' or Date = '2/2/2007'"
# Read only data that was set in criteria
pdata <- read.csv.sql(file, sql = daterange, sep = ";")
# convert date and time variables to date and time classes using strptime()
pdata$DateTime <- as.POSIXct(strptime(paste(pdata$Date,pdata$Time), "%d/%m/%Y %H:%M:%S"))
# open png graphics devise and set parameters
png(filename = "plot2.png",
    width = 480, 
    height = 480, 
    units = "px", 
    bg = "white")
#make histogram of DateTime vs Global active power
plot(pdata$DateTime, pdata$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (Kilowatts)")
#Close png graphics devise
dev.off()