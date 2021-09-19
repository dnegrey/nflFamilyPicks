infoModal <- function(id, target) {
    modal(id = id, target = target,
          h3("App Info"),
          hr(),
          h4("Background"),
          p(paste(
              "This application is designed to illustrate the results of our",
              "family's contest where we each predict the winner of every game",
              "in the 2021 NFL season."
          )),
          message_box(
              header = a(
                  href = "https://github.com/dnegrey/nflFamilyPicks",
                  target = "_blank",
                  "Source Code | GitHub"
              ),
              class = "icon",
              icon_name = "github",
              content = NULL
          ),
          h4("Usage"),
          p(paste(
              "Choose a section from the menu at the top. The \"Standings\"",
              "section provides the current standings in tabular form - both",
              "in total and by family. The \"Picks\" section lists every game",
              "by week and includes the outcome of the game along with each",
              "family member's prediction. The \"Teams\" section provides",
              "some information about each team in the NFL."
          ))
    )
}
