
load("data/df_location.Rda")

map_location <- df_location %>% 
  leaflet() %>%
  addTiles() %>%
  setView(lng = 2, lat = 47, zoom = 4) %>% 
  addCircleMarkers(~longitude, ~latitude, 
                   stroke = FALSE, fillOpacity = 0.5, 
                   popup = ~paste0(as.character(frlabel), 
                                   " :", as.character(n)))

saveWidget(map_location, 
           file = "~/Documents/perso/mapfiction/html/map_location.html", 
           selfcontained = TRUE)


get_item(id = 142) %>% get_latlon()


library(ggmap)

ggmap() + 
  geom_point(data = map_location, 
             mapping = aes(x = longitude, y = latitude)) 