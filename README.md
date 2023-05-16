# TAN1810_C14

Script and data for:

All bioinformatics data have been deposited in NCBI Sequence Read Archive (petB (filtered and sorted)-PRJNA885274, 18SV4 (filtered)-PRJNA670061 and XXX, 18SV4 (sorted)-XXX).

Flow cytometry data is available on ([flowrepository.org](https://http://flowrepository.org/experiments/1773)) (Repository ID: FR-FCM-Z5P8).

## R_C14_rates calculation

### 0_data_used
- raw data used for analysis and figures

### 1_Map, CTD, nutrients, CHEMTAX, compare studies
- Map (Map_temp_2.0.Rmd)
- CTD and nutrients (CTD_nutrients_data_2.0.Rmd)
- CHEMTAX (CHEMTAX_2.0.Rmd)
- Compare group-specific CO2 fixation rates against other studies (Rates_studies compare_2.0.Rmd)

### 2_Chl a and NPP
- calculate small volume NPP rates (NPP rates calculation 2.0.Rmd)
- compare small and standard volume NPP rates (NPP_small_standard_compare_2.0.Rmd)
- figures and tables for Chlorophyll a and NPP (Chla_npp_3.0.Rmd)

### 3_Group rates
- calculate group-specific CO2 fixation rates (Group rates calculation_2.0.Rmd)
- compile group-specific rates with cell concentration and group-specific NPP (Group rates compile_2.0.Rmd)
- figures, tables and statistical analysis for group-specific rates (Group rates figures_3.0.Rmd)

### 4_Growth rates
- calculate biomass based on forward scatter data (Group-specific biomass calculations.Rmd)
- calculate growth rates, figures and statistical analysis (Growth rates figures.Rmd)

### Output
- Files generated

## R_C14_DADA2
