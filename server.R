# this is the code for the back end

shinyServer(function(input, output, session) {
    # here you can list some reactive values that will be used in the app and initialize them with a value
    # the vals$gene variable will check for valid genes so the plot doesn't disappear when you enter a non existent gene
    # Technical Info that can be skipped for now###
    # similar to creating them with reactive() function but these will be part of the vals list, are not called as
    # functions (below frame is a reactive value that should be called as frame() instead of frame) and code required 
    # to initialize them is shorter
    vals = reactiveValues(gene = 'Gene1') 
    
    # observe function checks for changes in the variables that it uses, and excecutes code when change happens 
    # this updates gene to be plotted if a valid gene is entered to the textbox
    observe({
        # tolower is here to make sure search is case insensitive
        if(tolower(input$geneSearch) %in% tolower(expression$Gene.Symbol)){
            vals$gene = input$geneSearch  
        }
    })
    
    # this is the data.frame that will be plotted when a gene is entered
    # in this case you could have placed the code for makeFrame function here
    # but it can get bloated in the long run\
    # a change in vals$gene will trigger this so frame will be updated
    frame = reactive({
        makeFrame(vals$gene)
    })
    
    # this is the plotting part. I know I said frame need to be called as frame() but ggvis is an exception
    # normally ggvis does not gave to be inside a reactive but there is no way to update the axis labels if it is 
    # called outside
    reactive({
        p = frame %>% ggvis(~CellTypes,~expression) %>%
            layer_points() %>% 
            add_axis('y',
                     title = paste(vals$gene,"log2 expression"),
                     properties = axis_props(title = list(fontSize = 17),
                                             labels = list(fontSize =14)),
                     title_offset = 50) %>% 
            add_axis('x',title='', properties = axis_props(labels = list(angle=45,
                                                                         align='left',
                                                                         fontSize = 20))) %>% 
            set_options(height = 700, width = 750)
        return(p)
    }) %>% bind_shiny('expressionPlot')
    
    # ggplot code 
    output$expressionPlotGG = renderPlot({
        frame() %>% ggplot(aes(x = CellTypes, y = expression)) +
            geom_point() +
            xlab('') +
            ylab(paste(vals$gene,"log2 expression"))
    },width = 750, height = 700)
    # ggvis may have some problems and is not essential for basic functionality
    # below is the ggplot code
    
})