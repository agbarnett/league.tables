[![DOI](https://zenodo.org/badge/137861982.svg)](https://zenodo.org/badge/latestdoi/137861982)

# University league table of good research practice
Creating an international university league table based on a good research practice.

The key R files are:
* `data.management.R` takes the raw data from Scopus and attempts to create consistent names for institutions.
* `WhoCitesEquator.Rmd` is the Rmarkdown file for the complete analyses.
* `ui.R` and `server.R` make the Shiny page with the interactive results.

The two key data sets (both available in csv and RData format) are:

**1. Papers.for.Analysis** which are a random sample of 500 of the 47,876 papers used to create the league tables, with the variables:
* doi
* affiliation
* affid, _Scopus_ affiliation ID number
* country
* year, 2016 or 2017
* Region
* weight, fraction count of authors in the range (0,1]

**2. Processed.papers.for.Shiny** which is the data used to create the interactive league tables in _Shiny_, with the variables:
* year, 2016 or 2017
* country               
* Region   
* affiliation     
* wsum, sum of fractional papers per university which determines the rank  
* n, number of papers 
* rank, rank per year 
* cluster.member, estimated cluster based on `wsum` from 1 (lowest) to 5 (highest)   
* p10, bootstrap probability of being in the top 10
* rlower, bootstrap lower 95% confidence interval
* rupper, bootstrap upper 95% confidence interval

**3. pubmed.frame** which details the EQUATOR papers used to count citations:
