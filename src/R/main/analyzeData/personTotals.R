personTotals <- function(x) {
    y <- x %>%
        filter(FlagPlayed)
    z <- data.frame(
        Person = c("Dan", "Lauren", "Patrick", "Claire", "CC"),
        Wins = c(
            sum(y$PointDan == 1),
            sum(y$PointLauren == 1),
            sum(y$PointPatrick == 1),
            sum(y$PointClaire == 1),
            sum(y$PointCC == 1)
        ),
        Losses = c(
            sum(y$PointDan == 0),
            sum(y$PointLauren == 0),
            sum(y$PointPatrick == 0),
            sum(y$PointClaire == 0),
            sum(y$PointCC == 0)
        ),
        Ties = c(
            sum(y$PointDan == 0.5),
            sum(y$PointLauren == 0.5),
            sum(y$PointPatrick == 0.5),
            sum(y$PointClaire == 0.5),
            sum(y$PointCC == 0.5)
        ),
        Points = c(
            sum(y$PointDan),
            sum(y$PointLauren),
            sum(y$PointPatrick),
            sum(y$PointClaire),
            sum(y$PointCC)
        ),
        stringsAsFactors = FALSE
    )
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
            "5" = "5th"
        )
        if (sum(z$PlaceRank == z[i, ]$PlaceRank) > 1) {
            z[i, ]$Place <- paste(z[i, ]$Place, "(T)")
        }
    }
    return(z)
}
