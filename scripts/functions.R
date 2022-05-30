### Functions for transmission tree database
### Juliana Taube
### edited June 2, 2020 but main function to extract tree info is directly in tree creation rmd
### also most of these just got incorporated into Manuscript-draft.Rmd

## Returns a data frame with R0, dispersion parameter, tree size, number of superspreaders, 
##   percentage of nodes considered superspreaders, the initial R0, and the pathogen name 
# might be a good place to add country of origin as well
get_stats <- function(tree_name, path_name = NA){
  tree.i <- as.igraph(tree_name, directed = TRUE)
  #calculate R0, coefficient of variance, dispersion parameter, tree size
  tree.r0 <- round(mean(degree(tree.i, mode = "out")), digits = 2)
  tree.cv <- round(mean(degree(tree.i, mode = "out"))/var(degree(tree.i, mode = "out")), digits = 2)
  tree.dp <- round((fitdistr(degree(tree.i, mode = "out"), "negative binomial"))$estimate["size"], digits = 2)
  tree.sz <- vcount(tree.i)
  thresh <- qpois(0.99, tree.r0) #threshold num secondary inf to be a SS, Lloyd-Smith et al. (2005)
  num.ss <- length(which(degree(tree.i, mode = c("out")) > thresh))
  perc.ss <- num.ss/tree.sz
  if (max_gen(tree_name) < 2){
    zero_name <- names(which(degree(tree.i, mode = c("in")) == 0))
    gen1 <- as.integer(degree(tree.i, zero_name, mode = c("out"))) #number in first generation
    r0.takeoff <- gen1/(gen1 + 1) #number secondary infections over total people = average R0
    degrees <- c(gen1, rep(0, gen1)) 
    #often not enough data to calculate dp.takeoff so commented out
    #dp.takeoff <- round((fitdistr(degrees, "negative binomial"))$estimate["size"], digits = 2)
  }else{
    zero_name <- names(which(degree(tree.i, mode = c("in")) == 0))
    gen1 <- as.integer(degree(tree.i, zero_name, mode = c("out")))
    first_gen_nodes <- V(tree.i)[which(distances(tree.i, v = zero_name, to = V(tree.i), mode = c("out")) == 1)] #people in first generation
    gen2 <- sum(degree(tree.i, first_gen_nodes, mode = c("out")))
    r0.takeoff <- sum(gen1, gen2)/(gen1 + 1) #total infections resulting from zero_name and gen1, divided by gen1 + zero_name (1) 
    degrees <- c(gen1, degree(tree.i, first_gen_nodes, mode = c("out")))
    #dp.takeoff <- round((fitdistr(degrees, "negative binomial"))$estimate["size"], digits = 2)
  }
  return(data.frame("R0" = tree.r0, "DispParm" = tree.dp, "Size" = tree.sz, "Num SS" = num.ss, "Perc SS" = perc.ss, "Early R0" = r0.takeoff, "Path" = path_name))
}

## Returns a data frame with each superspreader 
ss_perc <- function(tree_name, path_name = NULL){
  tree.i <- as.igraph(tree_name, directed = TRUE)
  size <- vcount(tree.i)
  tree.r0 <- mean(degree(tree.i, mode = c("out")))
  thresh <- qpois(0.99, tree.r0)
  ss <- names(which(degree(tree.i, mode = c("out")) > thresh))
  if (length(ss) > 0){
    indiv <- rep(0, length(ss))
    total <- 0
    #determine directly affected numbers
    for (i in 1:length(ss)){
      affected <- as.integer(degree(tree.i, v = ss[i], mode = c("out")))
      indiv[i] <- affected
    }
    #determine largest responsible for indirectly
    for (j in 1:length(ss)){
      temp <- length(subcomponent(tree.i, ss[j], mode = c("out")))
      if (temp > total){
        total <- temp
      }
    }
    output <- data.frame(SS = ss)
    output$Thresh <- thresh
    output$`Direct Effects` <- indiv
    output$`Downstream` <- total/vcount(tree.i)
    output$Num <- length(indiv)
    output$`Direct Perc` <- indiv/(vcount(tree.i)-1)
    #output$`Tree ID` <- deparse(substitute(tree_name))
    output$`Perc SS` <- length(ss)/size
    output$Path <- path_name
  }else{
    output <- NULL
  }
  # old idea
  #   output <- data.frame(SS = NA)
  #   output$Thresh <- NA
  #   output$`Direct Effects` <- NA
  #   output$`Downstream` <- NA
  #   output$Num <- 0
  #   output$`Direct Perc` <- NA
  #   #output$`Tree ID` <- deparse(substitute(tree_name))
  #   output$`Perc SS` <- 0
  #   output$Path <- path_name
  # }
  return(output)
}

## Plots a tree with grey boxes for individuals and black arrows connecting them in a top-bottom fashion
plot_tree <- function(tree_name, node_label_func = NULL, direction = "TB"){
  SetGraphStyle(tree_name, rankdir = direction)
  SetEdgeStyle(tree_name, arrowhead = "normal", color = "black", penwidth = 2)
  SetNodeStyle(tree_name, label=node_label_func, style="filled, rounded", shape="box", fillcolor="grey", fontname = "cochin", tooltip=GetDefaultTooltip)
  plot(tree_name)
}

## Function that determines the maximum number of generations in a tree where the index case is 
##   considered to be generation zero
max_gen <- function(tree_name){
  tree.i <- as.igraph(tree_name, directed = TRUE)
  # identify root/index case
  zero_name <- names(which(degree(tree.i, mode = c("in")) == 0))
  # determine max distance to all vertices of tree
  max(distances(tree.i, v = zero_name, to = V(tree.i), mode = c("out")))
}

## Returns R0 and dispersion parameter (and coefficient of variance, if desired) for a given
##   generation in the tree
stats_per_gen <- function(tree_name, gen_num){
  tree.i <- as.igraph(tree_name, directed = TRUE)
  zero_name <- names(which(degree(tree.i, mode = c("in")) == 0))
  # identifying nodes within the generation of interest
  people <- V(tree.i)[which(distances(tree.i, v = zero_name, to = V(tree.i), mode = c("out")) == gen_num)]
  r0.gen <- round(mean(degree(tree.i, v = people, mode = c("out"))), digits = 2)
  cv.gen <- round(mean(degree(tree.i, v = people, mode = "out"))/var(degree(tree.i, v = people, mode = "out")), digits = 2)
  dp.gen <- round((fitdistr(degree(tree.i, v = people, mode = c("out")), "negative binomial"))$estimate["size"], digits = 2)
  return(data.frame("AvgR0" = r0.gen, "DispParm" = dp.gen))
}