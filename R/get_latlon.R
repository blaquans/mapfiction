
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

