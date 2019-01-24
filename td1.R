library("chron")
library("lubridate")
library("igraph")
library("network")
library(readr)
beaconData_2017_04_03To2017_04_30 <- read_delim("~/Documents/M2/innovation/beaconData_2017-04-03To2017-04-30.csv", 
                                                ";", escape_double = FALSE, trim_ws = TRUE)
View(beaconData_2017_04_03To2017_04_30)

Euralille_Totems_DistMatrix <- read_delim("~/Documents/M2/innovation/Euralille_Totems_DistMatrix.csv", 
                                          +     ";", escape_double = FALSE, col_names = FALSE, 
                                          +     trim_ws = TRUE)

beaconData=beaconData_2017_04_03To2017_04_30
Euralille=Euralille_Totems_DistMatrix

getPath <- function(deviceId, beaconData){
  deviceIds=as.vector((beaconData[,"device_uid"]))
  
  extractedPoints= data.frame(beaconData[which(deviceIds==deviceId), c("Day","Hour","BeaconId")])
  
  deviceIdPath=data.frame("Timestamp"= as.POSIXct(paste(as.character(as.Date(strptime(extractedPoints[,"Day"],"%Y-%m-%d"))),extractedPoints[,"Hour"],sep=" "),tz="GMT"),"Totem"=extractedPoints[,3])

  return (deviceIdPath[order(deviceIdPath[,"Timestamp"]),])
}

myPath= getPath("9615467a7be2f180CB512BMU4S", beaconData)
print(myPath[1:5,])
