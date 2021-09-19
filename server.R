server <- function(input, output, session) {
  router$server(input, output, session)
  # standings
  standings <- eventReactive(
    eventExpr = list(
      input$standingsFilter_ByFamily,
      input$standingsFilter_Family
    ),
    valueExpr = {
      xbf <- input$standingsFilter_ByFamily
      xfm <- input$standingsFilter_Family
      x <- personTotals(main)
      if (xbf) {
        x <- filter(x, Family == xfm)
      }
      return(x)
    }
  )
  output$standingsDT <- renderDT(
    expr = standingsTableDT(standings())
  )
  # picks
  picks <- eventReactive(
    eventExpr = list(
      input$picksFilter_Family,
      input$picksFilter_Weeks,
      input$picksFilter_ByTeam,
      input$picksFilter_Team
    ),
    valueExpr = {
      xfm <- input$picksFilter_Family
      xwk <- unlist(input$picksFilter_Weeks)
      xbt <- input$picksFilter_ByTeam
      xtm <- input$picksFilter_Team
      x <- main$picks %>%
        inner_join(main$person, "Person") %>%
        filter(
          Family == xfm,
          Week >= xwk[1],
          Week <= xwk[2]
        )
      if (xbt) {
        xt <- main$team %>%
          filter(Name == xtm)
        xt <- xt$Team
        x <- x %>%
          filter(
            TeamV == xt | TeamH == xt
          )
      }
      x <- x %>%
        left_join(main$game, c("Week", "Game", "TeamV", "TeamH")) %>%
        select(
          Week,
          Game,
          TeamV,
          TeamH,
          ScoreV,
          ScoreH,
          Name,
          Pick
        ) %>%
        arrange(
          Week,
          Game,
          Name
        ) %>%
        mutate(
          TeamWon = ifelse(
            ScoreV > ScoreH, TeamV,
            ifelse(
              ScoreV < ScoreH, TeamH,
              NA_character_
            )
          )
        )
      return(x)
    }
  )
  output$picksDT <- renderDT(
    expr = {
      validate(
        need(
          expr = nrow(picks()) > 0,
          message = "No picks available. Try changing your filters."
        )
      )
      picksTableDT(picksTable(picks(), main$team))
    }
  )
  # teams
  output$teamsDT <- renderDT(
    expr = teamsTableDT(teamsTable(main$team))
  )
}
