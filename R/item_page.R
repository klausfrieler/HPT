HPT_item <- function(audio_first,
                     audio_second,
                     audio_separator,
                     num_chords = 4,
                     trial_wait = .5,
                     item_number,
                     num_items_in_test,
                     feedback = NA,
                     key = NA) {
  #message("HPT_item called")
  #browser()

  chord_btn_ids <- paste("chord_btn_", seq_len(num_chords), sep = "")
  params <- list(
    audio_first = audio_first,
    audio_second = audio_second,
    audio_separator = audio_separator,
    onsets = seq(0, num_chords - 1),
    offsets = 1:num_chords,
    chord_ids = 1:num_chords,
    chord_btn_ids = chord_btn_ids,
    trial_wait = trial_wait
  )
  #message(paste(as.character(params), collapse = ", "))
  if (is.na(key)) {
    prompt <- shiny::tags$div(
      if (!is.na(item_number))
        shiny::tags$p(shiny::tags$strong(psychTestR::i18n("PROGRESS_TEXT",
                                                          sub = c(num_question = item_number,
                                                                  test_length = num_items_in_test)))),
                                                                  shiny::tags$div(psychTestR::i18n("ITEM_INSTRUCTION"),
                                                                  style = "text-align:justify;margin-left:25%;margin-right:25%;margin-bottom:1em"),
      shiny::tags$style(".highlight { background-color: #b0e8f7 !important; color: black !important;}"),
      shiny::tags$script(sprintf("var params = %s;", jsonlite::toJSON(params, auto_unbox = TRUE))),
      shiny::includeScript(system.file("js/hpt-trial.js", package = "HPT"))
      )}
  else {
    prompt <- shiny::tags$div(
    shiny::tags$div(psychTestR::i18n(key, html = T,
                            sub = list(feedback = feedback)), style = "text-align:justify;
                      margin-left:25%;margin-right:25%;margin-bottom:1em"),
    shiny::tags$style(".highlight { background-color: #b0e8f7 !important; color: black !important;}"),
    shiny::tags$script(sprintf("var params = %s;", jsonlite::toJSON(params, auto_unbox = TRUE))),
    shiny::includeScript(system.file("js/hpt-trial.js", package = "HPT"))
    )}
  #message("HPT item check point")
  psychTestR::NAFC_page(
    label = paste0("q", item_number),
    prompt = prompt,
    choices = chord_btn_ids,
    labels = as.character(1:num_chords),
    save_answer = FALSE,
    arrange_vertically = FALSE,
    on_complete = NULL
  )
}
