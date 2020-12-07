personTotalsPlot <- function(z, gp, gt) {
    xm <- round(gt*1.1)
    if (gp < gt/2) {
        xm <- round(gp*1.5)
    }
    zp <- plot_ly(z) %>%
        add_segments(
            x = 0,
            xend = ~Points,
            y = ~sprintf("<b>%s </b>", Person),
            yend = ~sprintf("<b>%s </b>", Person),
            showlegend = FALSE,
            color = I("#2780E3")
        ) %>%
        add_trace(
            x = ~Points,
            y = ~sprintf("<b>%s </b>", Person),
            type = "scatter",
            mode = "markers",
            marker = list(
                color = "#2780E3",
                size = 20
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
                range = c(0, xm),
                title = "<b>Points</b>"
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
                    x0 = gp,
                    x1 = gp,
                    y0 = 0,
                    y1 = 1,
                    yref = "paper",
                    line = list(color = "#E38A27")
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
                    color = "#E38A27"
                )
            )
        ) %>%
        config(
            displayModeBar = FALSE
        )
    zp$elementId <- NULL
    return(zp)
}
