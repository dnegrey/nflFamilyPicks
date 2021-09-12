picksTableDT <- function(x) {
    pl <- names(x)[9:length(x)]
    htmp <- "th(\"%s\")"
    h <- unlist(lapply(pl, sprintf, fmt = htmp))
    h <- paste(h, collapse = ",")
    r <- sprintf("tr(%s)", h)
    tc <- withTags(
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
                eval(parse(text = r))
            )
        )
    )
    y <- datatable(
        data = x,
        container = tc,
        class = "row-border",
        escape = FALSE,
        selection = "none",
        extensions = "Scroller",
        options = list(
            dom = "t",
            pageLength = nrow(x),
            ordering = FALSE,
            scrollY = 550,
            scrollCollapse = FALSE,
            columnDefs = list(
                list(
                    targets = c(0, 2, 6, 7),
                    visible = FALSE
                ),
                list(
                    targets = c(1, 3, 5, 8:(length(x) - 1)),
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
            backgroundColor = styleEqual(c(NA_character_, paste("Week", 1:18)), rep("#EAEAEA", 19)),
            color = styleEqual(paste("Week", 1:18), rep("#333333", 18)),
            fontWeight = styleEqual(paste("Week", 1:18), rep("bold", 18)),
            borderTop = styleEqual(c(NA_character_, paste("Week", 1:18)), rep("none", 19)),
            borderBottom = styleEqual(c(NA_character_, paste("Week", 1:18)), rep("none", 19))
        )
    return(y)
}
