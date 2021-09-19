uiStandings <- function(m) {
    div(
        br(),
        # section divider
        div(
            class = "ui horizontal divider",
            style = "color: #D50A0A;",
            icon("trophy"),
            "Standings"
        ),
        br(),
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
                                label = "Select Family",
                                choices = levels(factor(m$person$Family)),
                                multiple = FALSE
                            )
                        )
            )
        ),
        br(),
        # DT
        DTOutput("standingsDT")
    )
}
