teamsTable <- function(tm, lg) {
    xl <- "<img src=\"%s\" style=\"height: 15%s;\"</img>"
    x <- tm %>%
        mutate(Logo = xl) %>%
        select(
            Logo,
            Team,
            Name,
            Conference,
            Division
        )
    xlt <- unlist(lg[tolower(x$Team)])
    x$Logo <- sprintf(x$Logo, xlt, "%")
    return(x)
}
