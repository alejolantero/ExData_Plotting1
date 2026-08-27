dataFrame <- read.table("household_power_consumption.txt",
                        sep = ";",
                        header = TRUE,
                        stringsAsFactors = FALSE)
dataFrame$Date <- as.Date(dataFrame$Date, format = "%d/%m/%Y")
dataFrame$Global_active_power <- as.numeric(dataFrame$Global_active_power)
dataFrame$Day_of_week <- weekdays(dataFrame$Date, abbreviate = TRUE )

dataHis <- dataFrame[dataFrame$Date %in% as.Date(c("2007-02-01", "2007-02-02")), ]

dataHis$Voltage <- as.numeric(dataHis$Voltage)
dataHis$Global_reactive_power <- as.numeric(dataHis$Global_reactive_power)

while (length(dev.list()) > 1) dev.off()

dataHis$datetime <- as.POSIXct(paste(dataHis$Date, dataHis$Time), format = "%Y-%m-%d %H:%M:%S")
xrange <- c(min(dataHis$datetime), min(dataHis$datetime) + as.difftime(2, units = "days"))

png("C:/Users/Alejo/Desktop/datasciencecoursera/Exploratory Data Analysis/Project 1/plot4.png",
    width = 480, height = 480)

par(mfrow = c(2, 2))

plot(dataHis$datetime, dataHis$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power", xaxt = "n", xlim = xrange)
axis.POSIXct(1, at = seq(xrange[1], xrange[2], by = "day"), format = "%a")

plot(dataHis$datetime, dataHis$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage", xaxt = "n", xlim = xrange)
axis.POSIXct(1, at = seq(xrange[1], xrange[2], by = "day"), format = "%a")

plot(dataHis$datetime, dataHis$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering", xaxt = "n", xlim = xrange, col = "black")
lines(dataHis$datetime, dataHis$Sub_metering_2, col = "red")
lines(dataHis$datetime, dataHis$Sub_metering_3, col = "blue")
axis.POSIXct(1, at = seq(xrange[1], xrange[2], by = "day"), format = "%a")
legend("topright", col = c("black", "red", "blue"), lty = 1, bty = "n", cex = 0.7,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

plot(dataHis$datetime, dataHis$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power", xaxt = "n", xlim = xrange)
axis.POSIXct(1, at = seq(xrange[1], xrange[2], by = "day"), format = "%a")

dev.off()