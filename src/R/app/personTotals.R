personTotals <- function(m) {
    x <- picksPointsAssign(m$picks, m$game)
    y <- x %>%
        filter(FlagPlayed) %>%
        mutate(
            Win = Points == 1.0,
            Loss = Points == 0.0,
            Tie = Points == 0.5
        ) %>%
        group_by(
            Person
        ) %>%
        summarise(
            GamesPlayed = n(),
            Wins = sum(Win),
            Losses = sum(Loss),
            Ties = sum(Tie),
            Points = sum(Points)
        ) %>%
        ungroup() %>%
        data.frame() %>%
        mutate(
            Percent = Points/GamesPlayed,
            Record = paste(Wins, Losses, Ties, sep = "-"),
            PlaceRankTotal = min_rank(1 - Percent)
        )
    stopifnot(
        length(unique(y$GamesPlayed)) == 1
    )
    y$PlaceTotal <- as.character(y$PlaceRankTotal)
    for (i in 1:nrow(y)) {
        if (sum(y$PlaceRankTotal == y[i, ]$PlaceRankTotal) > 1) {
            y[i, ]$PlaceTotal <- paste(y[i, ]$PlaceRankTotal, "(T)")
        }
    }
    y <- inner_join(y, m$person, "Person") %>%
        group_by(Family) %>%
        mutate(PlaceRankFamily = min_rank(1 - Percent)) %>%
        ungroup() %>%
        data.frame()
    y$PlaceFamily <- as.character(y$PlaceRankFamily)
    y <- lapply(split(y, y$Family), function(v) {
        for (i in 1:nrow(v)) {
            if (sum(v$PlaceRankFamily == v[i, ]$PlaceRankFamily) > 1) {
                v[i, ]$PlaceFamily <- paste(v[i, ]$PlaceRankFamily, "(T)")
            }
        }
        return(v)
    })
    z <- do.call(rbind, y)
    row.names(z) <- NULL
    z <- z %>%
        select(
            Name,
            Family,
            GamesPlayed,
            Record,
            Points,
            Percent,
            PlaceFamily,
            PlaceTotal
        )
    return(z)
}
