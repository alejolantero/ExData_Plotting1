dataFrame <- read.table("household_power_consumption.txt",
                        sep = ";",
                        header = TRUE,
                        stringsAsFactors = FALSE)
dataFrame$Date <- as.Date(dataFrame$Date, format = "%d/%m/%Y")
dataFrame$Global_active_power <- as.numeric(dataFrame$Global_active_power)
dataFrame$Day_of_week <- weekdays(dataFrame$Date, abbreviate = TRUE )

dataHis <- dataFrame[dataFrame$Date %in% as.Date(c("2007-02-01", "2007-02-02")), ]
dataHis$datetime <- as.POSIXct(paste(dataHis$Date, dataHis$Time), format = "%Y-%m-%d %H:%M:%S")

while (length(dev.list()) > 1) dev.off()

png("C:/Users/Alejo/Desktop/datasciencecoursera/Exploratory Data Analysis/Project 1/plot2.png",
    width = 480, height = 480)

xrange <- c(min(dataHis$date), min(dataHis$date) + as.difftime(2, units = "days"))

plot(dataHis$date, dataHis$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)",
     xaxt = "n", xlim = xrange)
axis.POSIXct(1, at = seq(xrange[1], xrange[2], by = "day"), format = "%a")

dev.off()
