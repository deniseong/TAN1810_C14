
library(RColorBrewer)

#combine all palettes from Rcolourbrewer
getPalette = colorRampPalette(c(brewer.pal(12, "Paired"), brewer.pal(8, "Set1"), brewer.pal(8, "Pastel2"), brewer.pal(8, "Accent"))) 

subcladeList = rbind(unique(tax_table(ps)[,"Subclade"]))
subcladePalette = getPalette(length(subcladeList))
names(subcladePalette) = subcladeList

ESTUList = rbind(unique(tax_table(ps_ESTU)[,"ESTU"]))
ESTUPalette = getPalette(length(ESTUList))
names(ESTUPalette) = ESTUList


subcladeList = rbind(unique(tax_table(ps_ctd_nested)[,"Subclade"]))
subcladePalette = getPalette(length(subcladeList))
names(subcladePalette) = subcladeList

ESTUList = rbind(unique(tax_table(ps_ctd_normal)[,"ESTU"]))
ESTUPalette = getPalette(length(ESTUList))
names(ESTUPalette) = ESTUList

cladeList = rbind(unique(tax_table(ps_ctd_normal)[,"Clade"]))
cladePalette = getPalette(length(cladeList))
names(cladePalette) = cladeList

genusList = rbind(unique(tax_table(ps_ctd_normal)[,"Genus"]))
genusPalette = getPalette(length(genusList))
names(genusPalette) = genusList
