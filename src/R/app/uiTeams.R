uiTeams <- function(m) {
    div(
        br(),
        # section divider
        div(
            class = "ui horizontal divider",
            style = "color: #D50A0A;",
            icon("list"),
            "Teams"
        ),
        br(),
        # DT
        DTOutput("teamsDT")
    )
}
