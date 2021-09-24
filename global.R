library(shiny)
library(shinythemes)
library(ggplot2)
library(dplyr)

source("ui.R")
source("server.R")

ghana_data = read.csv("Ghana data shiny.csv", row.names=NULL, sep=";")
sn_data = read.csv("Senegal Market Prices.csv")
bf_data = read.csv("Burkina Faso Market Prices.csv")

shinyApp(ui = ui, server = server)
