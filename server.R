# Define server function required to create the scatterplot --------------------
shinyServer(function(input, output) {
   
   # Create a subset of data filtering for chosen titles
   movies_subset <- reactive({
      req(input$selected_type)
      filter(movies, title_type %in% input$selected_type)
   })
   
   # Create new df that is n_samp obs from selected type movies
   movies_sample <- reactive({
      req(input$n_samp)
      sample_n(movies_subset(), input$n_samp)
   })
   
   # Prettify plot title and append sample size --------------------------------
   #pretty_plot_title <- reactive({
   #   paste0(prettify_label(input$plot_title), ", n =", input$n_samp)
   #})
   
   # Create scatterplot object the plotOutput function is expecting -------------
   output$scatterplot <- renderPlot({
      ggplot(data = movies_sample(), aes_string(x = input$x, y = input$y, 
                                                color = input$z)) +
         geom_point(alpha = input$w, size = input$u) +
         labs(x = toTitleCase(str_replace_all(input$x, "_", " ")),
              y = toTitleCase(str_replace_all(input$y, "_", " ")),
              color = toTitleCase(str_replace_all(input$z, "_", " ")),
              title = paste0(input$plot_title, ", n =", input$n_samp)
         ) +
         theme_bw()
   })
   
   
   # Print number of movies plotted ---------------------------------------------
   output$n <- renderUI({
      movies_sample() %>% 
         count(title_type) %>% 
         mutate(description = glue("There are {n} {title_type} movies in this dataset. <br>")) %>% 
         pull(description) %>%
         HTML()
   })
   # Print the table data
   output$moviestable <- DT::renderDataTable({
      if (input$showdata){                             # Place datatable() <-----
         DT::datatable(data = movies_sample()[,1:7],
                       options = list(pageLength = 10),
                       rownames = FALSE)
      }
      
      
   })
})