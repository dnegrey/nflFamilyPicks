teamsTable <- function(tm) {
    xl <- "<img src=\"%s/www/logo/%s.svg\" style=\"height: %s;\"</img>"
    x <- tm %>%
        mutate(
            Logo = sprintf(
                fmt = xl,
                basename(getwd()),
                tolower(Team),
                ifelse(
                    Team == "NYJ", "22.5%",
                    "9%"
                )
            )
        ) %>%
        select(
            Logo,
            Team,
            Name,
            Conference,
            Division
        )
    return(x)
}
