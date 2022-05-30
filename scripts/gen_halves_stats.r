# need to get R, dp, ss freq for first half of tree vs second half
# need to control for excess of terminal nodes in second half
# new 2/3/22: need to run multiple iterations of this due to stochasticity

gen_halves_stats <- function(tree, id, disease){
  root <- names(which(degree(tree, mode = c("in")) == 0))
  gens <- max(distances(tree, v = root, to = V(tree), mode = c("out")))
  output_all <- list()
  
  # do this 10 times to account for stochasticity
  for(rep in 1:10){
    first_nodes <- V(tree)[which(distances(tree, v = root, to = V(tree), mode = c("out")) < gens/2)]
    second_nodes <- V(tree)[which(distances(tree, v = root, to = V(tree), mode = c("out")) > gens/2)]
    middle_nodes <- V(tree)[which(distances(tree, v = root, to = V(tree), mode = c("out")) == gens/2)]
    
    # randomly assign nodes to first and second halves
    if(length(middle_nodes) > 0){
      random_nums <- runif(length(middle_nodes))
      for(i in 1:length(middle_nodes)) {
        if(random_nums[i] <= 0.5){first_nodes <- c(first_nodes, middle_nodes[i])
        }else{second_nodes <- c(second_nodes, middle_nodes[i])}
      }
    }
    
    # calculate statistics for the two halves
    ## first half
    # all
    r_1_a <- round(mean(degree(tree, v = first_nodes, mode = "out")), digits = 2)
    thresh_1_a <- qpois(0.99, r_1_a)
    dp_1_a <- tryCatch({round((fitdistr(degree(tree, v = first_nodes, mode = c("out"))
                                        , "negative binomial"))$estimate["size"], digits = 2)}, 
                       error=function(e) {NA})
    num_ss_1_a <- length(which(degree(tree, v = first_nodes, mode = c("out")) > thresh_1_a))
    ss_freq_1_a <- num_ss_1_a/length(first_nodes)
    # no term
    d_1 <- degree(tree, v = first_nodes, mode ="out")
    d_1 <- d_1[d_1>0]
    r_1_nt <- round(mean(d_1), digits = 2)
    thresh_1_nt <- qpois(0.99, r_1_nt)
    dp_1_nt <- tryCatch({round((fitdistr(d_1, "negative binomial"))$estimate["size"], digits = 2)}, 
                        error=function(e) {NA})
    num_ss_1_nt <- length(which(degree(tree, v = first_nodes, mode = c("out")) > thresh_1_nt))
    ss_freq_1_nt <- num_ss_1_nt/length(first_nodes)
    # no last term - not sure this makes sense since only second half will have last gen terminal nodes
    
    ## second half
    # all
    r_2_a <- round(mean(degree(tree, v = second_nodes, mode = "out")), digits = 2)
    thresh_2_a <- qpois(0.99, r_2_a)
    dp_2_a <- tryCatch({round((fitdistr(degree(tree, v = second_nodes, mode = c("out"))
                                        , "negative binomial"))$estimate["size"], digits = 2)}, 
                       error=function(e) {NA})
    num_ss_2_a <- length(which(degree(tree, v = second_nodes, mode = c("out")) > thresh_2_a))
    ss_freq_2_a <- num_ss_2_a/length(second_nodes)
    ss_freq_2_a <- length(which(degree(tree, v = second_nodes, mode = c("out")) > thresh_2_a))/length(second_nodes)
    # no term
    d_2 <- degree(tree, v = second_nodes, mode ="out")
    d_2 <- d_2[d_2>0]
    r_2_nt <- round(mean(d_2), digits = 2)
    thresh_2_nt <- qpois(0.99, r_2_nt)
    dp_2_nt <- tryCatch({round((fitdistr(d_2, "negative binomial"))$estimate["size"], digits = 2)}, 
                        error=function(e) {NA})
    num_ss_2_nt <- length(which(degree(tree, v = second_nodes, mode = c("out")) > thresh_2_nt))
    ss_freq_2_nt <- num_ss_2_nt/length(second_nodes)
    # no last term - not sure this makes sense since only second half will have last gen terminal nodes
    
    output <- data.frame(#`id` = id,
      #`full_Dis` = disease,
      `Gens` = gens,
      `R_1` = r_1_a,
      `R_2` = r_2_a,
      `DP_1` = dp_1_a,
      `DP_2` = dp_2_a,
      `SS Freq 1` = ss_freq_1_a,
      `SS Freq 2` = ss_freq_2_a,
      `R_1_NT` = r_1_nt,
      `R_2_NT` = r_2_nt,
      `DP_1_NT` = dp_1_nt,
      `DP_2_NT` = dp_2_nt,
      `SS Freq 1 NT` = ss_freq_1_nt,
      `SS Freq 2 NT` = ss_freq_2_nt,
      `rep_num` = rep)
    
    output_all <- bind_rows(output_all, output)
  }
  # we need to return output_all as well to comply with plos' data guidelines
  info <- data.frame(`id` = id, `full_Dis` = disease)
  means <- data.frame(t(colMeans(output_all, na.rm = TRUE)))
  
  to_return <- as.list(info %>% bind_cols(means))
  
  output_all <- output_all %>% mutate(`id` = id, `full_Dis` = disease)
  
  #return(to_return)
  return(list("summary" = to_return, "indiv_sims" = output_all))
}
