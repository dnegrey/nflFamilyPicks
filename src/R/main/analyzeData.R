analyzeData <- function(dir) {
    # main data object
    RDataCreate(
        dir = dir,
        x = "main",
        fun = list,
        args = list(
            game = RDataUse(dir, "game"),
            person = RDataUse(dir, "person"),
            picks = RDataUse(dir, "picks"),
            team = RDataUse(dir, "team")
        )
    )
}
