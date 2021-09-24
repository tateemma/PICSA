ui = navbarPage(theme = shinytheme("united"),
                title = "PICSA Analytics",
                
                #---------------DATA EXPLORER-------------------#
                tabPanel("Data Explorer"),
                
                
                #-----------------SIDEBAR-----------------------# 
                sidebarLayout(
                  sidebarPanel(
                    tags$h3("Select Parameters:"),
                    selectInput("country", "Country:", c("Ghana", "Senegal", "Burkina Faso")),
                    selectInput("market", "Market:",  c("All", unique(as.character(ghana_data$Market_Name)))),
                    selectInput("product", "Product:", c("All", unique(as.character(ghana_data$Product)))) 
                  ),
                  
                  
                  #----------------MAIN PANEL-----------------------#    
                  mainPanel(
                    titlePanel("Product prices for Market: (name) in (country)"),
                    tabsetPanel(
                      
                      #-------------VIEW DATA-------------------#
                      tabPanel("View Data",
                               DT::dataTableOutput("prices")
                      ),
                      
                      #-------------SUMMARY STATS AND BOX PLOTS----------------#
                      tabPanel("Statistics",
                               p("This might take a minute or some seconds to load*"),
                               h4("Summary"),
                               verbatimTextOutput("summary"),
                               
                               h4("Boxplots"),
                               plotOutput("boxplot")
                      ),
                      
                      #-----------------TIME SERIES PLOTS-----------------------#
                      tabPanel("Prices over time",
                               h4("Price over Time in Years and Months"),
                               plotOutput("time_series")
                      )
                     )
                    )
                ),
                
                #-----------------FORECASTING-----------------------#
                tabPanel("Forecast")
)

