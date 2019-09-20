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
        x = "game",
        fun = readGame,
        args = list(
            f = "var/game.csv"
        )
    )
    RDataCreate(
        dir = dir,
        x = "logo",
        fun = imageLogo,
        args = list(
            d = "www/logo"
        )
    )
}
