personTotalsByWeekPlot <- function(x) {
    xcl <- brewer.pal(length(unique(x$Player)), "Paired")
    xg <- x %>%
        select(Week, Games, GamesCum) %>%
        unique() %>%
        arrange(Week)
    y <- plot_ly(colors = xcl) %>%
        add_trace(
            data = xg,
            x = ~Week,
            y = ~GamesCum,
            type = "scatter",
            mode = "lines",
            line = list(
                color = "#999999"
            ),
            hoverinfo = "text",
            text = ~paste(
                sprintf("<b>NFL Week %s</b>", Week),
                sprintf("%s games played", Games),
                sprintf("%s season-to-date", GamesCum),
                sep = "<br>"
            ),
            name = "NFL"
        ) %>%
        add_trace(
            data = x,
            x = ~Week,
            y = ~PointsCum,
            type = "scatter",
            mode = "markers+lines",
            color = ~Player,
            marker = list(
                size = 10
            ),
            hoverinfo = "text",
            text = ~paste(
                sprintf("<b>Player: </b> %s", Player),
                sprintf("<b>Week: </b> %s", Week),
                sprintf("<b>Result: </b> %s points (%s games)", Points, Games),
                sprintf("<b>Season: </b> %s points (%s games)", PointsCum, GamesCum),
                sep = "<br>"
            )
        ) %>%
        layout(
            title = "",
            xaxis = list(
                title = "<b>Week</b>",
                type = "category"
            ),
            yaxis = list(
                title = "<b>Cumulative Points</b>"
            )
        ) %>%
        config(
            displayModeBar = FALSE
        )
    y$elementId <- NULL
    return(y)
}
