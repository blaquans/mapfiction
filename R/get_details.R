get_details <- function(id) {
  message(paste0("lieu :", id))
  item <- get_item(id = id) 
  if (is.null(item$labels$fr) == TRUE) {
    frlabel = ""
  } else {
    frlabel = item$labels$fr$value
  }
  if (is.null(item$claims$P625) == TRUE) {
    latitude <- NA
    longitude <- NA
  }
  else {
    latitude <- item$claims$P625$mainsnak$datavalue$value$latitude
    longitude <- item$claims$P625$mainsnak$datavalue$value$longitude
  }
  return(data.frame(lieu=id, frlabel = frlabel, 
                    latitude=latitude, longitude=longitude))
}

get_details(id = 60)
get_details(id = -2)
