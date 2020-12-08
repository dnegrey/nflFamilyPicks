personTotalsByWeek <- function(x) {
    y <- x %>%
        filter(FlagPlayed)
    players <- names(y)[substr(names(y), 1, 4) == "Pick"]
    players <- substr(players, 5, nchar(players))
    z <- list()
    for (pl in players) {
        y$Points <- y[, paste0("Point", pl)]
        z[[pl]] <- y %>%
            group_by(Week) %>%
            summarise(
                Games = n(),
                Points = sum(Points)
            ) %>%
            data.frame() %>%
            arrange(Week) %>%
            mutate(
                GamesCum = cumsum(Games),
                PointsCum = cumsum(Points),
                Player = pl
            )
    }
    z <- do.call(rbind, z)
    row.names(z) <- NULL
    stopifnot(
        length(unique(z$Week)) == nrow(unique(z[c("Week", "Games", "GamesCum")]))
    )
    z <- z %>%
        arrange(Week, Player)
    return(z)
}
