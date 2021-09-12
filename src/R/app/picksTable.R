picksTable <- function(xp, tm) {
    x <- picksTranspose(xp) %>%
        mutate(
            Game = dense_rank(as.integer(paste0(Week, Game)))
        )
    names(x)[names(x) == "Game"] <- "GameId"
    xl <- "<img src=\"%s/www/logo/%s.svg\" class=\"dtTeamLogo\"</img>"
    y <- x %>%
        mutate(
            Logo = sprintf(
                fmt = xl,
                basename(getwd()),
                tolower(Team)
            )
        ) %>%
        inner_join(
            select(tm, Team, Name),
            "Team"
        )
    yn <- names(y)
    players <- yn[(which(yn == "TeamWon")+1):(which(yn == "Logo")-1)]
    yb <- c("GameId", "Week", "VH", "Logo", "Name", "Score", "Team", "TeamWon")
    y <- y[c(yb, players)]
    for (pl in players) {
        y[, pl] <- ifelse(y[, pl] == "", "", y$Logo)
    }
    y$TeamWon <- ifelse(y$TeamWon == y$Team, 1, 0)
    y <- y %>%
        arrange(Week, GameId, desc(VH)) %>%
        mutate(
            # WeekId = Week,
            # Week = ifelse(
            #     is.na(lag(Week)) | lag(Week) != Week,
            #     paste("Week", Week),
            #     NA_character_
            # ),
            Week = ifelse(
                VH == "V", paste("Week", Week), NA_character_
            )
        )
    z <- split(y, y$GameId)
    z1 <- z$`1`
    zb <- z1[1, ] %>%
        mutate(
            GameId = NA_integer_,
            Week = NA_integer_,
            VH = NA_character_,
            Logo = NA_character_,
            Name = "",
            Score = NA_integer_,
            Team = NA_character_,
            TeamWon = as.numeric(NA)#,
            # WeekId = NA_integer_
        )
    for (pl in players) {
        zb[, pl] <- NA_character_
    }
    z1 <- rbind(zb, z1, zb)
    if (length(z) > 1) {
        for (i in 2:length(z)) {
            zt <- z[[i]]
            z1 <- rbind(z1, zt, zb)
        }
    }
    z <- z1
    row.names(z) <- NULL
    # z$WeekId <- ifelse(
    #     !is.na(z$WeekId), z$WeekId,
    #     lag(z$WeekId)
    # )
    return(z)
}
