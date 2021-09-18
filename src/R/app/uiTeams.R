uiTeams <- function(m) {
    div(
        # section divider
        div(class = "ui horizontal divider", icon("list"), "Teams"),
        # DT
        DTOutput("teamsDT")
    )
}
