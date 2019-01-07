# UI for league tables
# Nov 2018

shinyUI(fluidPage(
  
  # Application title
  tags$h2("A university league table based on good research practice"),
  div(p(HTML(paste0("This international league table is based on the ", 
tags$a(href="https://www.equator-network.org/", "EQUATOR guidelines"))))),
  p("Universities were awarded points based on the number of times their staff cited an appropriate EQUATOR guideline.
    We used the EQUATOR guidelines for randomised trials (CONSORT), systematic reviews (PRISMA) and observational studies (STROBE).
    The tables focus on health and medical research."),
  p("The tables show the score and rank based on the score. We also show the uncertainty in overall rank using a 95% bootstrap confidence interval. The cluster column is an attempt to group universities with a similar score using five clusters with 5 as the best."),
  p("We have included 'Missing' as a separate university, which combines all the affiliation data that was vague (e.g., `School of Medicine`) or missing."),
  p('The citation data came from Scopus.'),
  
  sidebarLayout(
    sidebarPanel(

      numericInput(inputId = "year",
                              label = "Year:",
                              min = 2016,
                              max = 2017,
                              step = 1,
                              value = 2017),
      
      radioButtons(inputId = "country", 
                   label = "Country:",
                   choices = c("All" = "All",
                               "Australia" = "Australia",
                               "Brazil" = "Brazil",
                               "China" = 'China',
                               "Canada" = 'Canada',
                               "Germany" = "Germany",
                               "Italy" = "Italy",
                               "Japan" = "Japan",
                               "Netherlands" = "Netherlands",
                               "New Zealand" = "New Zealand",
                               "Spain" = "Spain",
                               "UK" = 'United Kingdom',
                               "USA" = 'United States'
                               ), 
                   selected = 'All'),
      
      radioButtons(inputId = "region", 
                   label = "Region:",
                   choices = c("World" = "World",
                               "Africa" = 'AFRICA',
                               "Asia" = 'ASIA',
                               "Europe" = 'EUROPE',
                               "Latin America and Caribbean" = 'LATIN AMER',
                               "North America" = "NORTHERN AMERICA",
                               "Oceania" = 'OCEANIA'), 
                   selected = 'World'), 
      
      textInput(inputId = "search",
                label = "Search for universities (case insensitive)",
                value='')

    ), # end of sidebar panel
    
    mainPanel(
    h3('Rankings'),
    tableOutput(outputId = 'table'),

    # Footer
    hr(),
    print("This is academic research published in partnership with Elsevier-Scopus. All rights reserved to the author and data owner.")

    ) # end of main panel
    
)))
