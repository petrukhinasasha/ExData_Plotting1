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

#making space for four graphs
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))

#making the first plot, which shows Global Active Power change during the first two days of February
with(power_feb,
     plot(power_feb$Global_active_power ~ power_feb$date_time, type = "l",  
          xlab = "", ylab = "Global Active Power"))

#making the second plot, which shows Voltage change during the first two days of February
with(power_feb,
     plot(power_feb$Voltage ~ power_feb$date_time, type = "l",  
          xlab = "datetime", ylab = "Voltage"))

#making the third plot, which shows the three Energy sub metering change during the first two days of February
with(power_feb, {
        plot(Sub_metering_1 ~ date_time, type = "l", xlab = "",
             ylab = "Energy sub metering")
        lines(Sub_metering_2 ~ date_time, col = "red")
        lines(Sub_metering_3 ~ date_time, col = "blue")
        legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2,
               bty = "n", 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

#making the fourth plot, which shows Global reactive power change during the first two days of February
with(power_feb,
     plot(power_feb$Global_reactive_power ~ power_feb$date_time, type = "l",  
          xlab = "datetime", ylab = "Global_reactive_power"))

#copy to png file
dev.copy(png, file = "plot4.png")
dev.off()


