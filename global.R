# load necessary packages
library(shiny)
library(shiny.semantic)
library(shiny.router)
library(dplyr)
library(DT)

# source local functions
source("src/R/util/sourceFunctions.R")
sourceFunctions("src/R/util")
sourceFunctions("src/R/app")

# load app data
load("pub/main.RData")

# pages
ui_standings <- uiStandings(main)
ui_picks <- uiPicks(main)
ui_teams <- uiTeams(main)

# router
router <- make_router(
    route("standings", ui_standings),
    route("picks", ui_picks),
    route("teams", ui_teams)
)
