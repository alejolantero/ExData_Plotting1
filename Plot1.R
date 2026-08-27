dataFrame <- read.table("household_power_consumption.txt",
                        sep = ";",
                        header = TRUE,
                        stringsAsFactors = FALSE)
dataFrame$Date <- as.Date(dataFrame$Date, format = "%d/%m/%Y")
dataFrame$Global_active_power <- as.numeric(dataFrame$Global_active_power)
dataFrame$Day_of_week <- weekdays(dataFrame$Date, abbreviate = TRUE )

dataHis <- dataFrame[dataFrame$Date %in% as.Date(c("2007-02-01", "2007-02-02")), ]

while (length(dev.list()) > 1) dev.off()

png("C:/Users/Alejo/Desktop/datasciencecoursera/Exploratory Data Analysis/Project 1/plot1.png",
    width = 480, height = 480)

hist(dataHis$Global_active_power, col = "red", main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()
