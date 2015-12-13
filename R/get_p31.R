
#list_location_details[[1]]$claims$P31$mainsnak$datavalue$value$`numeric-id`
get_p31 <- function(id) {
  if (is.null(id$claims$P31) == TRUE) {
    p31 <- NA
  }
  else {
    p31 <- id$claims$P31$mainsnak$datavalue$value$`numeric-id`
  }
  return(data.frame(p31 = p31))
}

#get_p31(list_location_details[[1]])
