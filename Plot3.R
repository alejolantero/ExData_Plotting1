dataFrame <- read.table("household_power_consumption.txt",
                        sep = ";",
                        header = TRUE,
                        stringsAsFactors = FALSE)
dataFrame$Date <- as.Date(dataFrame$Date, format = "%d/%m/%Y")
dataFrame$Global_active_power <- as.numeric(dataFrame$Global_active_power)
dataFrame$Day_of_week <- weekdays(dataFrame$Date, abbreviate = TRUE )

dataHis <- dataFrame[dataFrame$Date %in% as.Date(c("2007-02-01", "2007-02-02")), ]

dataHis$Sub_metering_1 <- as.numeric(dataHis$Sub_metering_1)
dataHis$Sub_metering_2 <- as.numeric(dataHis$Sub_metering_2)
dataHis$Sub_metering_3 <- as.numeric(dataHis$Sub_metering_3)
dataHis$datetime <- as.POSIXct(paste(dataHis$Date, dataHis$Time), format = "%Y-%m-%d %H:%M:%S")

xrange <- c(min(dataHis$datetime), min(dataHis$datetime) + as.difftime(2, units = "days"))

while (length(dev.list()) > 1) dev.off()

png("C:/Users/Alejo/Desktop/datasciencecoursera/Exploratory Data Analysis/Project 1/plot3.png",
    width = 480, height = 480)

plot(dataHis$datetime, dataHis$Sub_metering_1, type = "l",
     xlab = "", ylab = "Energy sub metering",
     xaxt = "n", xlim = xrange, col = "black")

lines(dataHis$datetime, dataHis$Sub_metering_2, col = "red")
lines(dataHis$datetime, dataHis$Sub_metering_3, col = "blue")
axis.POSIXct(1, at = seq(xrange[1], xrange[2], by = "day"), format = "%a")
legend("topright", col = c("black", "red", "blue"), lty = 1,
legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()