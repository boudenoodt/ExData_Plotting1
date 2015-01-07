## Remarks
##     --> resolution of the png images is 480 x 480 as asked for 
##         in the assignment (in contradiction with the coursera examples 504x 504)
##     --> in the two dates involved there are no "?" marks but nevertheless I added code
##         to replace them with NA and than delete the rows with an NA value in it (just in case..)
##     --> png created from scratch but code is added in comment to create the png from the screen device 


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

## getting the max Y scale and showing on the screen if not comment out
ymax<-max(DS$Sub_metering_1,DS$Sub_metering_2,DS$Sub_metering_3)  
plot (DS$DateTime,DS$Sub_metering_1,ylim=c(0,ymax),cex.lab=0.9,xlab="",ylab="Energy sub metering",type="l",col="black")
par(new=TRUE)
plot (DS$DateTime,DS$Sub_metering_2,ylim=c(0,ymax),cex.lab=0.9,xlab="",ylab="Energy sub metering",type="l",col="red")
par(new=TRUE)
plot (DS$DateTime,DS$Sub_metering_3,ylim=c(0,ymax),cex.lab=0.9,xlab="",ylab="Energy sub metering",type="l",col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=1,col=c("black","red","blue"),lty=1)

## To save the plot from the screen device uncomment the following code and put the following section in comment
## dev.copy(png,"plot3.png", width=480, height=480,units="px")
## dev.off()

## saving to a png file
png('plot3.png',width = 480, height = 480, units = "px")
plot (DS$DateTime,DS$Sub_metering_1,ylim=c(0,ymax),cex.lab=0.9,xlab="",ylab="Energy sub metering",type="l",col="black")
par(new=TRUE)
plot (DS$DateTime,DS$Sub_metering_2,ylim=c(0,ymax),cex.lab=0.9,xlab="",ylab="Energy sub metering",type="l",col="red")
par(new=TRUE)
plot (DS$DateTime,DS$Sub_metering_3,ylim=c(0,ymax),cex.lab=0.9,xlab="",ylab="Energy sub metering",type="l",col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=1,col=c("black","red","blue"),lty=1)
dev.off()
