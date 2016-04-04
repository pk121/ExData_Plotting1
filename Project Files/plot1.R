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

# Open png file and plot to the file (size is 480x480 by default)
png(filename="plot1.png")
hist(data$Global_active_power,col="red",main="Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()