uiPicks <- function(m) {
    div(
        # section divider
        div(class = "ui horizontal divider", icon("sliders horizontal"), "Picks"),
        # options
        div(class = "ui container",
            flow_layout(column_gap = "20px", row_gap = "15px",
                        selectInput(
                            inputId = "picksFilter_Family",
                            label = "Select Family",
                            choices = levels(factor(m$person$Family)),
                            multiple = FALSE
                        ),
                        shiny::sliderInput(
                            inputId = "picksFilter_Weeks",
                            label = "Select Week(s)",
                            min = 1,
                            max = 18,
                            value = c(1, 18),
                            step = 1
                        ),
                        toggle(
                            input_id = "picksFilter_ByTeam",
                            label = "Select a Specific Team?",
                            is_marked = FALSE
                        ),
                        conditionalPanel(
                            condition = "input.picksFilter_ByTeam == true",
                            selectInput(
                                inputId = "picksFilter_Team",
                                label = "Select Team",
                                choices = m$team$Name,
                                multiple = FALSE
                            )
                        )
            )
        ),
        # DT
        DTOutput("picksDT")
    )
}
