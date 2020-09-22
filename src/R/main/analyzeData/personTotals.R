personTotals <- function(x) {
    y <- x %>%
        filter(FlagPlayed)
    players <- names(y)[substr(names(y), 1, 4) == "Pick"]
    players <- substr(players, 5, nchar(players))
    z <- list()
    for (pl in players) {
        z[[pl]] <- data.frame(
            Person = pl,
            Wins = sum(y[, paste0("Point", pl)] == 1),
            Losses = sum(y[, paste0("Point", pl)] == 0),
            Ties = sum(y[, paste0("Point", pl)] == 0.5),
            Points = sum(y[, paste0("Point", pl)]),
            stringsAsFactors = FALSE
        )
    }
    z <- do.call(rbind, z)
    row.names(z) <- NULL
    yn <- nrow(y)
    z$Percent <- z$Points/yn
    z$Record <- paste(z$Wins, z$Losses, z$Ties, sep = "-")
    z <- arrange(z, desc(Points), Person)
    z$PlaceRank <- min_rank(1 - z$Percent)
    z$Place <- NA_character_
    for (i in 1:nrow(z)) {
        z[i, ]$Place <- switch(
            z[i, ]$PlaceRank,
            "1" = "1st",
            "2" = "2nd",
            "3" = "3rd",
            "4" = "4th",
            "5" = "5th",
            "6" = "6th",
            "7" = "7th"
        )
        if (sum(z$PlaceRank == z[i, ]$PlaceRank) > 1) {
            z[i, ]$Place <- paste(z[i, ]$Place, "(T)")
        }
    }
    return(z)
}
