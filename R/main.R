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

p840$items %>% is.vector()

items_by_type <- p840$props$p31 %>% 
  as.data.frame() %>% 
  select(item = V1, type = V2, p31 = V3) %>%
  group_by(p31) %>% 
  dplyr::summarise(n=n()) %>% 
  arrange(desc(n))

get_item(id = 11424)

lieux <- p840$props$p840 %>% 
  as.data.frame() %>%
  select(item = V1, type = V2, lieu = V3) %>%
  group_by(lieu) %>% 
  dplyr::summarise(n = n()) %>%
  arrange(-n) 

# lieux_geocod <- ldply(lieux$lieu[1:100], get_latlon, .progress = "text")
# lieux_geocod %>% 
#   leaflet() %>%
#   addTiles() %>% 
#   addCircleMarkers(~longitude, ~latitude, 
#                    clusterOptions = markerClusterOptions(), 
#                    stroke = FALSE, fillOpacity = 0.5, 
#                    popup = ~as.character(lieu))



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



