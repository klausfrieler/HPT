HPT_item <- function(
  audio_first,
  audio_second,
  audio_separator,
  onsets,
  offsets,
  trial_wait,
  item_number,
  num_items_in_test,
  pos_in_test = NA,
  num_items = NA
) {
  num_chords <- length(onsets)
  stopifnot(num_chords > 1)
  chord_ids <- as.character(seq_len(num_chords))
  chord_btn_ids <- paste("chord_btn_", chord_ids, sep = "")
  params <- list(
    audio_first = audio_first,
    audio_second = audio_second,
    audio_separator = audio_separator,
    onsets = onsets,
    offsets = offsets,
    chord_ids = chord_ids,
    chord_btn_ids = chord_btn_ids,
    trial_wait = trial_wait
  )
  prompt <- tags$div(
    if (!is.na(item_number)) tags$p(tags$strong(psychTestR::i18n("PROGRESS_TEXT", sub = c(num_question = item_number,
                                                                                          test_length = num_items_in_test)))),
    tags$p(psychTestR::i18n("ITEM_INSTRUCTION")),
    tags$style(".highlight { background-color: #b0e8f7 !important; color: black !important;}"),
    tags$script(sprintf("var params = %s;", jsonlite::toJSON(params, auto_unbox = TRUE))),
    includeScript("hpt-trial.js")
  )
  psychTestR::NAFC_page(
    label = paste0("q", item_number),
    prompt = prompt,
    choices = chord_btn_ids,
    labels = chord_ids,
    save_answer = TRUE,
    arrange_vertically = FALSE,
    on_complete = NULL
  )
}
