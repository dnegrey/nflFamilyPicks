picksTranspose <- function(g) {
    x <- rbind(
        mutate(g, Team = TeamV, Score = ScoreV, VH = "V"),
        mutate(g, Team = TeamH, Score = ScoreH, VH = "H")
    )
    players <- unique(g$Name)
    players <- players[order(players)]
    for (pl in players) {
        xp <- filter(x, Name == pl) %>% select(-Name)
        xp$Person <- ifelse(
            xp$Pick == xp$Team, xp$Team, ""
        )
        xp <- xp %>%
            select(
                Week,
                Game,
                VH,
                Team,
                Score,
                TeamWon,
                Person
            )
        names(xp)[length(xp)] <- pl
        if (pl == players[1]) {
            y <- xp
        } else {
            y <- y %>%
                left_join(xp, c("Week", "Game", "VH", "Team", "Score", "TeamWon"))
        }
    }
    z <- y %>%
        arrange(Week, Game, desc(VH))
    row.names(z) <- NULL
    return(z)
}