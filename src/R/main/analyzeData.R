analyzeData <- function(dir) {
    # main data object
    RDataCreate(
        dir = dir,
        x = "main",
        fun = list,
        args = list(
            team = RDataUse(dir, "team"),
            game = RDataUse(dir, "game")
        )
    )
}
