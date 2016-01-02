
p840 <- read_lines("p840.json") %>% fromJSON()
names(p840$props) %<>% paste0("p", .)

df_mapfiction <- p840$props$p840 %>% 
  as.data.frame(stringsAsFactors = FALSE) %>%
  select(item = V1, location = V3) 

df_mapfiction <- merge(df_mapfiction, df_culturalwork, by.x = "item", by.y = "culturalwork")

df_mapfiction %<>% left_join(df_culturalwork_label, by = ".id")

df_mapfiction %<>% left_join(df_culturalwork_label, by = ".id")

df_mapfiction %<>% left_join(df_location, by = "location")
