analyzeData <- function(dir) {
    # main data object
    RDataCreate(
        dir = dir,
        x = "main",
        fun = list,
        args = list(
            game = RDataUse(dir, "game"),
            team = RDataUse(dir, "team"),
            person = list(
                standings = personTotals(RDataUse(dir, "game")),
                weekly = personTotalsByWeek(RDataUse(dir, "game"))
            ),
            pickTable = picksTable(
                gm = RDataUse(dir, "game"),
                tm = RDataUse(dir, "team")
            ),
            teamTable = teamsTable(
                tm = RDataUse(dir, "team")
            )
        )
    )
}
