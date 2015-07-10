#############################################
#### GRAPH PRODUCER - PLOT FOUR ##############
#############################################

#This code produces a replica of Plot 4 as partially
#fulfulment of Project 1 in the Exploratory Data
#Analysis course in the Data Science Course

#produced in July 2015 by Timothy Wilson

#Note that this code uses the dplyr package

#---------- STEP ONE: Load the data ------------#


#The data can be downloaded from: https://d396qusza40orc.cloudfront.net/exdata
#%2Fdata%2Fhousehold_power_consumption.zip

#NOTE THAT YOU MUST SAVE YOUR DATA INTO THE WORKING DIRECTORY
#or set the working directory accordingly

#load the required packages

library(dplyr)
library(lubridate)

#Note that we are only loading data for the first two days
#of February 2006 because this is the data that we wish to graph.


data <- tbl_df(read.table("household_power_consumption.txt",
                          sep = ";",
                          skip = 66637,
                          nrows = 2880,
                          header = FALSE
))


colnames(data) <- c("Date", "Time",
                    "Global_active_power",
                    "Global_reactive_power",
                    "Voltage",
                    "Global_intensity",
                    "Sub_metering_1",
                    "Sub_metering_2",
                    "Sub_metering_3")

data <- mutate(data, Time_Full = paste(Date, Time))
data <- mutate(data, Time_Full = dmy_hms(Time_Full))


#---------- STEP TWO: Generate and save the graph ---------#

png("plot4.png")
par(mfrow = c(2,2))


with(data, {
        
#-- Graph for top left      
plot(Time_Full, Global_active_power,type = "l",ylab = "Global Active Power",
               xlab ="")
               
#-- Graph for top right      
plot(Time_Full, Voltage,type = "l", ylab = "Voltage", xlab = "")
 
#-- Graph for bottom left
plot(Time_Full, Sub_metering_1, type = "n", 
     ylab = "Energy sub metering",
     xlab = "")
 
 legend("topright", pch = "-", col = c("black","red","blue"),
       legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
       cex = 0.75, bty = "n")

 points(Time_Full, Sub_metering_1,type = "l",
               col = "black")

 points(Time_Full, Sub_metering_2,
                 col = "red",
                 type = "l")        

 points(Time_Full, Sub_metering_3,
                 col = "blue",
                 type = "l")

 
#-- Graph for bottom right

plot(Time_Full, Global_reactive_power,type = "l",
     ylab = "Global_reactive_power",
     xlab = "datetime")
             
})

dev.off()
