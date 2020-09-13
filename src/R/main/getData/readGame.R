readGame <- function(f) {
    x <- read.csv(
        file = f,
        na.strings = "",
        stringsAsFactors = FALSE
    )
    shp <- which(names(x) == "ScoreH")
    players <- names(x)[(shp + 1):length(x)]
    x <- x %>%
        mutate(
            FlagPlayed = !is.na(ScoreV) & !is.na(ScoreH),
            TeamWon = ifelse(
                !FlagPlayed, NA_character_,
                ifelse(
                    ScoreV > ScoreH, TeamV,
                    ifelse(
                        ScoreH > ScoreV, TeamH,
                        "TIE"
                    )
                )
            )
        )
    xbn <- c("GameId", "Week", "TeamV", "TeamH",
             "ScoreV", "ScoreH", "TeamWon", "FlagPlayed")
    x <- x[c(xbn, players)]
    names(x)[9:length(x)] <- paste0("Pick", players)
    for (pl in players) {
        x[, paste0("Point", pl)] <- ifelse(
            x$TeamWon == "TIE", 0.5,
            as.numeric(
                x[, paste0("Pick", pl)] == x$TeamWon
            )
        )
        xp <- x[, paste0("Pick", pl)]
        xt <- !x$FlagPlayed |
            xp == x$TeamV |
            xp == x$TeamH
        stopifnot(all(xt))
    }
    stopifnot(
        identical(is.na(x$ScoreV), is.na(x$ScoreH)),
        identical(is.na(x$ScoreV), is.na(x$TeamWon)),
        all(!is.na(x[1:4]))
    )
    return(x)
}
