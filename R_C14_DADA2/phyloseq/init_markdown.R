library(knitr)
library(rmdformats)
library(prettydoc)

## Global options
options(max.print="75")
opts_chunk$set(echo=TRUE,
               cache=TRUE,
               prompt=FALSE,
               tidy=FALSE,
               comment=NA,
               message=FALSE,
               warning=FALSE,
               eval = TRUE)
opts_knit$set(width=75)