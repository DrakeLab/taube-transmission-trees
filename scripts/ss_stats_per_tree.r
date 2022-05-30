### Functions for getting stats on supersreaders in each tree
### Juliana Taube

ss_stats_per_tree <- function(tree, ss_threshold, root, id){
  ### Tree is provided as an igraph object
  ### ss_threshold is integer defining the minimum number of secondary infections +1 to be a superspreader
  ### root is the name of the root node
  ### id is the tree id
  names_ss <- names(which(degree(tree, mode = c("out")) > ss_threshold))
  
  ss_success_rate_num <- ss_success_rate_denom <- case_success_rate_num <- case_success_rate_denom <- 0
  infectors_ris <- non_infectors_ris <- list() # list of Ri values for nodes that did and did not infect a superspreader
  
  # first check if tree has superspreaders
  if(length(names_ss) == 0){
    # success rates irrelevant here since no superspreaders
    case_success_rate_num <- case_success_rate_denom <- ss_success_rate_num <- ss_success_rate_denom <- NA
    for(i in 1:length(V(tree))){
      non_infectors_ris <- append(non_infectors_ris, degree(tree, v = V(tree)[i], 
                                                            mode = c("out")))
    }
    # if the tree does have superspreaders:
  }else{ 
    names_dir_infected <- list() # list of nodes directly infected by ALL superspreaders
    infectors <- list() # list of nodes that infected superspreaders
    for(i in 1:length(names_ss)){ #for each superspreader
      # add names of those directly infected by ss to list
      names_dir_infected <- append(names_dir_infected, 
                                   names(V(tree)[which(distances(tree, v = names_ss[i],
                                                                 to = V(tree),
                                                                 mode = c("out")) == 1)])) 
      infector <- names(V(tree)[which(distances(tree, v = names_ss[i], to = V(tree),
                                                mode = c("in")) == 1)])
      if(! identical(infector, character(0))){ # in case ss is root
        # add all infectors of superspreaders in this tree to this list
        infectors <- append(infectors, infector) 
      }
    }
    
    # all ppl infected by ss, moved to not inside loop
    ss_success_rate_denom <- length(names_dir_infected) 
    for(j in 1:length(names_ss)){ # also moved outside loop
      if(names_ss[j] %in% names_dir_infected){ # if ss infected by another ss
        ss_success_rate_num <- ss_success_rate_num + 1
      }
    }
    
    # for each node, see if infected by a ss, calculate its out degree, also calculate success rate nums and denoms
    for(i in 1:length(V(tree))){
      # if is a superspreader
      if((names(V(tree)[i]) %in% names_ss)){ 
        if(names(V(tree)[i]) %in% infectors){ # if infected another superspreader
          infectors_ris <- append(infectors_ris, degree(tree, v = V(tree)[i], mode = c("out")))
        }else{ # if did not infect another superspreader 
          non_infectors_ris <- append(non_infectors_ris, degree(tree, v = V(tree)[i], mode = c("out")))
        }
        
        # if non superspreader root, unknown infector
      }else if(names(V(tree)[i]) == root){  
        case_success_rate_denom <- case_success_rate_denom + as.integer(degree(tree, v = V(tree)[i], mode = c("out")))
        if(names(V(tree)[i]) %in% infectors){ # if infected superspreader
          case_success_rate_num <- case_success_rate_num + 1
          infectors_ris <- append(infectors_ris, degree(tree, v = V(tree)[i], mode = c("out")))
        }else{ # if did not infect superspreader
          non_infectors_ris <- append(non_infectors_ris, degree(tree, v = V(tree)[i], mode = c("out")))
        }
        
        # if case infected by a superspreader
      }else if(names(V(tree)[i]) %in% names_dir_infected){
        # we already took care of if this is a superspreader
        case_success_rate_denom <-  case_success_rate_denom + as.integer(degree(tree, v = V(tree)[i], mode = c("out")))
        if(names(V(tree)[i]) %in% infectors){ # if infected superspreader
          case_success_rate_num <- case_success_rate_num + 1
          infectors_ris <- append(infectors_ris, degree(tree, v = V(tree)[i], mode = c("out")))
        }else{ # if did not infect superspreader
          non_infectors_ris <- append(non_infectors_ris, degree(tree, v = V(tree)[i], mode = c("out")))
        }
        
        # if case not infected by a superspreader
      }else{ 
        case_success_rate_denom <-  case_success_rate_denom + as.integer(degree(tree, v = V(tree)[i], mode = c("out")))
        if(names(V(tree)[i]) %in% infectors){
          case_success_rate_num <- case_success_rate_num + 1
          infectors_ris <- append(infectors_ris, degree(tree, v = V(tree)[i], mode = c("out")))
        }else{
          non_infectors_ris <- append(non_infectors_ris, degree(tree, v = V(tree)[i], mode = c("out")))
        }
      }
    } # end loop through nodes
  }
  
  # success rates
  ss_success_rate <- ss_success_rate_num / ss_success_rate_denom
  case_success_rate <- case_success_rate_num / case_success_rate_denom
  
  # ss-ss dyads
  num_ss <- length(names_ss)
  size <- vcount(tree)
  num_terminal <-length(which(degree(tree, mode = c("out")) == 0))
  observed_ss_dyads <- ifelse(is.na(ss_success_rate_num), 0, ss_success_rate_num)
  expected_ss_dyads <- (num_ss * (num_ss - 1))/size
  expected_ss_dyads_nt <- (num_ss * (num_ss - 1))/(size - num_terminal)
  #((size - 1) * num_ss * (num_ss - 1))/((size - num_terminal) * (size - num_terminal - 1))
  excess_ss_dyads <- observed_ss_dyads - expected_ss_dyads
  excess_ss_dyads_nt <- observed_ss_dyads - expected_ss_dyads_nt
  
  
  output <- list(#id = id, 
    `SS Success Rate` = ss_success_rate,
    `Case Success Rate` = case_success_rate,
    `Obs SS Dyads` = observed_ss_dyads,
    `Exp SS Dyads`= expected_ss_dyads,
    `Excess SS Dyads` = excess_ss_dyads, 
    `Exp SS Dyads JLS` = expected_ss_dyads_nt,
    `Excess SS Dyads JLS` = excess_ss_dyads_nt)
  #`Thresh` = ss_threshold)
  output$`Infectors Ris` <- list(infectors_ris)
  output$`Non-Infectors Ris` <- list(non_infectors_ris)
  
  return(output)
  
}
