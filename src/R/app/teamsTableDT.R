teamsTableDT <- function(x) {
    y <- datatable(
        data = x,
        escape = FALSE,
        selection = "none",
        extensions = "Scroller",
        options = list(
            dom = "t",
            pageLength = nrow(x),
            ordering = FALSE,
            scrollY = 750,
            scrollCollapse = FALSE,
            columnDefs = list(
                list(
                    targets = c(0:4),
                    className = "dt-center"
                )
            )
        ),
        rownames = FALSE,
        colnames = c(
            "Logo",
            "Team",
            "Name",
            "Conference",
            "Division"
        )
    )
    return(y)
}
