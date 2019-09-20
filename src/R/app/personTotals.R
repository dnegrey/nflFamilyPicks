personTotals <- function(x) {
    y <- x %>%
        filter(FlagPlayed)
    z <- data.frame(
        Person = c("Dan", "Lauren", "Patrick", "Claire", "CC"),
        Wins = c(
            sum(y$PointDan == 1),
            sum(y$PointLauren == 1),
            sum(y$PointPatrick == 1),
            sum(y$PointClaire == 1),
            sum(y$PointCC == 1)
        ),
        Losses = c(
            sum(y$PointDan == 0),
            sum(y$PointLauren == 0),
            sum(y$PointPatrick == 0),
            sum(y$PointClaire == 0),
            sum(y$PointCC == 0)
        ),
        Ties = c(
            sum(y$PointDan == 0.5),
            sum(y$PointLauren == 0.5),
            sum(y$PointPatrick == 0.5),
            sum(y$PointClaire == 0.5),
            sum(y$PointCC == 0.5)
        ),
        Points = c(
            sum(y$PointDan),
            sum(y$PointLauren),
            sum(y$PointPatrick),
            sum(y$PointClaire),
            sum(y$PointCC)
        ),
        stringsAsFactors = FALSE
    )
    yn <- nrow(y)
    z$Percent <- z$Points/yn
    z$Record <- paste(z$Wins, z$Losses, z$Ties, sep = "-")
    z <- arrange(z, desc(Points), Person)
    z$PlaceRank <- min_rank(1 - z$Percent)
    z$Place <- NA_character_
    for (i in 1:nrow(z)) {
        z[i, ]$Place <- switch(
            z[i, ]$PlaceRank,
            "1" = "1st",
            "2" = "2nd",
            "3" = "3rd",
            "4" = "4th",
            "5" = "5th"
        )
        if (sum(z$PlaceRank == z[i, ]$PlaceRank) > 1) {
            z[i, ]$Place <- paste(z[i, ]$Place, "(T)")
        }
    }
    return(z)
}
personTotalsPlot <- function(z, gp, gt) {
    zp <- plot_ly(z) %>%
        add_trace(
            x = ~Points,
            y = ~sprintf("<b>%s </b>", Person),
            type = "bar",
            marker = list(
                color = "#2780E3"
            ),
            orientation = "h",
            hoverinfo = "text",
            text = ~paste(
                sprintf("<b>Place: %s</b>", Place),
                sprintf("<b>Record: %s</b>", Record),
                sprintf("<b>Points: %s</b>", Points),
                sprintf("<b>Winning %s: %s</b>", "%", round(Percent, 3)),
                sep = "<br>"
            )
        ) %>%
        layout(
            title = "",
            xaxis = list(
                range = c(0, gt),
                color = "#FFFFFF",
                title = "<b>Points</b>"
            ),
            yaxis = list(
                title = "",
                categoryorder = "trace",
                autorange = "reversed",
                color = "#FFFFFF"
            ),
            margin = 50,
            shapes = list(
                list(
                    type = "line",
                    x0 = gp,
                    x1 = gp,
                    y0 = 0,
                    y1 = 1,
                    yref = "paper",
                    line = list(color = "#FFB700")
                )
            ),
            annotations = list(
                x = gp,
                y = 1,
                yref = "paper",
                text = sprintf("<b> %s games played</b>", gp),
                showarrow = FALSE,
                xanchor = "left",
                font = list(
                    color = "#FFB700"
                )
            ),
            paper_bgcolor = "#002349",
            plot_bgcolor = "#002349"
        ) %>%
        config(
            displayModeBar = FALSE
        )
    zp$elementId <- NULL
    return(zp)
}
