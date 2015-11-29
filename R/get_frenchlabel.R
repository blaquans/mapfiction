
get_frenchlabel <- function(id) {
  if (is.null(id$labels$fr) == TRUE) {
    frlabel = ""
  }
  else {
    frlabel = id$labels$fr$value
  }
  return(data.frame(frlabel=frlabel))
}

