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

## Plot #1

png(filename="Plot1.png",width=480,height=480,units="px")
hist(data$Global_active_power,breaks=20,main="Global Active Power",
     xlab = "Global Active Power (kilowatts)",col="red") 
dev.off()

