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

# Open png file and Setting mfrow parameter
png(filename="plot4.png")
par(mfrow=c(2,2))

# Plot 1
plot(newData$timestamp,newData$Global_active_power,type='l',xlab="",ylab="Global Active Power")

# Plot 2
plot(newData$timestamp,newData$Voltage,type='l',xlab="datetime",ylab="Voltage")

# Plot 3
plot(newData$timestamp,newData$Sub_metering_1,type='l',xlab="",ylab="Energy sub metering")
lines(newData$timestamp,newData$Sub_metering_2,col="red")
lines(newData$timestamp,newData$Sub_metering_3,col="blue")
legend("topright",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,bty="n",cex=0.7)

# Plot 4
plot(newData$timestamp,newData$Global_reactive_power,type='l',xlab="datetime",ylab="Global_reactive_power")
dev.off()