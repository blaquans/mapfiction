get_frenchlabel <- function(id) {
  if (is.null(id$labels$fr) == TRUE) {
    french_label = ""
  }
  else {
    french_label = id$labels$fr$value
  }
  return(data.frame(french_label=french_label, stringsAsFactors = FALSE))
}

# get_item(id = 593)
# get_frenchlabel(id = get_item(id = "593"))

list_culturalwork_details[[1]]$labels$fr$value

get_frenchlabel(list_culturalwork_details[[1]])
