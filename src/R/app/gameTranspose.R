gameTranspose <- function(g) {
    x <- rbind(
        mutate(g, Team = TeamV, Score = ScoreV, VH = "V"),
        mutate(g, Team = TeamH, Score = ScoreH, VH = "H")
    ) %>%
        mutate(
            Dan = ifelse(PickDan == Team, PickDan, ""),
            Lauren = ifelse(PickLauren == Team, PickLauren, ""),
            Patrick = ifelse(PickPatrick == Team, PickPatrick, ""),
            Claire = ifelse(PickClaire == Team, PickClaire, ""),
            CC = ifelse(PickCC == Team, PickCC, "")
        ) %>%
        select(
            GameId,
            Week,
            VH,
            Team,
            Score,
            TeamWon,
            Dan,
            Lauren,
            Patrick,
            Claire,
            CC
        )
    return(x)
}