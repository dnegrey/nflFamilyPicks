picksTableDT <- function(x) {
    yc <- withTags(
        table(
            class = "row-border",
            thead(
                tr(
                    th(rowspan = 2, "GameId"),
                    th(rowspan = 2, ""),
                    th(rowspan = 2, "VH"),
                    th(rowspan = 2, "Team"),
                    th(rowspan = 2, ""),
                    th(rowspan = 2, "Score"),
                    th(rowspan = 2, "Team"),
                    th(rowspan = 2, "TeamWon"),
                    th(colspan = 7, "Picks")
                ),
                tr(
                    th("Dan"),
                    th("Lauren"),
                    th("Patrick"),
                    th("Claire"),
                    th("CC"),
                    th("Grampy"),
                    th("Isaac")
                )
            )
        )
    )
    y <- datatable(
        data = x,
        container = yc,
        class = "row-border",
        escape = FALSE,
        selection = "none",
        extensions = "Scroller",
        options = list(
            dom = "t",
            pageLength = nrow(x),
            ordering = FALSE,
            scrollY = 455,
            scrollCollapse = FALSE,
            columnDefs = list(
                list(
                    targets = c(0, 2, 6, 7),
                    visible = FALSE
                ),
                list(
                    targets = c(1, 3, 5, 8:14),
                    className = "dt-center"
                )
            )
        ),
        rownames = FALSE
    ) %>%
        formatStyle(
            "TeamWon",
            target = "row",
            fontWeight = styleEqual(1, "bold"),
            color = styleEqual(1, "#2780E3")
        ) %>%
        formatStyle(
            "Name",
            target = "row",
            backgroundColor = styleEqual("", "#EAEAEA")
        ) %>%
        formatStyle(
            "Week",
            backgroundColor = styleEqual(c(NA_character_, paste("Week", 1:17)), rep("#EAEAEA", 18)),
            color = styleEqual(paste("Week", 1:17), rep("#333333", 17)),
            fontWeight = styleEqual(paste("Week", 1:17), rep("bold", 17)),
            borderTop = styleEqual(c(NA_character_, paste("Week", 1:17)), rep("none", 18)),
            borderBottom = styleEqual(c(NA_character_, paste("Week", 1:17)), rep("none", 18))
        )
    return(y)
}
