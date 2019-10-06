readGame <- function(f) {
    x <- read.csv(
        file = f,
        na.strings = "",
        stringsAsFactors = FALSE
    ) %>%
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
        ) %>%
        select(
            GameId,
            Week,
            TeamV,
            TeamH,
            ScoreV,
            ScoreH,
            TeamWon,
            FlagPlayed,
            PickDan = Dan,
            PickLauren = Lauren,
            PickPatrick = Patrick,
            PickClaire = Claire,
            PickCC = CC
        ) %>%
        mutate(
            PointDan = as.numeric(PickDan == TeamWon),
            PointLauren = as.numeric(PickLauren == TeamWon),
            PointPatrick = as.numeric(PickPatrick == TeamWon),
            PointClaire = as.numeric(PickClaire == TeamWon),
            PointCC = as.numeric(PickCC == TeamWon),
            PointDan = ifelse(TeamWon == "TIE", 0.5, PointDan),
            PointLauren = ifelse(TeamWon == "TIE", 0.5, PointLauren),
            PointPatrick = ifelse(TeamWon == "TIE", 0.5, PointPatrick),
            PointClaire = ifelse(TeamWon == "TIE", 0.5, PointClaire),
            PointCC = ifelse(TeamWon == "TIE", 0.5, PointCC)
        )
    stopifnot(
        identical(is.na(x$ScoreV), is.na(x$ScoreH)),
        identical(is.na(x$ScoreV), is.na(x$TeamWon)),
        all(!is.na(x[1:4]))
    )
    return(x)
}
