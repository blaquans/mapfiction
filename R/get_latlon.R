
get_latlon <- function(id) {
  if (is.null(id$claims$P625) == TRUE) {
    latitude <- NA
    longitude <- NA
  }
  else {
    latitude <- id$claims$P625$mainsnak$datavalue$value$latitude
    longitude <- id$claims$P625$mainsnak$datavalue$value$longitude
  }
  return(data.frame(latitude=latitude, longitude=longitude))
}

lieux_details[[1]]$claims$P625$mainsnak$datavalue$value$latitude

get_latlon(id=lieux_details[[1]])
ldply(lieux_details, get_latlon)
