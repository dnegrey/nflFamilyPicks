personTotals <- function(x) {
    y <- x %>%
        filter(FlagPlayed)
    z <- data.frame(
        Person = c("Dan", "Lauren", "Patrick", "Claire", "CC"),
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
    z <- arrange(z, desc(Points), Person)
    zp <- plot_ly(z) %>%
        add_trace(
            x = ~Points,
            y = ~Person,
            type = "bar",
            marker = list(
                color = "#013369"
            ),
            orientation = "h",
            hoverinfo = "text",
            text = ~paste(
                sprintf("<b>Points: %s</b>", Points),
                sprintf("<b>Winning %s: %s</b>", "%", round(Percent, 3)),
                sep = "<br>"
            )
        ) %>%
        layout(
            title = "",
            xaxis = list(
                range = c(0, nrow(x))
            ),
            yaxis = list(
                title = "",
                categoryorder = "trace",
                autorange = "reversed"
            ),
            margin = 50,
            shapes = list(
                list(
                    type = "line",
                    x0 = yn,
                    x1 = yn,
                    y0 = 0,
                    y1 = 1,
                    yref = "paper",
                    line = list(color = "#F0AE00")
                )
            )
        )
    zp$elementId <- NULL
    return(zp)
}
