# Define server function required to create the scatterplot --------------------
server <- function(input, output) {
   
   # Create scatterplot object the plotOutput function is expecting -------------
   output$scatterplot <- renderPlot({
      ggplot(data = movies, aes_string(x = input$x, y = input$y, 
                                       color = input$z)) +
         geom_point(alpha = input$w) +
         labs(x = toTitleCase(str_replace_all(input$x, "_", " ")),
              y = toTitleCase(str_replace_all(input$y, "_", " ")),
              color = toTitleCase(str_replace_all(input$z, "_", " "))) +
         theme_bw()
   })
   
   # Print the table data
   output$moviestable <- DT::renderDataTable({
      if (input$showdata){                             # Place datatable() <-----
         DT::datatable(data = movies[,1:7],
                       options = list(pageLength = 10),
                       rownames = FALSE)
      }
      
      
   })
}