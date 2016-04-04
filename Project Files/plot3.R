#loading packages
library(data.table)

#creating temporary file to download data
temp<-tempfile()
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,temp,mode="wb")

#We unzip the file in current working directory
unzip(temp,exdir=".")
unlink(temp)

# reading the dataset
data<-fread("household_power_consumption.txt",sep=";",na.strings=c("?"))

# subsetting the dataset
data<-subset(data,Date=="1/2/2007" | Date=="2/2/2007")

# Merging Date and Time and converting into POSIXct format
newData <- transform(data, timestamp=as.POSIXct(paste(Date, Time), tz="","%d/%m/%Y %T"))

# Open png file and plot in the file (size is 480x480 by default)
png(filename="plot3.png")
plot(newData$timestamp,newData$Sub_metering_1,type='l',xlab="",ylab="Energy sub metering")
lines(newData$timestamp,newData$Sub_metering_2,col="red")
lines(newData$timestamp,newData$Sub_metering_3,col="blue")
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1)
dev.off()