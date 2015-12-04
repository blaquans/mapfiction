
load("data/df_location.Rda")

map_location <- df_location %>% 
  filter(is.na(longitude) == FALSE) %>% 
  leaflet() %>%
  addTiles() %>%
  setView(lng = 2, lat = 47, zoom = 4) %>% 
  addCircleMarkers(~longitude, ~latitude, 
                   stroke = FALSE, fillOpacity = 0.5, 
                   popup = ~paste0(as.character(frlabel), 
                                   " :", as.character(n)))

map_location
saveWidget(map_location, 
           file = "~/Documents/perso/mapfiction/html/map_location.html", 
           selfcontained = TRUE)


df_location %>% 
  ggplot() + 
  geom_point(mapping = aes(x = longitude, y = latitude)) 