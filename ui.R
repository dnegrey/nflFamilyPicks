ui <- semanticPage(
  ## title
  title = "Dan Negrey | Shiny - NFL Family Picks",

  ## head
  tags$head(
    # css
    tags$link(
      rel = "stylesheet",
      type = "text/css",
      href = "styles.css"
    ),
    # favicon
    tags$link(
      rel = "icon",
      href = "favicon.ico",
      type="image/x-icon"
    )
  ),

  ## body
  # header
  h1(
    id = "main-header",
    a(
      href = "https://dnegrey.com/",
      target = "_blank",
      id = "main-header-logo-anchor",
      img(
        src = "favicon.ico",
        id = "main-header-logo-image"
      ),
      "Dan Negrey | Shiny"
    )
  ),
  # main application container
  div(
    id = "main-container",
    class = "ui container",
    # container header
    h1(
      class = "ui header",
      icon(
        class = "football ball",
        style = "color: #D50A0A;"
      ),
      div(
        class = "content",
        "NFL Family Picks",
        div(
          class = "sub header",
          sprintf("version %s", gitVersion())
        )
      )
    ),
    # info button and modal
    action_button(
      input_id = "info-view",
      label = "Info",
      class = "primary"
    ),
    infoModal("info-content", "info-view"),
    # section divider
    div(
      class = "ui horizontal divider",
      icon("folder open"),
      "Sections"
    ),
    div(
      id = "page-menu",
      horizontal_menu(
        menu_items = list(
          list(name = "Standings",
               link = route_link("standings"),
               icon = "trophy"),
          list(name = "Picks",
               link = route_link("picks"),
               icon = "sliders horizontal"),
          list(name = "Teams",
               link = route_link("teams"),
               icon = "list")
        )
      )
    ),
    router$ui
  ),
  ## footer
  tags$footer(
    sprintf(
      fmt = "Copyright © Dan Negrey %s",
      format(Sys.Date(), "%Y")
    ),
    style = "color: #FFFFFF;padding-top: 20px;padding-left: 12px;padding-bottom: 10px;"
  )
)

