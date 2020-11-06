# Load packages ----------------------------------------------------------------
library(shiny)
library(tidyverse)
library(DT)
library(tools)

# Load data --------------------------------------------------------------------
load("data/movies.Rdata")

# Define UI for application that plots features of movies ----------------------
ui <- fluidPage(
   
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
         
         # Show / hide data table ------------------------------------------------
         checkboxInput(inputId = "showdata", # Add <-------------------
                       label = "Show data",  # checkbox <--------------
                       value = FALSE)        # unchecked at launch <---
      ),
      
      # Output: Show scatterplot -------------------------------------------------
      mainPanel(
         plotOutput(outputId = "scatterplot"),
         
         # Create Data Table
         DT::dataTableOutput(outputId = "moviestable")
      )
   )
)