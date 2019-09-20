readTeam <- function(f) {
    x <- read.csv(
        file = f,
        na.strings = "",
        stringsAsFactors = FALSE
    ) %>%
        mutate(
            Name = paste(Name1, Name2),
            ConDiv = paste(Conference, Division)
        )
    stopifnot(
        all(!is.na(x))
    )
    return(x)
}
