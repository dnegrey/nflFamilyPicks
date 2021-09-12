getData <- function(dir) {
    RDataCreate(
        dir = dir,
        x = "team",
        fun = readTeam,
        args = list(
            f = "var/team.csv"
        )
    )
    RDataCreate(
        dir = dir,
        x = "picks",
        fun = function(dir, team) {
            xfl <- list.files(dir, pattern = "^week", full.names = TRUE)
            x <- lapply(xfl, readWeek, team = team)
            y <- do.call(rbind, x)
            row.names(y) <- NULL
            return(y)
        },
        args = list(
            dir = "var",
            team = RDataUse(dir, "team")
        )
    )
    RDataCreate(
        dir = dir,
        x = "person",
        fun = function(x) {
            xp <- unique(x$Person)
            xpl <- strsplit(xp, " - ", TRUE)
            xpf <- unlist(lapply(xpl, function(v){v[1]}))
            xpn <- unlist(lapply(xpl, function(v){v[2]}))
            y <- data.frame(
                Person = xp,
                Name = xpn,
                Family = xpf,
                stringsAsFactors = FALSE
            )
            return(y)
        },
        args = list(
            x = RDataUse("data", "picks")
        )
    )
    RDataCreate(
        dir = dir,
        x = "game",
        fun = readGame,
        args = list(
            f = "var/game.csv"
        )
    )
}
