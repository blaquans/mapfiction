
get_latlon <- function(id) {
  if (is.null(id$claims$P625) == TRUE) {
    latitude <- NA
    longitude <- NA
    precision <- NA
  }
  else {
    latitude <- id$claims$P625$mainsnak$datavalue$value$latitude
    longitude <- id$claims$P625$mainsnak$datavalue$value$longitude
    precision <- id$claims$P625$mainsnak$datavalue$value$precision
  }
  return(data.frame(latitude=latitude, longitude=longitude, precision=precision))
}

# list_location_details$Q60$claims$P625$mainsnak$datavalue$value$precision
