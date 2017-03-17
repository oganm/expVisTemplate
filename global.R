# all package requirements go here
# you can write them in server.R and ui.R as well but then you'll have to call them twice if both ui and server needs the package
# make sure you have no unused packages as it will increase the loading time on shinyapps.io
library(shiny)
# ggvis plotting
library(ggvis)
# ggplot plotting
library(ggplot2)
library(cowplot)
# other stuff
library(dplyr)
library(magrittr)
library(reshape2)

# varaiables that will be used by the app
metaData = readRDS('data/metaData')
expression = readRDS('data/expression')

# this is the function that will transform expression data for plotting purposes
# this particular functions assumes the samples in the meta data and expression
# data has the same order
makeFrame = function(gene){
    frame = expression %>% filter(Gene.Symbol ==gene) %>% melt
    
    # add metadata to the frame
    frame = data.frame(Sample = frame$variable,
                       expression = frame$value,
                       CellTypes = metaData$CellTypes)
    return(frame)
}