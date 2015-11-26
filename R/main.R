library("jsonlite")
library("readr")
library("magrittr")
library("dplyr")
library("WikidataR")
library("plyr")
library("leaflet")
library("scales")

p840 <- read_lines("p840.json") %>% fromJSON()
names(p840$props) %<>% paste0("p", .)

lieux <- p840$props$p840 %>% 
  as.data.frame() %>%
  select(item = V1, type = V2, lieu = V3) %>%
  group_by(lieu) %>% 
  dplyr::summarise(n = n()) %>%
  arrange(-n) 

get_latlon <- function(id) {
  item <- get_item(id = id) 
  if (is.null(item$claims$P625) == TRUE) {
    latitude <- NA
    longitude <- NA
  }
  else {
    latitude <- item$claims$P625$mainsnak$datavalue$value$latitude
    longitude <- item$claims$P625$mainsnak$datavalue$value$longitude
    }
  message(paste0("lieu :", id))
  return(data.frame(lieu=id, latitude=latitude, longitude=longitude))
  }

#get_latlon(id=84)
get_latlon(id=1999)


get_details <- function(id) {
  message(paste0("lieu :", id))
  item <- get_item(id = id) 
  if (is.null(item$labels$fr) == TRUE) {
    frlabel = ""
  } else {
    frlabel = item$labels$fr$value
  }
  if (is.null(item$claims$P625) == TRUE) {
    latitude <- NA
    longitude <- NA
  }
  else {
    latitude <- item$claims$P625$mainsnak$datavalue$value$latitude
    longitude <- item$claims$P625$mainsnak$datavalue$value$longitude
  }
  return(data.frame(lieu=id, frlabel = frlabel, 
                    latitude=latitude, longitude=longitude))
}


get_details(id = 60)
item <- get_item(id = 405)
item$labels$fr$value

item$claims$P625
lieux_geocod <- ldply(lieux$lieu[1:100], get_latlon, .progress = "text")

lieux_geocod %>% 
  leaflet() %>%
  addTiles() %>% 
  addCircleMarkers(~longitude, ~latitude, 
                   clusterOptions = markerClusterOptions(), 
                   stroke = FALSE, fillOpacity = 0.5, 
                   popup = ~as.character(lieu))

lieux_details <- ldply(lieux$lieu[1:500], get_details, .progress = "text")
lieux_details %<>% left_join(lieux, by = "lieu")

lieux_details %>% 
  leaflet() %>%
  addTiles() %>% 
  addCircleMarkers(~longitude, ~latitude, radius = ~rescale(n), 
                   clusterOptions = markerClusterOptions(), 
                   stroke = FALSE, fillOpacity = 0.5, 
                   popup = ~paste0(as.character(frlabel), 
                                   " :", as.character(n)))



items <- p840$props$p840 %>% 
  as.data.frame() %>%
  select(item = V1, type = V2, lieu = V3)

items_geocode <- left_join(items, lieux_geocod, by = "lieu")  

items_geocode %>% 
  leaflet() %>%
  addTiles() %>% 
  addCircleMarkers(~longitude, ~latitude, 
                   color = "navy", 
                   clusterOptions = markerClusterOptions(), 
                   stroke = FALSE, fillOpacity = 0.5)



