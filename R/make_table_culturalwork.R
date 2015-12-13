p840 <- read_lines("p840.json") %>% fromJSON()
names(p840$props) %<>% paste0("p", .)
df_culturalwork <- data_frame(culturalwork=p840$items)
df_culturalwork$.id <- paste0("Q", df_culturalwork$culturalwork)
save(df_culturalwork, file = "data/df_culturalwork.Rda")

list_culturalwork_details <- llply(df_culturalwork$culturalwork, 
                               get_item, 
                               .progress = "text", 
                               .inform = TRUE)
names(list_culturalwork_details) <- paste0("Q", df_culturalwork$culturalwork)
save(list_culturalwork_details, file = "data/list_culturalwork_details.Rda")

load(file = "data/df_culturalwork.Rda")
load(file = "data/list_culturalwork_details.Rda")

df_culturalwork_label <- ldply(list_culturalwork_details, get_frenchlabel)
df_culturalwork %<>% left_join(df_culturalwork_label, id = ".id")


## Join with the location table
#df_culturalwork %<>% left_join(df_location, by = "location")  

## export into interactive table
dt_culturalwork <- datatable(df_culturalwork)
dt_culturalwork
saveWidget(dt_culturalwork,
           file = "~/Documents/paulant/mapfiction/html/dt_culturalwork.html", 
           selfcontained = TRUE)

