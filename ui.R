# Load packages ----------------------------------------------------------------
library(shiny)
library(tidyverse)
library(DT)
library(tools)
library(glue)

# Load data --------------------------------------------------------------------
load(url("https://github.com/seajanelamo/movie-browser-app/raw/main/data/movies.Rdata"))

# A defined function prettify_label used in server shiny
# Function for prettifying axis labels
#prettify_label <- function(x){
#   x %>%
#      str_replace_all("_", " ") %>%
#      toTitleCase() %>%
#      str_replace("Imdb", "IMDB") %>%
#      str_replace("Mpaa", "MPAA") 
#}

# Define UI for application that plots features of movies ----------------------
shinyUI(fluidPage(
   
   # Title 
   titlePanel("Movie Browser"),
   
   # Sidebar layout with a input and output definitions -------------------------
   sidebarLayout(
      
      # Inputs: Select variables to plot -----------------------------------------
      sidebarPanel(
         
         # Select variable for y-axis ---------------------------------------------
         selectInput(inputId = "y",
                     label = "Y-axis:",
                     choices = c("IMDB rating" = "imdb_rating", # Prettify the variable names
                                 "IMDB Number of Votes" = "imdb_num_votes", 
                                 "Critics Score" = "critics_score",
                                 "Audience Score" = "audience_score", 
                                 "Run Time" = "runtime"),
                     selected = "audience_score"),
         
         # Select variable for x-axis ---------------------------------------------
         selectInput(inputId = "x",
                     label = "X-axis:",
                     choices = c("IMDB rating" = "imdb_rating", 
                                 "IMDB Number of Votes" = "imdb_num_votes", 
                                 "Critics Score" = "critics_score",
                                 "Audience Score" = "audience_score", 
                                 "Run Time" = "runtime"),
                     selected = "critics_score"),
         
         # Add new select menu to color the points
         selectInput(inputId = "z",
                     label = "Color by:",
                     choices = c("Title Type" = "title_type", 
                                 "Genre" = "genre", 
                                 "MPAA Rating" = "mpaa_rating", 
                                 "Critics rating" = "critics_rating", 
                                 "Audience rating" = "audience_rating"),
                     selected = "mpaa_rating"),
         
         # Add new input variable to control the alpha level of the points
         sliderInput(inputId = "w",
                     label = "Alpha:",
                     min = 0, max = 1,
                     value = 0.4),
         
         # Set size of points
         sliderInput(inputId = "u",
                     label = "Size:",
                     min = 0, max = 5,
                     value = 2, step = 0.5),
         
         
         # Enter text for plot title ----------------------------------------------
         textInput(inputId = "plot_title",
                   label = "Plot Title",
                   placeholder = "Enter text to be used as plot title"),
         
         # Horizontal line for visual separation ----------------------------------
         hr(),
         
         # Select which types of movies to plot
         checkboxGroupInput(inputId = "selected_type",
                            label = "Select movies type(s):",
                            choices = c("Documentary", "Feature Film", "TV Movie"),
                            selected = "Feature Film"),
         
         # Select sample size ----------------------------------------------------
         numericInput(inputId = "n_samp",
                      label = "Sample size (651 of maximum):",
                      min = 1, max = nrow(movies),
                      value = 50),
         
         # Horizontal line for visual separation ----------------------------------
         hr(),
         
         # Show / hide data table ------------------------------------------------
         checkboxInput(inputId = "showdata", # Add <-------------------
                       label = "Show data",  # checkbox <--------------
                       value = FALSE)        # unchecked at launch <---
         
         
      ),
      
      # Output: Show scatterplot -------------------------------------------------
      mainPanel(
         # Plot
         plotOutput(outputId = "scatterplot"),
         br(),          # a little bit of visual separation
         
         # Print number of obs plotted
         uiOutput(outputId = "n"),
         br(), br(),         # a little bit of visual separation
         
         # Create Data Table
         DT::dataTableOutput(outputId = "moviestable")
      )
   )
)
)
