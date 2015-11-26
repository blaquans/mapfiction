# Voir SO http://stackoverflow.com/questions/31026276/how-to-get-the-name-of-each-element-of-a-list-using-lapply/31026944#31026944

make_df <- function(x, y) {
  output <- data.frame(matrix(unlist(x), ncol = 3, byrow = TRUE), stringsAsFactors = FALSE, row.names = NULL)
  names(output) <- c("items", "type", y)
  return(output)
}

out <- mapply(make_df, x = com$props, y = names(com$props), SIMPLIFY = FALSE)
out$`31` %>% head()


make_props_df <- function(x) {
  x %<>% 
    unlist %>% 
    matrix(., ncol = 3, byrow = TRUE) %>% 
    data.frame(., stringsAsFactors = FALSE)
  names(x) <- c("item", "type", "value")
  return(x)
}

make_props_df(p840$props$`31`) %>% head()
names(p840$props)
out <- mapply(make_props_df, x = p840$props, SIMPLIFY = FALSE)
