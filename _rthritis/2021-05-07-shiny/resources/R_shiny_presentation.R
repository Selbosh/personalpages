
 ###### Basic template for R shiny
 library(shiny)
 ui <- fluidPage()
 server <- function(input,output){}
 shinyApp(ui,server)
 
 
 ######### Example 1 Plug in the input and output function
 library(shiny)
 
 ui <- fluidPage(
   numericInput(inputId="n","Sample size",value=50),
   plotOutput(outputId= "hist1"))
 
 server <- function(input, output) {
   output$hist1 <- renderPlot({hist(rnorm(input$n))})
   
 }

 shinyApp(ui,server)
 
 
 
####### Example 2: change based on the first one, we add a sidebar lay out panel for the app. The Html tags value have been implemented.
 
 library(shiny)
 
 ui <- fluidPage(
   titlePanel("Hello Shiny!"),
   # Sidebar layout with input and output definitions ----
   sidebarLayout(
     # Sidebar panel for inputs ----
     sidebarPanel(
    numericInput(inputId="n","Sample size",value=50),submitButton(),
    # adding the new div tag to the sidebar 
    tags$div(class="header", checked=NA,
             tags$p(strong("Ready to take the Shiny tutorial? If so")),
             tags$a(href="https://shiny.rstudio.com/tutorial/", "Click Here!")
    )),
    
    # Main panel for displaying outputs ----
    mainPanel( 
    plotOutput(outputId= "hist1"))))
 
 server <- function(input, output) {
   output$hist1 <- renderPlot({hist(rnorm(input$n))})
   
 }
 
 shinyApp(ui,server)
 

 #### Step by step approach
 
 ## Step 1 : Making libraries available & descriptive statistics irish dataset
 install.packages("shiny")
 library(shiny)
 iris
 str(iris)
 head(iris)
 summary(iris)
 
 
##### Step 2: Build  the basic framework for R shiny
 ui <- fluidPage(
   titlePanel(title = "Shiny App for Iris!"),
   # Sidebar layout with input and output definitions ----
   sidebarLayout(
     # Sidebar panel for inputs ----
     sidebarPanel(
     ),
     
     # Main panel for displaying outputs ----
     mainPanel( 
     )
   )
 )
 
 server <- function(input,output){}
 shinyApp(ui,server)


 
 
 ######### Step 3 Create the input structure in the siderbar panel 
 ui <- fluidPage(
   titlePanel(title = "Shiny App for Iris!"),
   # Sidebar layout with input and output definitions ----
   sidebarLayout(
     # Sidebar panel for inputs ----
     sidebarPanel(
       selectInput(inputId="var","Select the variables",choices = c("Sepal.Length"=1,"Sepal.Width"=2,"Petal.Length"=3,"Petal.Width"=4),selected=3,selectize = FALSE),
       sliderInput(inputId="bin","Select the number of bins for histogram",min=5, max=25,value=10),
       radioButtons(inputId="colour",label="Select the colour of the histogram",choices = c("blue","yellow","red"),selected="yellow")
       ),
     
     # Main panel for displaying outputs ----
     mainPanel( 
      )
     )
   )
 
 server <- function(input,output){}
 shinyApp(ui,server)
 
 
###### Step 4  Create tabsets with outputs in the UI main panel

 ui <- fluidPage(
   titlePanel(title = "Shiny App for Iris!"),
   # Sidebar layout with input and output definitions ----
   sidebarLayout(
     # Sidebar panel for inputs ----
     sidebarPanel(
       selectInput(inputId="var","Select the variables",choices = c("Sepal.Length"=1,"Sepal.Width"=2,"Petal.Length"=3,"Petal.Width"=4),selected=3,selectize = FALSE),
       sliderInput(inputId="bin","Select the number of bins for histogram",min=5, max=25,value=10),
       radioButtons(inputId="colour",label="Select the colour of the histogram",choices = c("blue","yellow","red"),selected="yellow")
     ),
     
     # Main panel for displaying outputs ----
     mainPanel( 
       tabsetPanel(type="tab",
                   tabPanel("Histogram",textOutput(outputId="text"),plotOutput(outputId="hist")),
                   tabPanel("Data",DTOutput(outputId ="Data_Iris")),
                   tabPanel("Summary",tableOutput(outputId="summary"))
                   )
       
     )
   )
 )
 
 server <- function(input,output){}
 shinyApp(ui,server)

######Step 5 Write up the server part 
 ui <- fluidPage(
   titlePanel(title = "Shiny App for Iris!"),
   # Sidebar layout with input and output definitions ----
   sidebarLayout(
     # Sidebar panel for inputs ----
     sidebarPanel(
       selectInput(inputId="var","Select the variables",choices = c("Sepal.Length"=1,"Sepal.Width"=2,"Petal.Length"=3,"Petal.Width"=4),selected=3,selectize = FALSE),
       sliderInput(inputId="bin","Select the number of bins for histogram",min=5, max=25,value=10),
       radioButtons(inputId="colour",label="Select the colour of the histogram",choices = c("blue","yellow","red"),selected="yellow")
     ),
     
     # Main panel for displaying outputs ----
     mainPanel( 
       tabsetPanel(type="tab",
                   tabPanel("Histogram",textOutput(outputId="text"),plotOutput(outputId="hist")),
                   tabPanel("Data",DTOutput(outputId ="Data_Iris")),
                   tabPanel("Summary",verbatimTextOutput(outputId="summary"))
       )
       
     )
   )
 )
 
 server <- function(input,output){
   output$Data_Iris <- renderDT({
     datatable(iris)
   })
   output$text <- renderText({
     col=as.numeric(input$var)
     paste("The variable names you choose here is ", names(iris[col]))
   })
   output$hist <- renderPlot({
     col=as.numeric(input$var)
     hist(iris[,col],col=input$colour,xlim=c(0,max(iris[,col])),breaks=seq(0,max(iris[,col]),l=input$bin+1),xlab=names(iris[col]),main="Histogram of Iris dataset")
   })
   output$summary <-renderPrint({
     summary(iris)
   })
   
 }
 shinyApp(ui,server)
 

 
 ####### R shiny and  Shinydashboard packages work along with each other. The main framework for building a shiny dashboard is quite similar to R shiny. 
 # Here I built a basic R shiny dashboard by using iris data and mtcars data
 install.packages("shinydashboard")
 install.packages("Dt")
 library(shiny)
 library(shinydashboard)
 library(Dt)

  ui = dashboardPage(skin="green",
     dashboardHeader(title="Shiny dashboard"),
     dashboardSidebar(
       sidebarMenu(
         # Setting id makes input$tabs give the tabName of currently-selected tab
         id = "tabs",
         menuItem("Iris", tabName = "iris", icon = icon("tree")),
         menuItem("Cars", tabName = "cars", icon = icon("car"))
         )
     ),
     dashboardBody(
       tabItems(
       tabItem("iris",
               box(selectInput("variables","Variables:",choices=c("Sepal.Width","Petal.Length","Petal.Width")),width=4),
               box(plotOutput("Correlation_iris"),width=8)
              )
       ,
       tabItem("cars",
               fluidPage(
                 h1("Cars data table:"),
                 DTOutput(outputId ="Data_car")
               )
       )
       
     )
     )
  )
   server = function(input, output) { 
     output$Correlation_iris <- renderPlot({
       plot(iris$Sepal.Length,iris[[input$variables]],xlab="Sepal Length",ylab="Variables")
     })
     output$Data_car <- renderDT({ mtcars
       
     })
     
     
     }

   shinyApp(ui,server )
 