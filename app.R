library(shiny)
library(psychTestR)
library(psychTestRCAT)
library(htmltools)

item.bank <- read.csv("ItemBank.csv")


show.item <- function(item, state, ...) {

  item_number <- psychTestRCAT::get_item_number(item)
  
  tones <- sprintf("playTones([%s, %s, %s]);", item["tone.1"], item["tone.2"], item["tone.3"])
  
  print(tones)
  
  NAFC_page(label = paste0("q", item_number), 
             prompt = div(includeScript("www/js/Tone.js"),
                          includeScript("www/js/main.js"),
                          shiny::tags$script(tones),
                          shiny::tags$p("Click the odd one out.")),
             choices = c("1","2","3"),
            arrange_vertically = FALSE
             )
  
}

timeline <- psychTestR::join(one_button_page("Hello, welcome to the test"),
        psychTestRCAT::adapt_test(label = "PDCT", 
        item_bank = item.bank,
        show_item = show.item,
        stopping_rule = stopping_rule.num_items(n = 10),
        opt = adapt_test_options(next_item.criterion = "MFI",
                               next_item.estimator = "BM", next_item.prior_dist = "norm",
                                 next_item.prior_par = c(0, 1), final_ability.estimator = "BM",
                                 constrain_answers = FALSE, avoid_duplicates = NULL,
                                 cb_control = NULL, cb_group = NULL, eligible_first_items = NULL,
                                 notify_duration = 5)), final_page("The End!"))


PDCT.test <- make_test(elts = timeline)

#shiny::runApp(PDCT.test)




