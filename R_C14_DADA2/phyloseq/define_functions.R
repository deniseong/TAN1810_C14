# Define function - phyloseq_transform_to_long (transforming phyloseq in dataframe)
phyloseq_transform_to_long <- function(ps) {
  otu_df <- as.data.frame(ps@otu_table@.Data, stringsAsFactors = FALSE) %>%
    rownames_to_column(var = "asv_code") %>%
    pivot_longer(cols = -asv_code,
                 names_to = "file_code",
                 values_to = "n_reads",
                 values_drop_na = TRUE) %>%
    filter(n_reads != 0) %>%
    filter(!is.na(n_reads))
  
  # See https://github.com/joey711/phyloseq/issues/983
  taxo_df <- as.data.frame(ps@tax_table@.Data, stringsAsFactors = FALSE) %>%
    rownames_to_column(var = "asv_code")
  
  otu_df <- left_join(taxo_df, otu_df)
  
  metadata_df <- data.frame(sample_data(ps)) %>%
    rownames_to_column(var = "file_code")
  
  otu_df <- left_join(otu_df, metadata_df, by = c("file_code"))
  
  return(otu_df)
  
}


# Define function - phyloseq_normalize_median (actual normalization)
phyloseq_normalize_median <- function (ps) {
  ps_median = median(sample_sums(ps))
  normalize_median = function(x, t=ps_median) (if(sum(x) > 0){ round(t * (x / sum(x)))} else {x})
  ps = transform_sample_counts(ps, normalize_median)
  cat(str_c("\n========== \n") )
  print(ps)
  cat(sprintf("\n==========\nThe median number of reads used for normalization is  %.0f", ps_median))
  return(ps)
}

# Define function - treemap
phyloseq_long_treemap <- function(df, group1, group2, title) {
  
  df <- df %>%
    group_by({{group1}}, {{group2}}) %>%
    summarise(n_reads=sum(n_reads, na.rm = TRUE))
  g_treemap <- ggplot(df, aes(area = n_reads,
                              fill = {{group2}},
                              label = {{group2}},
                              subgroup = {{group1}})) +
    ggtitle(title) +
    treemapify::geom_treemap() +
    treemapify::geom_treemap_subgroup_border() +
    treemapify::geom_treemap_text(colour = "black", place = "topleft", reflow = T,
                                  padding.x =  grid::unit(3, "mm"),
                                  padding.y = grid::unit(3, "mm") ) +
    treemapify::geom_treemap_subgroup_text(place = "centre", grow = T, alpha = 0.5, colour =
                                             "white", fontface = "italic", min.size = 0) +
    scale_fill_viridis_d() +
    theme(legend.position="none", plot.title = element_text(size = 16, face = "bold"))
  print(g_treemap)
  return(list(df, g_treemap)) #for using with cowplot the plots need to save as objects. Instead of return(df), we have to return the df and                                   the plots = g_treemap 
}