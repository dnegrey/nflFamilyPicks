personPointsByWeekPlot <- function(x) {
    y <- lapply(split(x, x$Week), function(v){
        v <- v %>%
            arrange(Player)
        vw <- unique(v$Week)
        vg <- unique(v$Games)
        vp <- plot_ly(v) %>%
            add_trace(
                x = ~sprintf("<b>%s</b>", Player),
                y = ~Points,
                type = "bar",
                marker = list(
                    color = "#013369"
                ),
                hoverinfo = "text",
                text = ~sprintf(
                    fmt = "%s: %s point%s",
                    Player,
                    Points,
                    ifelse(Points == 1, "", "s")
                )
            ) %>%
            layout(
                showlegend = FALSE,
                xaxis = list(
                    title = ""
                ),
                yaxis = list(
                    title = "<b>Points</b>",
                    range = 0:20,
                    dtick = 1
                ),
                shapes = list(
                    list(
                        type = "line",
                        x0 = 0,
                        x1 = 1,
                        xref = "paper",
                        y0 = vg,
                        y1 = vg,
                        line = list(
                            width = 5,
                            color = "#D50A0A"
                        )
                    )
                ),
                annotations = list(
                    list(
                        text = sprintf("<b>Week %s</b>", vw),
                        xref = "paper",
                        yref = "y",
                        showarrow = FALSE,
                        x = 0.5,
                        y = 17
                    )
                )
            ) %>%
            config(
                displayModeBar = FALSE
            )
        vp$elementId <- NULL
        return(vp)
    })
    # 
    # 
    # xcl <- brewer.pal(length(unique(x$Player)), "Paired")
    # xg <- x %>%
    #     select(Week, Games, GamesCum) %>%
    #     unique() %>%
    #     arrange(Week)
    # y <- plot_ly(colors = xcl) %>%
    #     add_trace(
    #         data = xg,
    #         x = ~Week,
    #         y = ~GamesCum,
    #         type = "scatter",
    #         mode = "lines",
    #         line = list(
    #             color = "#999999"
    #         ),
    #         hoverinfo = "text",
    #         text = ~paste(
    #             sprintf("<b>NFL Week %s</b>", Week),
    #             sprintf("%s games played", Games),
    #             sprintf("%s season-to-date", GamesCum),
    #             sep = "<br>"
    #         ),
    #         name = "NFL"
    #     ) %>%
    #     add_trace(
    #         data = x,
    #         x = ~Week,
    #         y = ~PointsCum,
    #         type = "scatter",
    #         mode = "markers+lines",
    #         color = ~Player,
    #         marker = list(
    #             size = 10
    #         ),
    #         hoverinfo = "text",
    #         text = ~paste(
    #             sprintf("<b>Player: </b> %s", Player),
    #             sprintf("<b>Week: </b> %s", Week),
    #             sprintf("<b>Result: </b> %s points (%s games)", Points, Games),
    #             sprintf("<b>Season: </b> %s points (%s games)", PointsCum, GamesCum),
    #             sep = "<br>"
    #         )
    #     ) %>%
    #     layout(
    #         title = "",
    #         xaxis = list(
    #             title = "<b>Week</b>",
    #             type = "category"
    #         ),
    #         yaxis = list(
    #             title = "<b>Cumulative Points</b>"
    #         )
    #     ) %>%
    #     config(
    #         displayModeBar = FALSE
    #     )
    # y$elementId <- NULL
    return(y)
}
