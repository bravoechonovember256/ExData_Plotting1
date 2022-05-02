# Dependencies

install.packages("tidyverse")
install.packages("lubridate")
library(tidyverse)
library(lubridate)

# Download & Unzip Dataset into Working Directory

source <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
hpc <- c("hpc.zip")
download.file(source,destfile=hpc,mode='wb')
unzip(zipfile="./hpc.zip")

# Import Dataset & Filter to Specified Dates

data_all <- read.table("household_power_consumption.txt",sep=";",header=TRUE,
               na.strings="?",colClasses = c("character","character","numeric",
               "numeric","numeric","numeric","numeric","numeric","numeric")) 

data <- as.tibble(data_all) %>%
        mutate(DateTime=paste(Date,Time)) %>%   # Add DateTime column 
        mutate(Date=dmy(Date)) %>%
        mutate(DateTime=strptime(DateTime,"%d/%m/%Y %H:%M:%S")) %>% 
        filter(between(Date, as.Date('2007-02-01'), as.Date('2007-02-02')))

remove(data_all)


## Plot #4
png(filename="Plot4.png",width=480,height=480,units="px")
par(mfrow=c(2,2),mar=c(5,5,2,3))
plot(data$DateTime,data$Global_active_power,type="l",
     xlab="",ylab="Global Active Power (kilowatts)")
plot(data$DateTime,data$Voltage,type="l",
     xlab="datetime",ylab="Voltage")
plot(data$DateTime,data$Sub_metering_1,type="l",xlab="",ylab="Energy Sub Metering")
        lines(data$DateTime,data$Sub_metering_2,type="l",col="red")
        lines(data$DateTime,data$Sub_metering_3,type="l",col="blue")
        legend("topright",c("Sub_Metering_1","Sub_Metering_2","Sub_Metering_3"),
                lty=1,col=c("black","red","blue"))
plot(data$DateTime,data$Global_reactive_power,type="l",
     xlab="datetime",ylab="Global_reactive_power (kilowatts)")
dev.off() 

