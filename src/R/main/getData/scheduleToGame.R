scheduleToGame <- function(f, players) {
    x <- read.csv(f, stringsAsFactors = FALSE)
    stopifnot(
        nrow(x) == 32,
        length(x) == 18,
        names(x)[1] == "TEAM",
        identical(names(x)[2:18], paste0("X", 1:17)),
        length(unique(x$TEAM)) == 32,
        all(!is.na(x)),
        all(trimws(x) != ""),
        is.character(players),
        length(players) > 0,
        all(!is.na(players))
    )
    gm <- 0
    for (wk in 1:17) {
        for (tm in 1:32) {
            gm <- gm + 1
            yi <- x[tm, c("TEAM", paste0("X", wk))]
            names(yi) <- c("T1", "T2")
            yih <- yi$T1
            yiv <- yi$T2
            if (substr(yi$T2, 1, 1) == "@") {
                yih <- yi$T2
                yiv <- yi$T1
            }
            yih <- gsub("@", "", yih, fixed = TRUE)
            tid <- c(yiv, yih)
            tid <- tid[order(tid)]
            tid <- paste(tid, collapse = "")
            yid <- data.frame(
                GameId = gm,
                Week = wk,
                TeamV = yiv,
                TeamH = yih,
                TeamID = tid,
                stringsAsFactors = FALSE
            )
            if (yiv == "BYE") {
                yid <- yid[0, ]
            }
            if (gm == 1) {
                y <- yid
            } else {
                y <- rbind(y, yid)
            }
        }
    }
    yd <- y %>%
        group_by(Week, TeamID) %>%
        summarise(GameId = min(GameId)) %>%
        data.frame()
    z <- yd %>%
        inner_join(y, c("GameId", "Week", "TeamID")) %>%
        select(-TeamID) %>%
        arrange(GameId)
    z$GameId <- 1:nrow(z)
    z <- z %>%
        select(
            GameId,
            Week,
            TeamV,
            TeamH
        ) %>%
        mutate(
            ScoreV = NA_integer_,
            ScoreH = NA_integer_
        )
    for (pl in players) {
        z[, pl] <- NA_character_
    }
    row.names(z) <- NULL
    return(z)
}
