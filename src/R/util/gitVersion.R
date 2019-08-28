gitVersion <- function() {
    v <- system("git tag", intern = TRUE)
    v <- v[length(v)]
    #v <- paste("version", v)
    return(v)
}
