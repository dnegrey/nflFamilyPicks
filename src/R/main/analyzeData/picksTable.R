picksTable <- function(gm, lg, tm) {
    x <- do.call(rbind, lapply(split(gm, gm$GameId), gameTranspose))
    row.names(x) <- NULL
    xl <- unlist(lg)
    xl <- data.frame(
        Team = toupper(names(xl)),
        Logo = as.character(xl),
        stringsAsFactors = FALSE
    )
    y <- x %>%
        inner_join(xl, "Team") %>%
        mutate(
            Logo = sprintf(
                fmt = "<img src=\"%s\" style=\"height: 15%s;\"</img>",
                Logo,
                "%"
            )
        ) %>%
        inner_join(
            select(tm, Team, Name),
            "Team"
        ) %>%
        select(
            GameId,
            Week,
            VH,
            Logo,
            Name,
            Score,
            Team,
            TeamWon,
            Dan,
            Lauren,
            Patrick,
            Claire,
            CC
        ) %>%
        mutate(
            Dan = ifelse(Dan == "", Dan, Logo),
            Lauren = ifelse(Lauren == "", Lauren, Logo),
            Patrick = ifelse(Patrick == "", Patrick, Logo),
            Claire = ifelse(Claire == "", Claire, Logo),
            CC = ifelse(CC == "", CC, Logo),
            TeamWon = ifelse(
                TeamWon == Team, 1, 0
            )
        ) %>%
        arrange(Week, GameId, desc(VH)) %>%
        mutate(
            Week = ifelse(
                is.na(lag(Week)) | lag(Week) != Week,
                paste("Week", Week),
                NA_character_
            )
        )
    z <- split(y, y$GameId)
    z1 <- z$`1`
    zb <- z1[1, ] %>%
        mutate(GameId = NA_integer_,
               Week = NA_integer_,
               VH = NA_character_,
               Logo = NA_character_,
               Name = "",
               Score = NA_integer_,
               Team = NA_character_,
               TeamWon = as.numeric(NA),
               Dan = NA_character_,
               Lauren = NA_character_,
               Patrick = NA_character_,
               Claire = NA_character_,
               CC = NA_character_)
    z1 <- rbind(zb, z1, zb)
    for (i in 2:length(z)) {
        zt <- z[[i]]
        z1 <- rbind(z1, zt, zb)
    }
    z <- z1
    row.names(z) <- NULL
    return(z)
}
