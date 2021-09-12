picksPointsAssign <- function(xp, xg) {
    x <- xp %>%
        inner_join(xg, c("Week", "Game", "TeamV", "TeamH")) %>%
        mutate(
            FlagPlayed = !is.na(ScoreV) & !is.na(ScoreH),
            Winner = ifelse(
                !FlagPlayed, NA_character_,
                ifelse(
                    ScoreV == ScoreH, "TIE",
                    ifelse(
                        ScoreV < ScoreH, TeamH,
                        TeamV
                    )
                )
            ),
            Points = ifelse(
                !FlagPlayed, as.numeric(NA),
                ifelse(
                    Winner == "TIE", 0.5,
                    ifelse(
                        Winner == Pick, 1.0, 0.0
                    )
                )
            )
        )
    return(x)
}
