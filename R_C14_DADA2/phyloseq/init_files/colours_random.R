
library(RColorBrewer)

#combine all palettes from Rcolourbrewer
getPalette = colorRampPalette(c(brewer.pal(12, "Paired"), brewer.pal(8, "Set1"), brewer.pal(8, "Pastel2"), brewer.pal(8, "Accent"))) 

divisionList = rbind(unique(tax_table(ps_filt)[,"division"]), "Others")
divisionPalette = getPalette(length(divisionList))
names(divisionPalette) = divisionList
divisionPalette["Others"] <-"grey"

classList = rbind(unique(tax_table(ps_pico)[,"class"]), "Others")
classPalette = getPalette(length(classList))
names(classPalette) = classList
classPalette["Others"] <-"grey"

classList = rbind(unique(tax_table(ps_filt)[,"class"]), "Others")
classPalette = getPalette(length(classList))
names(classPalette) = classList
classPalette["Others"] <-"grey"

orderList = rbind(unique(tax_table(ps_filt)[,"order"]), "Others")
orderPalette = getPalette(length(orderList))
names(orderPalette) = orderList
orderPalette["Others"] <- "grey"

familyList = rbind(unique(tax_table(ps[["all"]])[,"family"]), "Others")
familyPalette = getPalette(length(familyList))
names(familyPalette) = familyList
familyPalette["Others"] <-"grey"

genusList = rbind(unique(tax_table(ps_pico)[,"genus"]), "Others")
genusPalette = getPalette(length(genusList))
names(genusPalette) = genusList
genusPalette["Others"] <-"grey"

speciesList = rbind(unique(tax_table(ps_filt)[,"species"]), "Others")
speciesPalette = getPalette(length(speciesList))
names(speciesPalette) = speciesList
speciesPalette["Others"] <-"grey"

trophicList<-c("photosynthetic", "mixotrophic","heterotrophic", "dinophyceae", "syndiniales", "plant", "dinoflagellata")
trophicPalette=as.vector(c( "#009E73", "#56B4E9", "#D55E00", "#F0E442", "#0072B2", "#999999", "#D55E00"))
names(trophicPalette)=trophicList
