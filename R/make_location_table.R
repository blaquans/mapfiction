p840 <- read_lines("p840.json") %>% fromJSON()
names(p840$props) %<>% paste0("p", .)

df_location <- p840$props$p840 %>% 
  as.data.frame(stringsAsFactors = FALSE) %>%
  select(item = V1, type = V2, location = V3) %>%
  group_by(location) %>% 
  dplyr::summarise(n = n()) %>%
  arrange(-n) %>% 
  filter(location != "-2")


is.negative <- function (x) {(x < 0)}
#is.negative(x = -1)
df_location$location %>% as.numeric() %>% is.negative() %>% table()
df_location$location[724]

list_location_details <- llply(df_location$location, 
                               get_item, 
                               .progress = "text", 
                               .inform = TRUE)

names(list_location_details) <- paste0("Q", df_location$location)
save(list_location_details, file = "data/list_location_details.Rda")

load("data/list_location_details.Rda")

df_location$.id <- paste0("Q", df_location$location)

source("R/get_frenchlabel.R")
df_location_label <- ldply(list_location_details, get_frenchlabel)
df_location %<>% left_join(df_location_label, id = ".id")

source("R/get_latlon.R")
df_location_latlon <- ldply(list_location_details, get_latlon)
df_location %<>% left_join(df_location_latlon, id = ".id")

save(df_location, file = "data/df_location.Rda")

load("data/df_location.Rda")

formattable(df_location, list(n = color_tile("white", "orange")))
df_location_p31 <- ldply(list_location_details, get_p31)
