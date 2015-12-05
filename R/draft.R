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



