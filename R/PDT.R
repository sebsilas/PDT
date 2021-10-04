#' Load the Pitch Discrimination Task (PDT)
#'
#' @param num_items
#'
#' @return
#' @export
#'
#' @examples
PDT <- function(num_items = 10L) {

  timeline <- psychTestR::new_timeline(psychTestR::join(

    psychTestR::one_button_page(shiny::tags$div(musicassessr::musicassessr_js_scripts('A','B','C','D', 'E'), shiny::tags$h4("Hello, welcome to the Pitch Discrimination Task!"))),
    musicassessr::test_headphones_page(),
    psychTestR::one_button_page(shiny::tags$div(shiny::tags$p("In this task, on each trial you will hear three tones."),
                          shiny::tags$p("One will be higher than the other two."),
                          shiny::tags$p("You must click which tone you think is the odd one out (the highest tone)."))),
    psychTestR::one_button_page(shiny::tags$h4("Let's begin!")),

          psychTestRCAT::adapt_test(label = "PDT",
          item_bank = PDCT_item_bank,
          show_item = show_item,
          stopping_rule = psychTestRCAT::stopping_rule.num_items(n = num_items),
          opt = psychTestRCAT::adapt_test_options(next_item.criterion = "bOpt",
                                 next_item.estimator = "BM",
                                  final_ability.estimator = "WL",
                                    eligible_first_items = c(289, 292, 295)
                                 )),
          # save results
    psychTestR::elt_save_results_to_disk(complete = FALSE),
          # final page if standalone
    psychTestR::final_page("You have completed the Pitch Discrimination Task!")
        ), dict = musicassessr::dict(NULL))


  PDT.test <- psychTestR::make_test(elts = timeline)

  shiny::runApp(PDT.test)

}


show_item <- function(item, state, ...) {

  item_number <- psychTestRCAT::get_item_number(item)

  tones <- sprintf("playTones([%s, %s, %s]);", item["tone.1"], item["tone.2"], item["tone.3"])

  page <- psychTestR::NAFC_page(label = paste0("q", item_number),
                                prompt = shiny::tags$div(
                                  musicassessr::musicassessr_js_scripts('A','B','C','D', 'E'),
                                              shiny::tags$script(tones),
                                             shiny::tags$p("Click the odd one out.")),
                                choices = as.character(1:3),
                                arrange_vertically = FALSE)

  return(page)

}

