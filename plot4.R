#code for loading Data
library(chron)
col <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
df <- read.table(file = "./household_power_consumption.txt",sep = ";", skip = 1, col.names = col,na.strings = "?", colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))
df$Date <- as.Date(df$Date, format = "%d/%m/%Y")
df$Time <- chron(times = df$Time)
df <- df[(grepl("^2007-02-0[12]", df$Date)),]
row.names(df) <- seq_along(df$Date)

#code for plotting
df$DATE <- as.POSIXlt(paste(df$Date, df$Time, sep = " "))

par(mfrow = c(2,2))
#first plot
plot(df$DATE, df$Global_active_power, type = "l", ylab = "Global active power(KiloWatts)", xlab = "")
#second
plot(df$DATE, df$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
#third
plot(df$DATE, df$Sub_metering_1, type = "l", ylab = "Energy Sub Metering", xlab = "")
par(new = TRUE)
plot(df$DATE, df$Sub_metering_2, type = "l", ylab = "", xlab = "", axes = F, ylim = c(0,30), col = "red")
par(new = TRUE)
plot(df$DATE, df$Sub_metering_3, type = "l", ylab = "", xlab = "", axes = F, ylim = c(0,30), col = "blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),col=c("black", "red", "blue"),lty = 1, cex = 0.7)
#fourth
plot(df$DATE, df$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.copy(png, file = "plot4.png", width = 480, height = 480)
dev.off()
