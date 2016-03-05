## Setting working directory
setwd("./Exploratory_Data_Analysis/Week1/Course_project")

## URL for download
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

## Downloadig file (after checking whether it has been alredy downloaded)
if(!file.exists("data")){dir.create("data")}
if (!file.exists("data/household_power_consumption.txt")) {
        download.file(fileUrl, destfile="./data/UCI_HPC_Dataset.zip", method ="curl")
        
        ##Unzipping archive file to data folder
        unzip("./data/UCI_HPC_Dataset.zip", exdir="data")
        hpc_Data <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
        
}else {
        hpc_Data <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?")
}

#Comverting Date to dateformat
hpc_Data$DateTime = strptime(paste(hpc_Data$Date, hpc_Data$Time), "%d/%m/%Y %H:%M:%S") 
hpc_Data$Date<- as.Date(hpc_Data$Date, format="%d/%m/%Y")


hpc_Data2 <- hpc_Data[(hpc_Data$Date=="2007-02-01") | (hpc_Data$Date=="2007-02-02"),]

##Plottimg in PNG
png(filename = "./ExData_Plotting1/plot4.png", width = 480, height = 480, units = "px", bg = "white")

##Setting 4 graphs
par(mfrow=c(2,2))

with(hpc_Data2, {
        plot(DateTime,Global_active_power, type="l", 
             ylab="Global Active Power", xlab="")
        plot(DateTime,Voltage, type="l", 
             ylab="Voltage", xlab="datetime")
        plot(DateTime,Sub_metering_1, type="l", 
             ylab="Energy Sub metering", xlab="")
        lines(DateTime,Sub_metering_2,col='Red')
        lines(DateTime,Sub_metering_3,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(DateTime,Global_reactive_power, type="l", 
             ylab="Global Rective Power",xlab="datetime")
})


##Closing the device
dev.off()