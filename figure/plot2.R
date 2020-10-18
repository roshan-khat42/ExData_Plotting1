dat <- read.table("household_power_consumption.txt", 
                  sep = ";", 
                  header = TRUE, 
                  na.strings = "?")

dat$Date <- as.Date(strptime(as.character(dat$Date), 
                             format = "%d/%m/%Y"))

dat <- subset(dat, Date >= "2007-02-01" & Date <= "2007-02-02")
dat <- dat[complete.cases(dat), ]


png(file="plot1.png",
    width=480, height=480)
hist(dat$Global_active_power, 
     col = "red", 
     xlab = "Global Active Power (kilowatts)", 
     main = "Global Active Power")
dev.off()
