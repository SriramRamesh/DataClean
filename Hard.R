library("rgbif")
library("sp")
library("maps")       # Provides functions that let us plot the maps
library("mapdata")
library("ggplot2")
library("ggmap")
library("geosphere")
isEmpty <- function(x) {
    return(length(x)==0)
}
getData <- function(species,N){
  key <- name_backbone(name = species, rank = 'species')$usageKey
  df <- data.frame( (occ_data(taxonKey = key, limit = N))$data)
  return(df)
}
getCentroid <- function(countryName,df){
  # Get centroid data from Google developeres
  dat <- read.csv("Countries.csv", header = TRUE)
  lat <- dat$latitude[dat$name==countryName]
  lon <- dat$longitude[dat$name==countryName]
  if(!isEmpty(lat)&&!isEmpty(lon)){
    lat <- round(lat,2)
    lon <- round(lon,2)
    return( c(lon,lat))
  }
  else{
    return(numeric(0))
  }
}

# TODO:Get data for various species
#species <- "Helianthus annuus"
PlotCountryCenter<-function(speciesList){
  for(species in speciesList){
    GBIFdata <- getData(species,1000)
    print("successful data")
    CountriesList<-unique(GBIFdata$country)
    print(CountriesList)
    # world_map <- map_data("world")
    # map_data <- base_world + geom_point(data=GBIFdata,aes(x=decimalLongitude, y=decimalLatitude), colour="Deep Pink",fill="Pink",pch=21, size=5, alpha=I(0.7))
    for ( c in CountriesList ){
      print(c)
      centroid <- getCentroid(c)
      print("centroid:")
      print(centroid)
      lat <- GBIFdata$decimalLatitude[GBIFdata$country==c]
      lon <- GBIFdata$decimalLongitude[GBIFdata$country==c]
      Coord <- data.frame(lon, lat)
      Coord <- Coord[!is.na(Coord$lat),]
      Coord <- Coord[!is.na(Coord$lon),]
      Coord$Dist <- distGeo(Coord[1:nrow(Coord),],centroid)/1000
      SCoord <- Coord[order(Coord$Dist),]
      SCoord <- SCoord[SCoord$Dist<100,]
      # SCoord<-SCoord[SCoord$Dist<100]
      # print(SCoord)
      if(!isEmpty(SCoord)){
        hdf <- get_map(c,zoom=5)
        Fig <- ggmap(hdf)+geom_point(data=SCoord)
        # ggsave(Fig,filename=paste(c,".png",sep=""))
        print(Fig)
        # dev.off()
        # if(c=="United States"){ c<- "US"}
        # if(c=="United Kingdom"){ c<- "Uk"}
        # CountryMap <- subset(world_map, world_map$region==c)
        # map('worldHires',c)
        # points(SCoord$Lon,SCoord$Lat)
      }
    }
  }
}
PlotCountryCenter("Helianthus annuus")
