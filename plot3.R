#-------------------------------------------------------------------------------
#
# The source data-containing ZIP file must be available in data directory
#
#       [./data/exdata_data_household_power_consumption.zip]
#
# from which is read the entire ~130MB data file, according to given settings,
#
#       [household_power_consumption.txt]
#
# after which unneeded stuff is removed from memory
#
#-------------------------------------------------------------------------------
#
zipFile <- "./data/exdata_data_household_power_consumption.zip"
data_TXT <- "household_power_consumption.txt"
data <- read.table(unz(zipFile, data_TXT), header = TRUE, sep = ";",
                   na.strings = "?")
remove(zipFile, data_TXT)
#
#-------------------------------------------------------------------------------
#
# The subset of data for 01-02/Feb/2007 is isolated, after which unneeded stuff
# is removed from memory
#
#-------------------------------------------------------------------------------
#
data_TRUE <- (data[,1] == "1/2/2007" | data[,1] == "2/2/2007")
data_subset <- data[data_TRUE,]
remove(data,data_TRUE)
#
#-------------------------------------------------------------------------------
#
# The subsetted data is transformed to an informationally-equivalent timestamped
# data set, after which unneeded stuff is removed from memory
#
#-------------------------------------------------------------------------------
#
temp <- as.POSIXct(paste(data_subset$Date, data_subset$Time),
                   format = "%d/%m/%Y %H:%M:%S")
data_timestamped <- cbind(temp, data_subset[,3:9])
names(data_timestamped)[1] <- "DateTime"
remove(data_subset, temp)
#
#-------------------------------------------------------------------------------
#
# The third of the four requested plots is generated/saved to [plot3.png]
#
#-------------------------------------------------------------------------------
#
png("plot3.png", width = 480, height = 480, units = "px", res = 72)
plot(data_timestamped$DateTime, data_timestamped$Sub_metering_1, type = "n",
     xlab = "", ylab = "Energy sub metering")
lines(data_timestamped$DateTime, data_timestamped$Sub_metering_1, lty = 1,
      col = "black")
lines(data_timestamped$DateTime, data_timestamped$Sub_metering_2, lty = 1,
      col = "red")
lines(data_timestamped$DateTime, data_timestamped$Sub_metering_3, lty = 1,
      col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
#
#-------------------------------------------------------------------------------
#
