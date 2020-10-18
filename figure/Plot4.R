dat <- read.table("household_power_consumption.txt", 
                  sep = ";", 
                  header = TRUE, 
                  na.strings = "?")

dat$Date <- as.Date(strptime(as.character(dat$Date), 
                             format = "%d/%m/%Y"))

dat <- subset(dat, Date >= "2007-02-01" & Date <= "2007-02-02")
dat <- dat[complete.cases(dat), ]

dat$Date <- as.POSIXct(paste(dat$Date, dat$Time), format="%Y-%m-%d %H:%M:%S")

df1 <- dat[, c("Date", "Sub_metering_1")]
colnames(df1) <- c("Date", "Sub_metering")
df1$Type <- "red"

df2 <- dat[, c("Date", "Sub_metering_2")]
colnames(df2) <- c("Date", "Sub_metering")
df2$Type <- "blue"

df3 <- dat[, c("Date", "Sub_metering_3")]
colnames(df3) <- c("Date", "Sub_metering")
df3$Type <- "green"

df <- rbind(df1, df2, df3)

png(file="plot4.png",
    width=480, 
    height=480)
par(mfrow=c(2, 2))

plot(x = dat$Date, 
     y = dat$Global_active_power, 
     type = "l", lty = 1,
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

plot(x = dat$Date, 
     y = dat$Voltage, 
     type = "l", lty = 1,
     xlab = "datetime",
     ylab = "Voltage")

with(df1, 
     plot(x = Date, 
          y = Sub_metering, 
          col = "black",
          type = "l", 
          lty = 1,
          xlab = "",
          ylab = "Energy sub metering"))
with(df2, 
     lines(x = Date, 
           y = Sub_metering, 
           col = "red",
           type = "l", 
           lty = 1,
           xlab = "",
           ylab = "Energy sub metering"))
with(df3, 
     lines(x = Date, 
           y = Sub_metering, 
           col = "blue",
           type = "l", 
           lty = 1,
           xlab = "",
           ylab = "Energy sub metering"))

legend(x="topright", legend = c("Sub_metering_1", 
                                "Sub_metering_2", 
                                "Sub_metering_3"), 
       col=c("black","red","blue"), 
       lty=1)

plot(x = dat$Date, 
     y = dat$Global_reactive_power, 
     type = "l", lty = 1,
     xlab = "datetime")

dev.off()
