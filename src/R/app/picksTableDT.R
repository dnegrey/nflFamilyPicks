picksTableDT <- function(x) {
    y <- datatable(
        data = x,
        class = "row-border nowrap",
        escape = FALSE,
        selection = "none",
        options = list(
            dom = "t",
            pageLength = nrow(x),
            ordering = FALSE,
            scrollX = TRUE,
            columnDefs = list(
                list(
                    className = "dt-center",
                    targets = 0
                )
            )
        ),
        rownames = FALSE
    )
    return(y)
}
