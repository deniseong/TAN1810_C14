# TAN1810_C14

Script and data for:

All bioinformatics data have been deposited in NCBI Sequence Read Archive (petB (filtered and sorted)-PRJNA885274, 18SV4 (filtered)-PRJNA670061 and XXX, 18SV4 (sorted)-XXX).

Flow cytometry data is available on ([flowrepository.org](https://http://flowrepository.org/experiments/1773)) (Repository ID: FR-FCM-Z5P8). Metadata for files are found on Github at ([deniseong/marine-Synechococcus-metaB](https://github.com/deniseong/marine-Synechococcus-metaB/tree/main/7_FCM%20files%20metadata)). 

## R_C14_rates calculation

### 0_data_used
- raw data used for analysis and figures

### 0_init_files
- libraries and colours used for analysis

### 1_Map, CTD, nutrients
- Map (Map_temp_2.0.Rmd)
- CTD and nutrients (CTD_nutrients_data_2.0.Rmd)

### 2_Chl a and NPP
- calculate small volume NPP rates (NPP rates calculation 2.0.Rmd)
- compare small and standard volume NPP rates (NPP_small_standard_compare_2.0.Rmd)
- figures and tables for Chlorophyll a and NPP (Chla_npp_3.0.Rmd)

### 3_Cell rates
- calculate cell-specific CO2 fixation rates (Group rates calculation_2.0.Rmd)
- compile cell-specific rates with cell concentration and NPP (Group rates compile_2.0.Rmd)
- figures, tables and statistical analysis for cell-specific rates (Group rates figures_4.0.Rmd)
- Compare cell-specific CO2 fixation rates against other studies (Rates_studies compare_2.0.Rmd)

### 4_Growth rates
- calculate biomass based on forward scatter data (Group-specific biomass calculations.Rmd)
- calculate growth rates, figures and statistical analysis (Growth rates figures_2.0.Rmd)

### Output
- Tables and figures: files generated
- Raw data: raw data generated from rates calculations, used in above Rmds for plots and analysis

## R_C14_DADA2

### 1_DADA2 processing
- Instructions and prerequisites for DADA2 processing (readme_dada2.md)
- Script for DADA2 to process raw Illumina sequences (DADA2_paired.Rmd)

### 2_DADA2 and phyloseq output

#### 2.1_petB
- number of reads at each processing step (TAN1810_petB_nested_summary_dada2.txt)
- DADA2 output (TAN1810_petB_nested_dada2.tsv)
- fasta file with all filtered and sorted ASV sequences (TAN1810_petB_nested_no_taxo.fasta)
- ASV table (TAN1810_petB_nested_metapr2_asv.txt)
- Phyloseq sorted Synechococcus samples (TAN1810_petB_nested_phyloseq_asv_set_sortedsyn.RDS)
- Phyloseq filtered samples (TAN1810_petB_nested_phyloseq_asv_set_nestedCTD.RDS)

#### 2.2_18SV4
- number of reads at each processing step (TAN1810_18SV4_summary_dada2.xlsx)
- DADA2 output (TAN1810_18SV4_dada2.tsv)
- fasta file with all filtered and sorted ASV sequences (TAN1810_18SV4_taxo.fasta)
- ASV table (TAN1810_C14_18SV4_taxo.xlsx)
- Phyloseq sorted picoeukaryotes samples (TAN1810_18SV4phyloseq_sorted_pico.RDS)
- Phyloseq sorted nanoeukaryotes samples (TAN1810_18SV4phyloseq_sorted_nano.RDS)
- Phyloseq filtered samples from station 9 and 39 (TAN1810_18SV4phyloseq_CTD_18SV4.RDS)
- Phyloseq all sorted pico, nanoeukaryotes and filtered samples (phyloseq_merge_asv_set_47_Eukaryota_D4_filt_sort_seqhash.RDS)

### 3_Phyloseq output and figures
- Heatmap (Fig_heatmap_2.0.Rmd)
- NMDS figure and statistical tests (NMDS_PERMANOVA_2.0.Rmd)
- Compare incubation vials of initials, light incubation and dark incubation (Fig_incubation vials.Rmd)
- Compare filtered and sorted samples (Fig_filt vs sort.Rmd)
