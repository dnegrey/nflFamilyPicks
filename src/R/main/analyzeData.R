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
            )
        )
    )
}
