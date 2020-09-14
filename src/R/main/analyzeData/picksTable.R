picksTable <- function(gm, tm) {
    x <- do.call(rbind, lapply(split(gm, gm$GameId), gameTranspose))
    row.names(x) <- NULL
    xl <- "<img src=\"%s/www/logo/%s.svg\" style=\"height: %s;\"</img>"
    y <- x %>%
        mutate(
            Logo = sprintf(
                fmt = xl,
                basename(getwd()),
                tolower(Team),
                ifelse(
                    Team == "NYJ", "22.5%",
                    "9%"
                )
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
    y$TeamWon = ifelse(y$TeamWon == y$Team, 1, 0)
    y <- y %>%
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
               TeamWon = as.numeric(NA))
    for (pl in players) {
        zb[, pl] <- NA_character_
    }
    z1 <- rbind(zb, z1, zb)
    for (i in 2:length(z)) {
        zt <- z[[i]]
        z1 <- rbind(z1, zt, zb)
    }
    z <- z1
    row.names(z) <- NULL
    return(z)
}
