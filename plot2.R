#reading the data
power <- read.table("household_power_consumption.txt", header = TRUE, 
                    sep = ";", na.strings = "?")

#converting date to YYYY-MM-DD format
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")

#splitting date and time to a single variable
power$date_time <- strptime(paste(power$Date, power$Time), "%Y-%m-%d %H:%M:%S")

#converting date_time variable to POSIXct type
power$date_time <- as.POSIXct(power$date_time)

#subset data of 01.02.2007 to 02.02.2007
power_feb <- subset(power, (Date >= "2007-02-01" & Date <= "2007-02-02"))

#making the plot of Global Active Power during the first two days of February
plot(power_feb$Global_active_power ~ power_feb$date_time, type = "l",  
     xlab = "", ylab = "Global Active Power (kilowatts)")

#copy to png file
dev.copy(png, file = "plot2.png")
dev.off()


