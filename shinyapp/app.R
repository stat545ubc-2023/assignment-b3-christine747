library(shiny)
library(dplyr)
library(ggplot2)
library(DT)
library(shinythemes)

penguindata <- read.csv("penguins.csv", stringsAsFactors = FALSE)

ui <- fluidPage(theme = shinytheme("united"),
  titlePanel("Palmer Penguins App"),
  img(src = "penguin.png"), # added an image of palmerpenguins
  h4("Explore penguins that live within the Palmer Archipelago of Antarctica:"),
  br(),
  sidebarLayout(
    sidebarPanel(
      h4("Apply search filters here:"),
      # added 2 options for users to select the range for bill depth and flipper length. This can be helpful for users if they want to look at a specific
      # range of bill depth or flipper length for a particular species, or explore the different ranges for different species. 
      sliderInput("billdepthInput", "Bill Depth", 0, 80, c(0, 40), post = "mm"),
      sliderInput("flipperInput", "Flipper Length", 150, 300, c(150, 200), post = "mm"),  
      
      # added the option for users to input a minimum and maximum bill length using numeric values.This can be helpful when users want to input very 
      # specific measurements down to the decimal place. 
      numericInput("billlengthMinInput", "Input Minimum Bill Length in mm", min = 0, value = 0),
      numericInput("billlengthMaxInput", "Input Maximum Bill Length in mm", min = 0, value = max(penguindata$bill_length_mm, na.rm = TRUE)),
      span("**59.6 mm is the maximum bill length value within this dataset**"),
      br(), br(),
      # added option to select different penguin species. Users have 3 species to choose from. This helps user narrow their search down when trying to look at species specific traits.
      radioButtons("speciesInput", "Species",
                   choices = c("Adelie", "Gentoo", "Chinstrap"),
                   selected = "Adelie"),
      
      # added option to filter penguin results by island. User can look at different penguins from different islands using the drop down function.
      # added the option for "all" islands so that user doesn't always have to filter by a single island and can get a broad overview.
      selectInput("islandInput", "Filter by Island", 
                  choices = c("All islands", unique(penguindata$island))), 
      
      # added the option for users to download the results from the filtered search. This is helpful if users want to use the data for their own analysis
      # and can have the data all in one table in a csv file. 
      downloadButton("table_download", "Download Table Results"), # added a downloadable table that contains the content the user searched for.
      br(), br(),
      span("Data source:", 
           tags$a("palmerpenguins",
                  href = "https://allisonhorst.github.io/palmerpenguins/")),
      br(),
      span("Artwork by @allison_horst")
    ),
    mainPanel(
      # added summary text at the top of the main panel that shows the total number of results displayed in the graph and in the table. 
      # This helps the user see how many penguins match the filters that they have put in. 
      h3(textOutput("summaryText")),
       tabsetPanel(
        tabPanel("Histogram",h3("Penguin Body Mass Distribution"), p("A histogram of the filtered penguins by their body mass"), plotOutput("histoplot")),
        tabPanel("Scatter Plot", h3 ("Bill Size Scatterplot"), p("A scatter plot of the filtered penguin bill sizes based on their bill length and depth"), plotOutput("scatterPlot"))),
      br(),
      DTOutput("results")
    )
  )
)

server <- function(input, output) {
  penguin_filtered <- reactive({
    filtered_data <- penguindata %>%
      filter(bill_depth_mm >= input$billdepthInput[1],
             bill_depth_mm <= input$billdepthInput[2],
             species == input$speciesInput,
             bill_length_mm >= input$billlengthMinInput,
             bill_length_mm <= input$billlengthMaxInput,
             flipper_length_mm >= input$flipperInput[1],
             flipper_length_mm <= input$flipperInput[2])
    
    if (input$islandInput != "All islands") {
      filtered_data <- filtered_data %>%
        filter(island == input$islandInput)
    }
    else 
      filtered_data
  })
  
  # histogram that plots the filtered penguins by their body mass in grams. Different colors represent different islands. 
  output$histoplot <- renderPlot({
    ggplot(penguin_filtered(), aes(x = body_mass_g, fill = island)) +
      geom_histogram(binwidth = 20) +
      xlab("Body Mass (g)") +
      ylab("Count")
  })
  
  # scatter plot for bill depth
  output$scatterPlot <- renderPlot({
    ggplot(penguin_filtered(), aes(x = bill_length_mm, y = bill_depth_mm, color = island)) +
      geom_point(size = 4) +
      xlab("Bill length (mm)") +
      ylab("Bill depth (mm)")
  })
  
  # added an interactive table that comes from the filtered content the user selects. 
  output$results <- DT::renderDataTable({ 
    penguin_filtered() %>%
      select(
        `Species` = species,
        `Island` = island,
        `Bill Depth` = bill_depth_mm,
        `Bill Length` = bill_length_mm,
        `Flipper Length` = flipper_length_mm
      )
  })
  
  output$summaryText <- renderText({
    numPenguins <- nrow(penguin_filtered())
    if (is.null(numPenguins)) {
      numPenguins <- 0
    }
    paste0("We found ", numPenguins, " penguins that match your filters!")
    
  })
  
  output$table_download <- downloadHandler( 
    filename = "palmerpenguins-results.csv",
    content = function(file) {
      write.csv(penguin_filtered(), file)
    }
  )
}





shinyApp(ui = ui, server = server)