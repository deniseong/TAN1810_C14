# TAN1810_C14
1. C14 data for rates calculation

data_used: the current excel files being used in the R folder. 
- TAN1810_14C-Pico_25052020_QA_1.0.xlsx -- the main file being used for hot and cold calculations.
  - "C14 hot.Rmd", sheet "complete data TAN1810" -- calculations of NPP per cell for each group
  - "C14 hot figures.Rmd" -- copy of "C14 hot.Rmd", added code for figures
  - "C14 hot controls.Rmd", sheet "Hot C14 - Pico controls"
  - "C14 cold. Rmd", sheet "Cold C14 - Pico results"
  
- TAN1810_14C-Pico_25052020_QA_1.1.xlsx -- rough edit for cold calculations, based on Andres comments. 
  - Edited cold rmd to "C14 cold_edits. Rmd"

- TAN1810_14C-Pico_25052020_QA_1.2.xlsx -- changed U1941 to U9141. I think its a mistake because the dates match to the voyage report
- MD FCM DATA.xlsx --  FCM counts
- C14_rates per group. xlsx -- PP rates per group from "C14 Hot. Rmd"
   -  used together to calculate NPP per group. "C14 NPP per population.Rmd"
  
- TK_CTD Downcasts.xlsx - CTD downcasts for contour plots (temp, salinity) for cycles
  - "C14 contour plot.Rmd"

- TAN1810_nutrients.xls
  - "C14 nutrients.Rmd" -- nutrient calculations.

- A20183052018334.L3m_MO_CHL_chlor_a_4km.nc -- chl a satellite readings from NASA, average reading of 11/2018
- AQUA_MODIS.20181101_20181130.L3m.MO.NSST.sst.4km.nc -- SST satellite readings from NASA, average reading of 11/2018
  - C14 temp and chl map.Rmd
  
- Copy of Chla NPP Raw TAN1810 V5.xlsx -- columns "chla >0.2", "chla >2", "chla>20"
  - for fractionated chlorophyll calculations
  
 
2. C14 for metabarcoding analysis