picksTable <- function(xp, tm) {
    xl <- "<img src=\"logo/%s.svg\" class=\"dtTeamLogo\"</img>"
    x <- picksTranspose(xp) %>%
        arrange(Week, Game, desc(VH)) %>%
        mutate(
            Game = dense_rank(as.integer(paste0(Week, Game))),
            Logo = sprintf(xl, tolower(Team))
        ) %>%
        inner_join(
            select(tm, Team, Name2),
            "Team"
        )
    xn <- names(x)
    players <- xn[(which(xn == "TeamWon")+1):(which(xn == "Logo")-1)]
    y <- lapply(split(x, x$Game), function(v, vp = players){
        vd <- unique(select(v, Week, Game))
        v <- v %>%
            mutate(
                Style = ifelse(
                    is.na(TeamWon), "",
                    ifelse(
                        TeamWon != Team, "",
                        "color: #2780E3;font-weight: bold;"
                    )
                ),
                Match = sprintf(
                    "%s&nbsp&nbsp&nbsp<span style='width: 100%s;%s'>%s<span style='float: right;'>%s</span></span>",
                    Logo,
                    "%",
                    Style,
                    Name2,
                    ifelse(is.na(Score), "", as.character(Score))
                )
            )
        mrfmt <- "<div style='display: flex;align-items: center;'>%s</div>"
        vd$Match <- sprintf(
            fmt = "%s<br>%s ",
            sprintf(mrfmt, v[1, ]$Match),
            sprintf(mrfmt, v[2, ]$Match)
        )
        vp <- data.frame(
            Player = players,
            Pick = NA_character_,
            stringsAsFactors = FALSE
        )
        for (pl in players) {
            pk <- v[, pl]
            pk <- pk[pk != ""]
            vp[vp$Player == pl, ]$Pick <- pk
        }
        vp$Sort <- ifelse(vp$Pick == v[1, ]$Team, 0, 1)
        vp <- arrange(vp, Sort)
        vd$Picks <- sprintf(
            fmt = "<ul>%s</ul>",
            paste(
                sprintf("<li>%s - %s</li>", vp$Pick, vp$Player),
                collapse = ""
            )
        )
        return(vd)
    })
    z <- do.call(rbind, y) %>%
        arrange(Week, Game) %>%
        select(
            Week,
            Game = Match,
            Picks
        )
    row.names(z) <- NULL
    return(z)
}
