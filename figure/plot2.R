dat <- read.table("household_power_consumption.txt", 
                  sep = ";", 
                  header = TRUE, 
                  na.strings = "?")

dat$Date <- as.Date(strptime(as.character(dat$Date), 
                             format = "%d/%m/%Y"))

dat <- subset(dat, Date >= "2007-02-01" & Date <= "2007-02-02")
dat <- dat[complete.cases(dat), ]

dat$Date <- as.POSIXct(paste(dat$Date, dat$Time), format="%Y-%m-%d %H:%M:%S")

png(file="plot2.png",
    width=480, height=480)
plot(x = dat$Date, 
     y = dat$Global_active_power, 
     type = "l", lty = 1,
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
dev.off()
