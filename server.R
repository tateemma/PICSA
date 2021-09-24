server = function(input, output, session) {
   
   selected_country <- reactive({
      prices <- ghana_data
      if (input$country == "Senegal") {
         prices <- sn_data
      }
      else if (input$country == "Burkina Faso") {
         prices <- bf_data
      }
      prices
   })
   
   observe({
      updateSelectInput(session, "market", choices = c("All", unique(as.character(selected_country()$Market_Name))))
   })
   
   observe({
      updateSelectInput(session, "product", choices = c("All", unique(as.character(selected_country()$Product))))
   })
   
   output$prices = DT::renderDataTable(DT::datatable({
      prices_table = selected_country()
      if (input$market != "All"){
         prices_table = prices_table[prices_table$Market_Name == input$market,]
      }
      if (input$product != "All"){
         prices_table = prices_table[prices_table$Product == input$product,]
      }
      prices_table
   }))
   
   output$summary = renderPrint({
      prices_table = selected_country()
      if (input$market != "All"){
         prices_table = prices_table[prices_table$Market_Name == input$market,]
      }
      if (input$product != "All"){
         prices_table = prices_table[prices_table$Product == input$product,]
      }
      summary(prices_table)
   })
   
   output$boxplot = renderPlot({
      prices_table = selected_country()
      if (input$market != "All"){
         prices_table = prices_table[prices_table$Market_Name == input$market,]
      }
      if (input$product != "All"){
         prices_table = prices_table[prices_table$Product == input$product,]
      }
      ggplot(prices_table, 
             aes(x=as.character(Year), y=Price, fill=as.character(Year))) + geom_boxplot() + 
         facet_grid(Product~Market_Name, scales="free") + 
         xlab("Product") + 
         ylab("Price") +
         theme(axis.text.x = element_text(angle = 90))
   })
   
   output$time_series = renderPlot({
      prices_table = selected_country()
      if (input$market != "All"){
         prices_table = prices_table[prices_table$Market_Name == input$market,]
      }
      if (input$product != "All"){
         prices_table = prices_table[prices_table$Product == input$product,]
      }
      ggplot(prices_table %>% mutate(Month = formatC(Month, width = 2, format = "d", flag = "0"), Year_Month = (paste0(Year, "-", Month))) %>% 
                group_by(Year_Month,Product,Market_Name) %>% 
                summarise_at(c("Price"), mean, na.rm = TRUE), aes(x=Year_Month, y=Price)) + 
         geom_line(aes(col=Market_Name, group=Market_Name)) + 
         xlab("Time (Years and Months)") + ylab("Average Price") + 
         scale_y_continuous(labels = scales::comma) + 
         facet_grid(Product~., scales="free_y") +
         theme(axis.text.x = element_text(angle = 90))
   })
}


