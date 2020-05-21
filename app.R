library(shiny)
library(psychTestR)
library(psychTestRCAT)

item.bank <- read.csv("ItemBank.csv")


page.return <- function(item, state, ...) {
  
  NAFC_page(label = item[, "label"], 
            prompt = shiny::tags$button(id = "playTones", 
                               onclick=sprintf("playTones(%s, %s, %s)", item[, "tone.1"], item[, "tone.2"], item[, "tone.3"])),
            choices = c("1","2","3")
            )
  
}

PDCT.test <- psychTestRCAT::adapt_test(label = "PDCT", 
        item_bank = item.bank,
        show_item = page.return,
        stopping_rule = stopping_rule.num_items(n = NULL),
        opt = adapt_test_options(next_item.criterion = "MLP",
                               next_item.estimator = "BM", next_item.prior_dist = "norm",
                                 next_item.prior_par = c(0, 1), final_ability.estimator = "BM",
                                 constrain_answers = FALSE, avoid_duplicates = NULL,
                                 cb_control = NULL, cb_group = NULL, eligible_first_items = NULL,
                                 notify_duration = 5)
        )

shiny::runApp(PDCT.test)

