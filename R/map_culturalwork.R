# 
# map_culturalwork <- df_culturalwork %>% 
#   filter(is.na(longitude) == FALSE) %>% 
#   leaflet() %>%
#   addProviderTiles("CartoDB.Positron") %>%
#   setView(lng = 2, lat = 47, zoom = 6) %>% 
#   addCircleMarkers(~longitude, ~latitude,  
#                    stroke = FALSE, fillOpacity = 0.5, 
#                    popup = ~paste0(as.character(culturalwork))
#   )
# 
# 
# saveWidget(map_culturalwork, 
#            file = "~/Documents/perso/mapfiction/html/map_culturalwork.html", 
#            selfcontained = TRUE)
