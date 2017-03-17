# here goes the code for UI

shinyUI(fluidPage(
    titlePanel('Gene Expression'),
    fluidRow( # fluid row separates a page into 12 columns
        column(4,  # this column takes up 4/12 of the page
               wellPanel( # I want this column to appear with a gray background
               h1('A title'), # just some text if you want to provide some info
               p('Some information about what this whole thing is'),
               textInput(inputId = 'geneSearch',value = 'Gene1',
                         label = 'Select Gene') # this is what takes the gene name as an inpur
               )),
        column(8, # this column will take the remaining 8/12
               htmlOutput('warning'), # this will turn into a warning when the entered gene is not present
               ggvisOutput('expressionPlot'), # this will become the plot, ggvis is sometimes buggy so you might prefer ggplot or plotyl
               plotOutput('expressionPlotGG') # this is the alternative ggplot output, easier to maintain but has less functionality, pick one
               )
        ) # end of fluidRow 
))