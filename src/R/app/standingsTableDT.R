standingsTableDT <- function(x) {
    xgp <- max(x$GamesPlayed)
    x <- x %>%
        select(-GamesPlayed) %>%
        arrange(
            desc(Percent),
            Family,
            Name
        )
    y <- datatable(
        data = x,
        caption = sprintf(
            fmt = "%s game%s played",
            format(xgp, big.mark = ","),
            ifelse(xgp == 1, "", "s")
        ),
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
                    targets = c(2, 3, 4, 5, 6),
                    className = "dt-center"
                )
            )
        ),
        rownames = FALSE,
        colnames = c(
            "Name",
            "Family",
            "Record",
            "Points",
            "Win %",
            "Place (Family)",
            "Place (Total)"
        )
    ) %>%
        formatCurrency(
            columns = "Points",
            currency = "",
            digits = 0
        ) %>%
        formatPercentage(
            columns = "Percent",
            digits = 0
        )
    return(y)
}
