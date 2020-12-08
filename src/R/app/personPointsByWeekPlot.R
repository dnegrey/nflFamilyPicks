personPointsByWeekPlot <- function(x) {
    y <- lapply(split(x, x$Week), function(v){
        v <- v %>%
            mutate(
                PlayerName = Player,
                PlayerOrder = ifelse(Player == "CC", 0, 1),
                Player = ifelse(
                    Player == "CC", Player,
                    substr(Player, 1, 1)
                )
            ) %>%
            arrange(PlayerOrder, PlayerName)
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
                    PlayerName,
                    Points,
                    ifelse(Points == 1, "", "s")
                )
            ) %>%
            layout(
                showlegend = FALSE,
                xaxis = list(
                    title = "",
                    categoryarray = names,
                    categoryorder = "array"
                ),
                yaxis = list(
                    title = "<b>Points</b>",
                    range = 0:20
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
                            width = 3,
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
    z <- subplot(y, nrows = 2, shareX = TRUE, shareY = TRUE)
    z$elementId <- NULL
    return(z)
}
