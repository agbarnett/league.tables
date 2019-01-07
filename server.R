# server for league tables
# July 2018

shinyServer(function(input, output) {
  
  # get the data
  load('data/Processed.papers.for.Shiny.RData')

  # function to get filtered papers (used by basics and table; must be copied into report)
  my.filter = function(indata=results){
    res = indata
    
    # filter on year
    res = filter(res, year==input$year)
    res$overall = res$rank

    # filter on country
    if(input$country != 'All'){
      index = grep(input$country, res$country)
      res = res[index,]
      res$rank = 1:nrow(res)
    }

    # filter on region
    if(input$region != 'World'){
      index = grep(input$region, res$Region)
      res = res[index,]
      res$rank = 1:nrow(res)
    }
    
    # filter by search
    if(input$search != ''){
      search = tolower(input$search)
      index = grep(pattern=search, tolower(res$affiliation)) #
      res = res[index, ]
    }
    
    
    stats = dplyr::mutate(res, interval = paste(round(rlower), ' to ', round(rupper), sep='')) %>%
        select(overall, interval, rank, affiliation, wsum, cluster.member) %>%
        rename('Overall rank'=overall, '95% interval'=interval, 'Rank'=rank, 'Affiliation'=affiliation,
               'Score'=wsum, 'Cluster' = cluster.member)

    return(stats)
  }

  # table of rankings:
  output$table <- renderTable({
    papers = my.filter()
    papers
  }, digits =0)
  
})
