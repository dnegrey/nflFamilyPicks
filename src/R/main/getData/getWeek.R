getWeek <- function(x) {
    y <- basename(x)
    z <- as.integer(substr(y, 5, nchar(y) - 4))
    return(z)
}
