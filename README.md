## Data for OutbreakTrees database and to reproduce results in "An open-access database of infectious disease transmission trees to explore superspreader epidemiology"

### Authors
* Juliana C. Taube
* Paige B. Miller
* John M. Drake

### Citation
This repository provides the data and source code for the following paper: Taube JC, Miller PB, Drake JM. "An open-access database of infectious disease transmission trees to explore superspreader epidemiology." PLOS Biology. https://doi.org/10.1371/journal.pbio.3001685.

### Summary:
Public health investigations often aim to identify who infected whom, or the transmission tree, during outbreaks of infectious diseases. These investigations tend to be resource intensive but valuable as they contain epidemiological information, including the average number of infections caused by each individual and the variation in this number. To date, there remains no standardized format nor comprehensive database of infectious disease transmission trees. To fill this gap, we standardized and compiled more than 350 published transmission trees for 16 directly-transmitted diseases into a database that is publicly available. Here, we demonstrate the types of questions that the database can be used to answer related to superspreader epidemiology. 

### Contents:
* `dashboard.Rmd`: code for OutbreakTrees.ecology.uga.edu website where anyone can access trees and download them for use
* `analysis.Rmd`: code for tree analysis, including several sample analyses
* `Tree_Creation.Rmd`: code to manually create trees from literature, and to extract relevant information, including merging with metadata
* `analysis.pdf`: figures outputted from running `analysis.Rmd`
* `data/`: contains compiled lists of trees
* `documents/`: contains csv with tree metadata, including name in database, location, and year of outbreak, and tree source
* `scripts/`: contains key functions to initial tree analysis
* `www/`: contains files for dashboard/website

### Instructions to reproduce results:
To reproduce results, run the `analysis.Rmd` file. This file has already compiled the trees and will complete key calculations and produce the relevant figures.
