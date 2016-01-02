load("data/df_location.Rda")
pal <- colorBin(palette = "PRGn", 
         bins = c(0,5,10,20,50,100,1000), 
         pretty = TRUE, 
         na.color = "#808080",
         alpha = FALSE)


map_location <- df_location %>% 
  filter(is.na(longitude) == FALSE) %>% 
  leaflet() %>%
  addProviderTiles("CartoDB.Positron") %>%
#  addTiles() %>%
  setView(lng = 2, lat = 47, zoom = 6) %>% 
  addCircleMarkers(~longitude, ~latitude, color = ~pal(n), 
                   stroke = FALSE, fillOpacity = 0.5, 
                   popup = ~paste0(as.character(frlabel), 
                                   " :", as.character(n)))

map_location
saveWidget(map_location, 
           file = "~/Documents/perso/mapfiction/html/map_location.html", 
           selfcontained = TRUE)


