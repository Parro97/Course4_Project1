setwd("C:/Users/crist/OneDrive/Escritorio/Curso R/Coursera/Exploratory_Data_Analysis")
#Carga de datos
t <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

## Convertimos en tipo fecha la columna "Date"
t$Date <- as.Date(t$Date, "%d/%m/%Y")

## Filtramos los datos para tener solo del 1 al 2 de febrero
t <- subset(t,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Unimos las columnas date y time
dateTime <- paste(t$Date, t$Time)
dateTime <- setNames(dateTime, "DateTime")
##Quitamos las columnas Date y Time del dataframe
t <- t[ ,!(names(t) %in% c("Date","Time"))]

## Añadimos la columna conjunta del Time-Date
t <- cbind(dateTime, t)
t$dateTime <- as.POSIXct(dateTime)
#PLOT 3
with(t, {
  plot(Sub_metering_1~dateTime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dateTime,col='Red')
  lines(Sub_metering_3~dateTime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))