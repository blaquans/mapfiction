load("data/df_location.Rda")

df_culturalwork <- p840$props$p840 %>% 
  as.data.frame(stringsAsFactors = FALSE) %>%
  select(culturalwork = V1, type = V2, location = V3)
df_culturalwork %<>% left_join(df_location, by = "location")  

df_culturalwork %>% names()
save(df_culturalwork, file = "data/df_culturalwork.Rda")

list_culturalwork_details <- llply(df_culturalwork$culturalwork, 
                               get_item, 
                               .progress = "text", 
                               .inform = TRUE)

save(list_culturalwork_details, file = "data/list_cullist_culturalwork_details.Rda")

## export into interactive table
dt_culturalwork <- datatable(df_culturalwork)
dt_culturalwork
saveWidget(dt_culturalwork,
           file = "~/Documents/paulant/mapfiction/html/dt_culturalwork.html", 
           selfcontained = TRUE)

