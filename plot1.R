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
# The first of the four requested plots is generated/saved to [plot1.png]
#
#-------------------------------------------------------------------------------
#
png("plot1.png", width = 480, height = 480, units = "px", res = 72)
hist(data_timestamped$Global_active_power,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)",
     col = "orangered")
dev.off()
#
#-------------------------------------------------------------------------------
#
