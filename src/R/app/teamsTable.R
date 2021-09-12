teamsTable <- function(tm) {
    xl <- "<img src=\"%s/www/logo/%s.svg\" class=\"dtTeamLogo\"</img>"
    x <- tm %>%
        mutate(
            Logo = sprintf(
                fmt = xl,
                basename(getwd()),
                tolower(Team)
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
