
library(RColorBrewer)

#combine all palettes from Rcolourbrewer
getPalette = colorRampPalette(c(brewer.pal(12, "Paired"), brewer.pal(8, "Set1"), brewer.pal(8, "Pastel2"), brewer.pal(8, "Accent"))) 

divisionList = rbind(unique(tax_table(ps)[,"division"]), "Others")
divisionPalette = getPalette(length(divisionList))
names(divisionPalette) = divisionList
divisionPalette["Others"] <-"grey"

classList = rbind(unique(tax_table(ps)[,"class"]), "Others")
classPalette = getPalette(length(classList))
names(classPalette) = classList
classPalette["Others"] <-"grey"

orderList = rbind(unique(tax_table(ps)[,"order"]), "Others")
orderPalette = getPalette(length(orderList))
names(orderPalette) = orderList
orderPalette["Others"] <- "grey"

familyList = rbind(unique(tax_table(ps)[,"family"]), "Others")
familyPalette = getPalette(length(familyList))
names(familyPalette) = familyList
familyPalette["Others"] <-"grey"

genusList = rbind(unique(tax_table(ps)[,"genus"]), "Others")
genusPalette = getPalette(length(genusList))
names(genusPalette) = genusList
genusPalette["Others"] <-"grey"


genusList = rbind(unique(tax_table(ps_mam)[,"genus"]), "Others")
genusPalette = getPalette(length(genusList))
names(genusPalette) = genusList
genusPalette["Others"] <-"grey"

speciesList = rbind(unique(tax_table(ps_nano)[,"species"]), "Others")
speciesPalette = getPalette(length(speciesList))
names(speciesPalette) = speciesList
speciesPalette["Others"] <-"grey"

