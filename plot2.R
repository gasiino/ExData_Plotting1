### plot2.R 
### code to create plot2.png
### NOTE: this scripts expects the file household_power_consumption.txt to be available on the same wrking directory as it runs
### if the file is not existing in the current directory an attempt to download and unzip is done

## using  library data.table 
library(data.table)

# if txt file and zip file are not here, attempt to download the zip file
if(!file.exists("household_power_consumption.zip") && !file.exists("household_power_consumption.txt")) { 
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",destfile = "household_power_consumption.zip",mode = "wb") 
}
# if txt file is not here but zip file is available, attempt to unzip the zip file here
if(file.exists("household_power_consumption.zip") && !file.exists("household_power_consumption.txt")) { 
  unzip("household_power_consumption.zip") 
}
## read whole txt file, then select only the rows using %like% and regex on Date column to get only 1 feb and 2 feb 2007
dt<-fread("household_power_consumption.txt", header=TRUE, na.strings="?", sep = ";")[Date %like% "^[0]{0,1}[12]/[0]{0,1}2/2007"]

## add column with datetime 
dt$DateTime<-as.POSIXct(strptime(paste(dt$Date,dt$Time,Sep=" "),format="%d/%m/%Y %H:%M:%S"))

## remove Date and Time columns
dt[,Date := NULL]
dt[,Time := NULL]

## create png file with desired size
png(filename="plot2.png", width=480, height=480, units="px")

## add plot 
with(dt, plot(DateTime, Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))

## close device and save file
dev.off()

