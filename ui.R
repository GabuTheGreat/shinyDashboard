library(shiny)
library(shinydashboard)

shinyUI(dashboardPage(
  dashboardHeader(title = "WHO TB Burden Dashboard"),
  dashboardSidebar(sidebarMenu(
    menuItem(
      "Dashboard",
      tabName = "dashboard",
      icon = icon("dashboard")
    ),
    menuItem("Widgets", tabName = "widgets", icon = icon("th")),
    uiOutput("Choose_country")
  )),
  dashboardBody(tabItems(
    # First tab content
    tabItem(
      tabName = "dashboard",
      
      fluidRow(
        infoBox("Data Available for", paste("221","Countries"), icon = icon("globe", lib = "glyphicon")),
        infoBoxOutput("Country_Selected"),
        infoBoxOutput("Pop_Figures")
      ),
      
      fluidRow(
        infoBoxOutput("Pop_Growth"),
        infoBoxOutput("TB_Figures"),
        infoBoxOutput("TB_Growth")
      ),
      
      fluidRow(
        box(
          title = "Population Per Year",
          status = "primary",
          solidHeader = TRUE,
          plotOutput("plot1", height = 300)
        ),
        box(
          title = "TB Occurance Per Year",
          status = "primary",
          solidHeader = TRUE,
          plotOutput("plot2", height = 300)
        )
        
      )
    ),
    
    # Second tab content
    tabItem(tabName = "widgets",
            h2("Widgets tab content"))
  ))
))