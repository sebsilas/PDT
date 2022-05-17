


#' Launch the Pitch Discrimination Task (PDT)
#'
#' @param num_items
#' @param with_final_page
#' @param headphones_page
#'
#' @return
#' @export
#'
#' @examples
PDT <- function(num_items = 10L, with_final_page = TRUE,
                headphones_page = TRUE) {

  timeline <- psychTestR::new_timeline(psychTestR::join(

    psychTestR::one_button_page(shiny::tags$div(
                                shiny::tags$h4("Hello, welcome to the Pitch Discrimination Task!"))),

    if(headphones_page) musicassessr::test_headphones_page(),

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

    musicassessr::final_page_or_continue_to_new_test(final = with_final_page, task_name = "Pitch Discrimination Task")
        ), dict = musicassessr::dict(NULL))

}


#' Launch PDT as a standalone test
#'
#' @param title
#' @param admin_password
#' @param researcher_email
#' @param num_items
#'
#' @return
#' @export
#'
#' @examples
PDT_standalone <- function(title = "Pitch Discrimination Task",
                           admin_password = 'demo',
                           researcher_email = 'sebsilas@gmail.com',
                           num_items = 10L) {

  timeline <- PDT(num_items = num_items)

  psychTestR::make_test(elts = timeline,
                        opt = psychTestR::test_options(
                          title = title,
                          admin_password = admin_password,
                          additional_scripts = musicassessr::musicassessr_js()
                        ))

}


show_item <- function(item, state, ...) {

  item_number <- psychTestRCAT::get_item_number(item)

  tones <- sprintf("playTones([%s, %s, %s]);", item["tone.1"], item["tone.2"], item["tone.3"])

  page <- psychTestR::NAFC_page(label = paste0("q", item_number),
                                prompt = shiny::tags$div(
                                              shiny::tags$script(tones),
                                             shiny::tags$p("Click the odd one out.")),
                                choices = as.character(1:3),
                                arrange_vertically = FALSE)

  return(page)

}

