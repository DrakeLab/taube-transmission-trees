### Data frames for transmission tree database
### Juliana Taube
### August 9, 2019

#will need to add cov, maybe as droplet? airborne?
path_mode_df <- data.frame(Path = c("meas", "nph", "plg", "sars", "flu", "hepa", "ebv", "pts", "mers", "spx", "nrv", "rub"), Mode = c("airborne", "other", "airborne", "airborne", "airborne", "other", "fluid", "airborne", "airborne", "airborne", "fluid", "airborne"))

tree_data <- data.frame(get_stats(trees[['aus.2000.meas.1.00']], "meas"))
tree_data <- rbind(tree_data, get_stats(trees[['aus.2003.meas.1.00']], "meas"), get_stats(trees[['aus.2010.meas.1.00']], "meas"), 
                   get_stats(trees[['bgd.2001.nph.1.00']], "nph"), get_stats(trees[['bgd.2001.nph.1.01']], "nph"), get_stats(trees[['bgd.2001.nph.1.02']], "nph"), 
                   get_stats(trees[['bgd.2001.nph.1.03']], "nph"), get_stats(trees[['bgd.2001.nph.1.04']], "nph"), get_stats(trees[['bgd.2001.nph.1.05']], "nph"), 
                   get_stats(trees[['bgd.2001.nph.1.06']], "nph"), get_stats(trees[['bgd.2001.nph.1.07']], "nph"), get_stats(trees[['bgd.2001.nph.1.08']], "nph"),  
                   get_stats(trees[['bgd.2001.nph.1.11']], "nph"), get_stats(trees[['bgd.2001.nph.1.12']], "nph"), get_stats(trees[['bgd.2001.nph.1.13']], "nph"), 
                   get_stats(trees[['bgd.2001.nph.1.14']], "nph"), get_stats(trees[['bgd.2001.nph.1.15']], "nph"), get_stats(trees[['bgd.2001.nph.1.16']], "nph"), 
                   get_stats(trees[['bgd.2004.nph.1.00']], "nph"), get_stats(trees[['chn.1946.plg.1.00']], "plg"), get_stats(trees[['chn.2003.sars.1.00']], "sars"),  
                   get_stats(trees[['chn.2003.sars.1.01']], "sars"), get_stats(trees[['chn.2003.sars.2.00']], "sars"), get_stats(trees[['chn.2009.flu.1.00']], "flu"), 
                   get_stats(trees[['chn.2011.hepa.1.00']], "hepa"), get_stats(trees[['chn.2013.flu.1.00']], "flu"), get_stats(trees[['chn.2015.flu.1.00']], "flu"), 
                   get_stats(trees[['cog.2005.ebv.1.00']], "ebv"), get_stats(trees[['cog.2005.ebv.1.01']], "ebv"), get_stats(trees[['gbr.2009.flu.1.00']], "flu"), 
                   get_stats(trees[['gbr.2009.pts.1.00']], "pts"), get_stats(trees[['gin.2014.ebv.1.00']], "ebv"), get_stats(trees[['gin.2014.ebv.1.01']], "ebv"), 
                   get_stats(trees[['gin.2014.ebv.1.02']], "ebv"), get_stats(trees[['gin.2014.ebv.1.03']], "ebv"), get_stats(trees[['gin.2014.ebv.1.04']], "ebv"), 
                   get_stats(trees[['gin.2014.ebv.1.05']], "ebv"), get_stats(trees[['gin.2014.ebv.1.06']], "ebv"), get_stats(trees[['gin.2014.ebv.2.00']], "ebv"), 
                   get_stats(trees[['gin.2014.ebv.2.01']], "ebv"), get_stats(trees[['gin.2014.ebv.2.03']], "ebv"), get_stats(trees[['gin.2014.ebv.2.04']], "ebv"), 
                   get_stats(trees[['gin.2014.ebv.2.05']], "ebv"), get_stats(trees[['gin.2014.ebv.2.06']], "ebv"), get_stats(trees[['ita.1982.hepa.1.01']], "hepa"), 
                   get_stats(trees[['ita.1982.hepa.1.02']], "hepa"), get_stats(trees[['ita.1982.hepa.1.03']], "hepa"), get_stats(trees[['ita.1982.hepa.1.04']], "hepa"), 
                   get_stats(trees[['ita.1982.hepa.1.06']], "hepa"), get_stats(trees[['ita.1982.hepa.1.07']], "hepa"), get_stats(trees[['ita.1982.hepa.1.08']], "hepa"), 
                   get_stats(trees[['ita.1982.hepa.1.09']], "hepa"), get_stats(trees[['jpn.2016.meas.1.00']], "meas"), get_stats(trees[['jpn.2018.meas.1.00']], "meas"), 
                   get_stats(trees[['kor.2015.mers.1.00']], "mers"), get_stats(trees[['kwt.1967.spx.1.00']], "spx"), get_stats(trees[['lbr.2015.ebv.1.00']], "ebv"), 
                   get_stats(trees[['mdg.1957.plg.1.00']], "plg"), get_stats(trees[['nga.2014.ebv.1.00']], "ebv"), get_stats(trees[['nld.1951.spx.1.00']], "spx"), 
                   get_stats(trees[['nld.2005.nrv.1.00']], "nrv"), get_stats(trees[['nld.2005.nrv.1.01']], "nrv"), get_stats(trees[['nld.2005.nrv.1.02']], "nrv"), 
                   get_stats(trees[['nld.2005.nrv.1.03']], "nrv"), get_stats(trees[['nld.2005.nrv.1.04']], "nrv"), get_stats(trees[['nld.2008.nrv.1.00']], "nrv"), 
                   get_stats(trees[['nld.2008.nrv.1.01']], "nrv"), get_stats(trees[['nld.2010.nrv.1.00']], "nrv"), get_stats(trees[['sau.2013.mers.1.00']], "mers"), 
                   get_stats(trees[['sau.2019.mers.1.00']], "mers"), get_stats(trees[['sau.2019.mers.1.01']], "mers"), get_stats(trees[['sgp.2003.sars.1.00']], "sars"), 
                   get_stats(trees[['sle.2014.ebv.1.00']], "ebv"), get_stats(trees[['sle.2014.ebv.1.01']], "ebv"), get_stats(trees[['uga.2000.ebv.1.00']], "ebv"), 
                   get_stats(trees[['uga.2000.ebv.1.01']], "ebv"), get_stats(trees[['uga.2000.ebv.1.02']], "ebv"), get_stats(trees[['usa.1947.spx.1.00']], "spx"), 
                   get_stats(trees[['usa.1970.rub.1.00']], "rub"), get_stats(trees[['usa.1970.rub.1.01']], "rub"), get_stats(trees[['usa.2009.flu.1.00']], "flu"))

