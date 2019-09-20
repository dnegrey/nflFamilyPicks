analyzeData <- function(dir) {
    # main data object
    RDataCreate(
        dir = dir,
        x = "main",
        fun = list,
        args = list(
            game = RDataUse(dir, "game"),
            team = RDataUse(dir, "team"),
            logo = RDataUse(dir, "logo"),
            person = list(
                standings = personTotals(RDataUse(dir, "game"))
            ),
            pickTable = picksTable(
                gm = RDataUse(dir, "game"),
                lg = RDataUse(dir, "logo"),
                tm = RDataUse(dir, "team")
            ),
            teamTable = teamsTable(
                lg = RDataUse(dir, "logo"),
                tm = RDataUse(dir, "team")
            )
        )
    )
}
