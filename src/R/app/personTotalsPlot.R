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
                range = c(0, gp*2),
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