tree_data <- full_join(tree_data, path_mode_df, by = "Path")

ss_stats <- rbind(ss_perc(trees[['aus.2000.meas.1.00']], "meas"), ss_perc(trees[['aus.2003.meas.1.00']], "meas"), ss_perc(trees[['aus.2010.meas.1.00']], "meas"), 
                  ss_perc(trees[['bgd.2001.nph.1.00']], "nph"), ss_perc(trees[['bgd.2001.nph.1.01']], "nph"), ss_perc(trees[['bgd.2001.nph.1.02']], "nph"), 
                  ss_perc(trees[['bgd.2001.nph.1.03']], "nph"), ss_perc(trees[['bgd.2001.nph.1.04']], "nph"), ss_perc(trees[['bgd.2001.nph.1.05']], "nph"), 
                  ss_perc(trees[['bgd.2001.nph.1.06']], "nph"), ss_perc(trees[['bgd.2001.nph.1.07']], "nph"), ss_perc(trees[['bgd.2001.nph.1.08']], "nph"),  
                  ss_perc(trees[['bgd.2001.nph.1.11']], "nph"), ss_perc(trees[['bgd.2001.nph.1.12']], "nph"), ss_perc(trees[['bgd.2001.nph.1.13']], "nph"), 
                  ss_perc(trees[['bgd.2001.nph.1.14']], "nph"), ss_perc(trees[['bgd.2001.nph.1.15']], "nph"), ss_perc(trees[['bgd.2001.nph.1.16']], "nph"), 
                  ss_perc(trees[['bgd.2004.nph.1.00']], "nph"), ss_perc(trees[['chn.1946.plg.1.00']], "plg"), ss_perc(trees[['chn.2003.sars.1.00']], "sars"),  
                  ss_perc(trees[['chn.2003.sars.1.01']], "sars"), ss_perc(trees[['chn.2003.sars.2.00']], "sars"), ss_perc(trees[['chn.2009.flu.1.00']], "flu"), 
                  ss_perc(trees[['chn.2011.hepa.1.00']], "hepa"), ss_perc(trees[['chn.2013.flu.1.00']], "flu"), ss_perc(trees[['chn.2015.flu.1.00']], "flu"), 
                  ss_perc(trees[['cog.2005.ebv.1.00']], "ebv"), ss_perc(trees[['cog.2005.ebv.1.01']], "ebv"), ss_perc(trees[['gbr.2009.flu.1.00']], "flu"), 
                  ss_perc(trees[['gbr.2009.pts.1.00']], "pts"), ss_perc(trees[['gin.2014.ebv.1.00']], "ebv"), ss_perc(trees[['gin.2014.ebv.1.01']], "ebv"), 
                  ss_perc(trees[['gin.2014.ebv.1.02']], "ebv"), ss_perc(trees[['gin.2014.ebv.1.03']], "ebv"), ss_perc(trees[['gin.2014.ebv.1.04']], "ebv"), 
                  ss_perc(trees[['gin.2014.ebv.1.05']], "ebv"), ss_perc(trees[['gin.2014.ebv.1.06']], "ebv"), ss_perc(trees[['gin.2014.ebv.2.00']], "ebv"), 
                  ss_perc(trees[['gin.2014.ebv.2.01']], "ebv"), ss_perc(trees[['gin.2014.ebv.2.03']], "ebv"), ss_perc(trees[['gin.2014.ebv.2.04']], "ebv"), 
                  ss_perc(trees[['gin.2014.ebv.2.05']], "ebv"), ss_perc(trees[['gin.2014.ebv.2.06']], "ebv"), ss_perc(trees[['ita.1982.hepa.1.01']], "hepa"), 
                  ss_perc(trees[['ita.1982.hepa.1.02']], "hepa"), ss_perc(trees[['ita.1982.hepa.1.03']], "hepa"), ss_perc(trees[['ita.1982.hepa.1.04']], "hepa"), 
                  ss_perc(trees[['ita.1982.hepa.1.06']], "hepa"), ss_perc(trees[['ita.1982.hepa.1.07']], "hepa"), ss_perc(trees[['ita.1982.hepa.1.08']], "hepa"), 
                  ss_perc(trees[['ita.1982.hepa.1.09']], "hepa"), ss_perc(trees[['jpn.2016.meas.1.00']], "meas"), ss_perc(trees[['jpn.2018.meas.1.00']], "meas"), 
                  ss_perc(trees[['kor.2015.mers.1.00']], "mers"), ss_perc(trees[['kwt.1967.spx.1.00']], "spx"), ss_perc(trees[['lbr.2015.ebv.1.00']], "ebv"), 
                  ss_perc(trees[['mdg.1957.plg.1.00']], "plg"), ss_perc(trees[['nga.2014.ebv.1.00']], "ebv"), ss_perc(trees[['nld.1951.spx.1.00']], "spx"), 
                  ss_perc(trees[['nld.2005.nrv.1.00']], "nrv"), ss_perc(trees[['nld.2005.nrv.1.01']], "nrv"), ss_perc(trees[['nld.2005.nrv.1.02']], "nrv"), 
                  ss_perc(trees[['nld.2005.nrv.1.03']], "nrv"), ss_perc(trees[['nld.2005.nrv.1.04']], "nrv"), ss_perc(trees[['nld.2008.nrv.1.00']], "nrv"), 
                  ss_perc(trees[['nld.2008.nrv.1.01']], "nrv"), ss_perc(trees[['nld.2010.nrv.1.00']], "nrv"), ss_perc(trees[['sau.2013.mers.1.00']], "mers"), 
                  ss_perc(trees[['sau.2019.mers.1.00']], "mers"), ss_perc(trees[['sau.2019.mers.1.01']], "mers"), ss_perc(trees[['sgp.2003.sars.1.00']], "sars"), 
                  ss_perc(trees[['sle.2014.ebv.1.00']], "ebv"), ss_perc(trees[['sle.2014.ebv.1.01']], "ebv"), ss_perc(trees[['uga.2000.ebv.1.00']], "ebv"), 
                  ss_perc(trees[['uga.2000.ebv.1.01']], "ebv"), ss_perc(trees[['uga.2000.ebv.1.02']], "ebv"), ss_perc(trees[['usa.1947.spx.1.00']], "spx"), 
                  ss_perc(trees[['usa.1970.rub.1.00']], "rub"), ss_perc(trees[['usa.1970.rub.1.01']], "rub"), ss_perc(trees[['usa.2009.flu.1.00']], "flu"))

#adding the mode of transmission results in two rows, one for hepatitis A and one for pertussis that
#   have no superspreaders and are thus filled with NA
ss_stats <- full_join(ss_stats, path_mode_df, by = "Path")


