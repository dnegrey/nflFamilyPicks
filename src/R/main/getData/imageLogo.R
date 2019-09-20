imageLogo <- function(d) {
    x <- list.files(d, full.names = TRUE)
    xn <- basename(x)
    xn <- substr(xn, 1, nchar(xn) - 4)
    y <- lapply(x, image_uri)
    names(y) <- xn
    return(y)
}
