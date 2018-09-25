library(shiny)
library(shinydashboard)
library(RCurl)
library(ggplot2)
library(plotly)

#Read data from GitHub
tb_data <-
  read.csv(
    text = getURL(
      "https://raw.githubusercontent.com/datamustekeers/WHOtb_data_analysis/master/data/TB_burden_countries_2018-07-04.csv"
    ),
    header = T
  )

all_countries = unique(tb_data$country)

shinyServer(function(input, output) {
  output$Choose_country <- renderUI({
    selectInput("select",
                "Select a country",
                choices = all_countries,
                selected = all_countries[1])
  })
  
  
  get_data <- reactive({
    #Get User selection
    country_selected = input$select
    #select data before intiating selector.
    country_data = subset(tb_data, country == country_selected)
    country_data  = country_data[, c("year", "e_pop_num", "e_inc_num")]
    return(country_data)
  })
  
  output$Country_Selected <- renderInfoBox({
    my_country = input$select
    infoBox("Country Selected",my_country, icon = icon("pushpin", lib = "glyphicon"),color = "aqua")
  })
  
  output$Pop_Figures <- renderInfoBox({
    country_data = get_data()
    infoBox(
      "Population",
      tags$p(paste("Pop in 2000 = ",paste(round((country_data[1, 2]/1000000),0),"Millions"), " and Pop in 2016 = ",paste(round((country_data[17, 2]/1000000),0),"Millions")), style = "font-size: 14Px"),
      icon = icon("user", lib = "glyphicon"),
      color = "aqua"
    )
  })
  
  output$Pop_Growth <- renderInfoBox({
    country_data = get_data()
    infoBox(
      "Population Growth",
      paste0(round((((country_data[17, 2] - country_data[1, 2]) / (country_data[1, 2])
      ) * 100), 0), "%"),
      icon = icon("sort", lib = "glyphicon"),
      color = "maroon"
    )
  })
  
  output$TB_Figures <- renderInfoBox({
    country_data = get_data()
    infoBox(
      "All TB Incurrances",
      tags$p(paste("No. of TB infections in 2000 = ",paste(round((country_data[1, 3]/1000),0),"Thousands"), " and No. of TB infections in in 2016 = ",paste(round((country_data[17, 3]/1000),0),"Thousands")), style = "font-size: 12Px"),
      icon = icon("alert", lib = "glyphicon"),
      color = "maroon"
    )
  })
  
  output$TB_Growth <- renderInfoBox({
    country_data = get_data()
    infoBox(
      "Growth in TB Occurance",
      paste0(round((((country_data[17, 3] - country_data[1, 3]) / (country_data[1, 3])
      ) * 100), 0), "%"),
      icon = icon("dashboard", lib = "glyphicon"),
      color = "maroon"
    )
  })
  
  
  output$plot1 <- renderPlotly({
    country_data = get_data()
    p= ggplot(data = country_data, aes(x = year, y = e_pop_num / 100)) +
      geom_line(linetype = "dashed", color = "#900C3F") +
      geom_point(color = "#900C3F") +
      labs(x = "Year", y = "Population in '000'") +
      theme(
        axis.text = element_text(
          face = "bold",
          color = "#340B02",
          size = 14
        ),
        axis.title = element_text(
          face = "bold",
          color = "#340B02",
          size = 14
        )
      )
    ggplotly(p) %>% config(displayModeBar = F)
  })
  
  output$plot2 <- renderPlotly({
    country_data = get_data()
    p = ggplot(data = country_data, aes(x = year, y = e_inc_num)) +
      geom_line(linetype = "dashed", color = "#900C3F") +
      geom_point(color = "#900C3F") +
      labs(x = "Year", y = "All Incurrences of TB") +
      theme(
        axis.text = element_text(
          face = "bold",
          color = "#340B02",
          size = 14
        ),
        axis.title = element_text(
          face = "bold",
          color = "#340B02",
          size = 14
        )
      )
    ggplotly(p) %>% config(displayModeBar = F)
  })
})