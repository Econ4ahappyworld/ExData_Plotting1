#############################################
#### GRAPH PRODUCER - PLOT ONE ##############
#############################################

#This code produces a replica of Plot 1 as partially
#fulfulment of Project 1 in the Exploratory Data
#Analysis course in the Data Science Course

#produced in July 2015 by Timothy Wilson

#Note that this code uses the dplyr package

#---------- STEP ONE: Load the data ------------#


#The data can be downloaded from: https://d396qusza40orc.cloudfront.net/exdata
#%2Fdata%2Fhousehold_power_consumption.zip

#Note that the data must be saved into the working directory

#load the required packages

library(dplyr)
library(lubridate)

##NOTE TO TIM - DELETE BEFORE SUBMITTING

setwd("c:/Users/twilson/Desktop/R/R_Crse/4exp/proj1")

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
data <- mutate(data, Time_Full = ymd_hms(Time_Full))

#---------- STEP TWO: Generate and save the graph ---------#

png("plot1.png")

hist(data$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.off()

