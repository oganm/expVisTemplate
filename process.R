# here lies the code for generation of data for now it generates and saves mock data
# replace it processing of your actual data
# data can be saved in text form but binary formats are faster to read, decreasing load times
library(dplyr)
dir.create('data')
expression = data.frame(Gene.Symbol = c('Gene1','Gene2','Gene3'),Sample1 = runif(3,0,16), Sample2 = runif(3,0,16),Sample3 = runif(3,0,16),
                        Sample4 = runif(3,0,16)) %>% saveRDS('data/expression')

metaData = data.frame(Samples = paste0('Sample',1:4), 
                      CellTypes = paste0('Cell',c(1,1,2,2))) %>% saveRDS('data/metaData')
                      