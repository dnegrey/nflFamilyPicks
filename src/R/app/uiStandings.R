uiStandings <- function(m) {
    div(
        # section divider
        div(class = "ui horizontal divider", icon("trophy"), "Standings"),
        # options
        div(class = "ui container",
            flow_layout(column_gap = "20px", row_gap = "15px",
                        toggle(
                            input_id = "standingsFilter_ByFamily",
                            label = "Select a Specific Family?",
                            is_marked = FALSE
                        ),
                        conditionalPanel(
                            condition = "input.standingsFilter_ByFamily == true",
                            selectInput(
                                inputId = "standingsFilter_Family",
                                label = NULL,
                                choices = levels(factor(m$person$Family)),
                                multiple = FALSE
                            )
                        )
            )
        ),
        # DT
        DTOutput("standingsDT")
    )
}
