#Custom colours for petb from excel

colours_petb_genus <- readxl::read_excel("phyloseq/colours_petb.xlsx", sheet = "genus")
colours_petb_genus <- structure(colours_petb_genus$colour_name,.Names=colours_petb_genus$genus) 

colours_petb_subcluster <- readxl::read_excel("phyloseq/colours_petb.xlsx", sheet = "sub_cluster")
colours_petb_subcluster <- structure(colours_petb_subcluster$colour_name,.Names=colours_petb_subcluster$sub_cluster) 

colours_petb_clade <- readxl::read_excel("phyloseq/colours_petb.xlsx", sheet = "clade")
colours_petb_clade <- structure(colours_petb_clade$colour_name,.Names=colours_petb_clade$clade) 

colours_petb_subclade <- readxl::read_excel("phyloseq/colours_petb.xlsx", sheet = "subclade")
colours_petb_subclade <- structure(colours_petb_subclade$colour_name,.Names=colours_petb_subclade$subclade) 

