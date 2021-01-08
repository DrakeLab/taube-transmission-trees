### Loads all packages, trees, runs statistics, and allows for visualization in data frame (similar to data_merged.R)
### Juliana Taube
### June 1, 2020

library(dplyr)
library(ggplot2)
library(tidyr)
library(MASS)
library(tidyverse)
library(grid)
library(GGally)
library(magrittr)
library(igraph)
library(data.tree)

#list of trees
trees <- readRDS("data/database_trees_analyzed.RDS")
#functions for analysis
source("scripts/functions.r")
#data frames with analyzed trees
source("data/data_frames.r")
#add tree ids to data frames
ids <- names(trees)
tree_data <- cbind(tree_data, "Tree ID" = ids)


#prints number of pathogens to console
#(tree_data, Path)
#prints header of data frame with general tree information to console
#see metadata file for meaning of column names
#head(tree_data)