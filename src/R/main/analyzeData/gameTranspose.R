gameTranspose <- function(g) {
    x <- rbind(
        mutate(g, Team = TeamV, Score = ScoreV, VH = "V"),
        mutate(g, Team = TeamH, Score = ScoreH, VH = "H")
    )
    players <- names(g)[substr(names(g), 1, 4) == "Pick"]
    players <- substr(players, 5, nchar(players))
    for (pl in players) {
        x[, pl] <- ifelse(
            x[, paste0("Pick", pl)] == x$Team, x$Team, ""
        )
    }
    xb <- c("GameId", "Week", "VH", "Team", "Score", "TeamWon")
    x <- x[c(xb, players)]
    return(x)
}