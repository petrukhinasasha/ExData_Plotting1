#reading the data
power <- read.table("household_power_consumption.txt", header = TRUE, 
                    sep = ";", na.strings = "?")

#converting date to YYYY-MM-DD format
power$Date <- as.Date(power$Date, format = "%d/%m/%Y")

#splitting date and time to a single variable
power$date_time <- strptime(paste(power$Date, power$Time), "%Y-%m-%d %H:%M:%S")

#subset data of 01.02.2007 to 02.02.2007
power_feb <- subset(power, (Date >= "2007-02-01" & Date <= "2007-02-02"))

#making the histogram of Global Active Power frequency
hist(power_feb$Global_active_power, main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red")

#copy to png file
dev.copy(png, file = "plot1.png")
dev.off()
