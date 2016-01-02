p840 <- read_lines("p840.json") %>% fromJSON()
names(p840$props) %<>% paste0("p", .)

df_culturalwork <- data_frame(culturalwork=p840$items)
df_culturalwork$.id <- paste0("Q", df_culturalwork$culturalwork)
save(df_culturalwork, file = "data/df_culturalwork.Rda")

list_culturalwork_details <- llply(df_culturalwork$culturalwork, 
                               get_item, 
                               .progress = "text", 
                               .inform = TRUE)

paste0("Q", df_culturalwork$culturalwork) %>% head()
save(list_culturalwork_details, file = "data/list_culturalwork_details.Rda")


load(file = "data/df_culturalwork.Rda")
load(file = "data/list_culturalwork_details.Rda")

df_culturalwork_label <- ldply(list_culturalwork_details, get_frenchlabel)
df_culturalwork %<>% left_join(df_culturalwork_label, id = ".id")

df_culturalwork_p31 <- ldply(list_culturalwork_details, get_p31)

table_p31 <- df_culturalwork_p31 %>% 
  group_by(p31) %>% 
  dplyr::summarise(n = n()) %>%
  arrange(desc(n)) %>%
  filter(is.na(p31) == FALSE)

list_p31 <- llply(table_p31$p31, get_item)
ldply(list_p31, get_frenchlabel)

df_culturalwork %>% str()
df_culturalwork_label %>% str()
## Join with the location table
#df_culturalwork %<>% left_join(df_location, by = "location")  


## export into interactive table
dt_culturalwork <- datatable(df_culturalwork)
dt_culturalwork
saveWidget(dt_culturalwork,
           file = "~/Documents/paulant/mapfiction/html/dt_culturalwork.html", 
           selfcontained = TRUE)

