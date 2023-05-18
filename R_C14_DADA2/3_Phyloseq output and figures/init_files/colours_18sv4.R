#Custom colours for 18sv4 pico nano

colours_18s_class <- readxl::read_excel(here("3_Phyloseq output and figures", "init_files", "colours_18sv4.xlsx"), sheet = "class")
colours_18s_class <- structure(colours_18s_class$colour,.Names=colours_18s_class$class) 

colours_18s_order <- readxl::read_excel(here("3_Phyloseq output and figures", "init_files", "colours_18sv4.xlsx"), sheet = "order")
colours_18s_order <- structure(colours_18s_order$colour,.Names=colours_18s_order$order) 

colours_18s_mam <- readxl::read_excel(here("3_Phyloseq output and figures", "init_files", "colours_18sv4.xlsx"), sheet = "mam")
colours_18s_mam <- structure(colours_18s_mam$colour,.Names=colours_18s_mam$species) 
