#code for loading Data

library(chron)
col <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
df <- read.table(file = "./household_power_consumption.txt",sep = ";", skip = 1, col.names = col,na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
df$Time <- chron(times = df$Time)
df <- df[(grepl("^2007-02-0[12]", df$Date)),]
row.names(df) <- seq_along(df$Date)

#code for plotting
hist(df$Global_active_power, col = "red", xlab = "Global Active Power (Kilowatts)", main = "Global Active Power")
dev.copy(png, file = "plot1.png",width = 480, height = 480)
dev.off()
