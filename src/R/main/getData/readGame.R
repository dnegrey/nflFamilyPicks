readGame <- function(f) {
    x <- read.csv(
        file = f,
        na.strings = "",
        stringsAsFactors = FALSE
    )
    return(x)
}
