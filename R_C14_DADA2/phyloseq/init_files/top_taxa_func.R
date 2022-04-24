#select top n taxa in each sample
ps_top <- function(ps_long, taxa, top_n) {
    ps_long <- ps_long %>%
        group_by(file_code, {{taxa}}) %>%
        summarise(sum_n_reads = sum(n_reads)) %>%
        slice_max(order_by = sum_n_reads, n = {{top_n}}) %>%
        left_join(ps_long) %>%
        select(-sum_n_reads) %>%
        ungroup()
}
#select top n ASV in each sample
ps_top_asv <- function(ps_long, top_n) {
    ps_long <- ps_long %>%
        group_by(file_code, asv_code) %>%
        summarise(sum_n_reads = sum(n_reads)) %>%
        slice_max(order_by = sum_n_reads, n = {{top_n}}) %>%
        left_join(ps_long) %>%
        select(-sum_n_reads) %>%
        ungroup()
}
# Only take asvs that represent at least 10% of reads in any given sample
ps_abund <- function(ps, fraction) {
    total = median(sample_sums(ps))
    ps <- filter_taxa(ps, function(x) sum(x > total*fraction) > 0, TRUE)
}