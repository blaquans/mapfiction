get_latlon <- function(id) {
  item <- get_item(id = id) 
  if (is.null(item$claims$P625) == TRUE) {
    latitude <- NA
    longitude <- NA
  }
  else {
    latitude <- item$claims$P625$mainsnak$datavalue$value$latitude
    longitude <- item$claims$P625$mainsnak$datavalue$value$longitude
  }
  message(paste0("lieu :", id))
  return(data.frame(lieu=id, latitude=latitude, longitude=longitude))
}

get_latlon(id=84)
get_latlon(id=1999)
