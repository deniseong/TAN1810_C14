
library(RColorBrewer)

#combine all palettes from Rcolourbrewer
getPalette = colorRampPalette(c(brewer.pal(12, "Paired"), brewer.pal(8, "Set1"), brewer.pal(8, "Pastel2"), brewer.pal(8, "Accent"))) 

divisionList = rbind(unique(tax_table(ps[["all"]])[,"division"]), "Others")
divisionPalette = getPalette(length(divisionList))
names(divisionPalette) = divisionList
divisionPalette["Others"] <-"grey"

classList = rbind(unique(tax_table(ps[["all"]])[,"class"]), "Others")
classPalette = getPalette(length(classList))
names(classPalette) = classList
classPalette["Others"] <-"grey"

orderList = rbind(unique(tax_table(ps[["all"]])[,"order"]), "Others")
orderPalette = getPalette(length(orderList))
names(orderPalette) = orderList
orderPalette["Others"] <- "grey"

familyList = rbind(unique(tax_table(ps[["all"]])[,"family"]), "Others")
familyPalette = getPalette(length(familyList))
names(familyPalette) = familyList
familyPalette["Others"] <-"grey"

genusList = rbind(unique(tax_table(ps[["all"]])[,"genus"]), "Others")
genusPalette = getPalette(length(genusList))
names(genusPalette) = genusList
genusPalette["Others"] <-"grey"

speciesList = rbind(unique(tax_table(ps[["all"]])[,"species"]), "Others")
speciesPalette = getPalette(length(speciesList))
names(speciesPalette) = speciesList
speciesPalette["Others"] <-"grey"

trophicList<-c("dinophyceae", "syndiniales", "mixoplankton","phytoplankton","protozooplankton", "plant", "dinoflagellata")
trophicPalette=as.vector(c("#E69F00", "#56B4E9", "#F0E442", "#009E73", "#0072B2", "#999999", "#D55E00"))
names(trophicPalette)=trophicList
