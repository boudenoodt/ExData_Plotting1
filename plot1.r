## check if package is installed and loaded if not install and load the package "sqldf"
if (!("sqldf" %in% rownames(installed.packages()))){install.packages("sqldf")}
if (!("sqldf" %in% loadedNamespaces())){library(sqldf)}
## read the data from the file using a select statement 
##      limiting the import of the data to 1 & 2 /2/2007
##      using the separator ";"
DS <- read.csv.sql("./exdata_data_household_power_consumption/household_power_consumption.txt",sep=";", sql = 'select * from file where Date == "1/2/2007" or  Date == "2/2/2007"')
## clean up the data 
##      replace "?" in every possible column with NA
##      delete every row with  NA in it
##      add a variable/column with the combined vaues of Date and Time naming  it "DataTime"  
DS[DS=="?"]<-NA
DS<-na.omit(DS)
DS[["DateTime"]]<-strptime(paste(DS$Date,DS$Time),"%e/%m/%Y %H:%M:%S")

## showing on the screen if not comment out
hist(DS$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",ylab="Frequency",col="red",cex.lab=0.9,cex.main=1.1)

## saving to a png file
png('plot1.png',width = 480, height = 480, units = "px")
hist(DS$Global_active_power,main="Global Active Power",xlab="Global Active Power (kilowatts)",ylab="Frequency",col="red",cex.lab=0.9,cex.main=1.1)
dev.off()