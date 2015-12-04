

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

df_location <- p840$props$p840 %>% 
  as.data.frame(stringsAsFactors = FALSE) %>%
  select(item = V1, type = V2, lieu = V3) %>%
  group_by(lieu) %>% 
  dplyr::summarise(n = n()) %>%
  arrange(-n) 


list_location_details <- llply(lieux$lieu, get_item, 
                               .progress = "text", 
                               .inform = TRUE)

save(list_location_details, file = "data/list_location_details.Rda")

lieux_details <- llply(lieux$lieu[1:100], get_item, .progress = "text")
names(lieux_details) <- paste0("Q", lieux$lieu[1:100])
save(lieux_details, file = "data/lieux_details.Rda")

load("data/lieux_details.Rda")
lieux$.id <- paste0("Q", lieux$lieu)
lieux_details[[1]]$labels$fr$value

source("R/get_frenchlabel.R")
lieux_label <- ldply(lieux_details, get_frenchlabel)
lieux %<>% left_join(lieux_label, id = ".id")

source("R/get_latlon.R")
lieux_latlon <- ldply(lieux_details, get_latlon)
lieux %<>% left_join(lieux_latlon, id = ".id")

mapfiction1 <- lieux %>% 
  leaflet() %>%
  addTiles() %>% 
  addCircleMarkers(~longitude, ~latitude, 
                   clusterOptions = markerClusterOptions(), 
                   stroke = FALSE, fillOpacity = 0.5, 
                   popup = ~paste0(as.character(frlabel), 
                                   " :", as.character(n)))

saveWidget(mapfiction1, 
           file = "~/Documents/paulant/mapfiction/html/mapfiction1.html", 
           selfcontained = TRUE)

items <- p840$props$p840 %>% 
  as.data.frame(stringsAsFactors = FALSE) %>%
  select(item = V1, type = V2, lieu = V3)
items %<>% left_join(lieux, by = "lieu")  

mapfiction2 <- items %>% 
  leaflet() %>%
  addTiles() %>% 
  addCircleMarkers(~longitude, ~latitude, 
                   color = "navy", 
                   clusterOptions = markerClusterOptions(), 
                   stroke = FALSE, fillOpacity = 0.5, 
                   popup = ~paste0(as.character(item), ": ", 
                                   as.character(frlabel)))

saveWidget(mapfiction2, 
           file = "~/Documents/paulant/mapfiction/html/mapfiction2.html", 
           selfcontained = TRUE)


dt_items <- datatable(items)
saveWidget(dt_items,
           file = "~/Documents/paulant/mapfiction/html/dt_items.html", 
           selfcontained = TRUE)

