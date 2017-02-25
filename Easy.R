#Importing data from rgbif and plotting using mapr

library("spocc")
library("sp")
library('mapr')
library('rgbif')
dataset_suggest(country="India") #to suggest datasets from India
#res <- occ_search(mediaType = 'StillImage', return = "media")
#gbif_photos(res)
#occ_data(continent = 'south_america', limit = 20)$meta

#Helianthus annuus
key <- name_suggest(q='Helianthus annuus', rank='species')$key[1] #suggests names
occ_search(taxonKey=key[1], limit=2)

#Ursus americanus
key <- name_backbone(name = 'Ursus americanus', rank='species')$usageKey #searches from gbif backbone taxonomy
occ_search(taxonKey = key)

#remove desc
#out <- name_lookup('Helianthus annuus', rank="species", verbose=TRUE)
#lapply(out$data, function(x) x[!names(x) %in% c("descriptions","descriptionsSerialized")])
#head(out)
#head(out$data)

#Load data of various species
key <- name_backbone(name = 'Ursus americanus', rank='species')$usageKey
Uru<-occ_data(taxonKey=key,limit=1000)
head(Uru)


key <- name_backbone(name = 'mammalia', rank='species')$usageKey
Mamm<-occ_data(taxonKey=key,limit=1000)
head(Mamm)

key <- name_backbone(name = 'Aves'), rank='species')$usageKey
Aves<-occ_data(taxonKey=key,limit=1000)
head(Aves)

#Plotting Puma concolor
res <- occ_search(scientificName = "Puma concolor", limit = 100)
map_leaflet(res)


#Multiple species
spp <- c('Danaus plexippus', 'Accipiter striatus', 'Pinus contorta')
dat <- occ(spp, from = 'gbif', limit = 50, has_coords = TRUE)
map_leaflet(dat)
map_leaflet(dat, color = c('#AFFF71', '#AFFF71', '#AFFF71'))
map_leaflet(dat, color = c('#976AAE', '#6B944D', '#BD5945'))
