readWeek <- function(f, team) {
    x <- read.csv(
        file = f,
        na.strings = "",
        stringsAsFactors = FALSE
    )
    x$Timestamp <- as.POSIXct(
        x = x$Timestamp,
        format = "%Y/%m/%d %r"
    )
    names(x)[2] <- "Person"
    # take latest record per person
    y <- x %>%
        arrange(Person, desc(Timestamp)) %>%
        group_by(Person) %>%
        mutate(RowId = row_number()) %>%
        ungroup() %>%
        data.frame() %>%
        filter(RowId == 1) %>%
        select(-RowId)
    stopifnot(
        nrow(y) == length(unique(y$Person)),
        all(y$Person %in% x$Person)
    )
    names(y)[3:length(y)] <- gsub(".at.", "_", names(y)[3:length(y)])
    yt <- unique(unlist(lapply(y[3:length(y)], identity)))
    stopifnot(
        all(yt %in% team$Name)
    )
    yo <- y
    for (i in 3:length(y)) {
        yni <- names(y)[i]
        tmi <- select(team, Team, Name)
        names(tmi)[2] <- yni
        y <- y %>%
            inner_join(tmi, yni)
        y[, yni] <- y$Team
        y <- select(y, -Team)
    }
    stopifnot(
        identical(dim(yo), dim(y)),
        all(!is.na(y))
    )
    yl <- lapply(split(y, y$Person), function(v) {
        vp <- v$Person
        vd <- v[3:length(v)]
        vg <- names(vd)
        vs <- strsplit(vg, "_", TRUE)
        va <- unlist(lapply(vs, function(w){w[1]}))
        vh <- unlist(lapply(vs, function(w){w[2]}))
        vw <- as.character(t(vd))
        vgn <- seq_along(vg)
        vo <- data.frame(
            Game = vgn,
            TeamV = va,
            TeamH = vh,
            Person = vp,
            Pick = vw,
            stringsAsFactors = FALSE
        )
        return(vo)
    })
    z <- do.call(rbind, yl)
    row.names(z) <- NULL
    z <- data.frame(
        Week = getWeek(f),
        z,
        stringsAsFactors = FALSE
    )
    stopifnot(
        all(z$Person %in% x$Person),
        all(z$Pick == z$TeamV | z$Pick == z$TeamH),
        nrow(unique(z[c("Game", "TeamV", "TeamH")])) == length(unique(z$Game))
    )
    return(z)
}
