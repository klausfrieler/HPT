info_page <- function(id, style = "text-align:justify;
                      margin-left:20%;margin-right:20%") {
  psychTestR::one_button_page(shiny::div(psychTestR::i18n(id, html = TRUE),
                                         style = style),
                              button_text = psychTestR::i18n("CONTINUE"))
}

instructions <- function(audio_dir) {
  c(
    psychTestR::code_block(function(state, ...) {
      psychTestR::set_local("do_intro", TRUE, state)
    }),
    info_page("INSTRUCTIONS"),
    info_page("SAMPLE1a"),
    show_sample_page(audio_dir),
    info_page("SAMPLE1b"),
    psychTestR::while_loop(
      test = function(state, ...) psychTestR::get_local("do_intro", state),
      logic = c(
        practice(audio_dir)
      )),
    psychTestR::one_button_page(psychTestR::i18n("MAIN_INTRO"),
                                button_text = psychTestR::i18n("CONTINUE"))
  )
}

show_sample_page <- function(audio_dir){
  num_chords <- length(onsets)
  stopifnot(num_chords > 1)
  chord_ids <- as.character(seq_len(num_chords))
  chord_btn_ids <- paste("chord_btn_", chord_ids, sep = "")
  audio_first <- file.path(audio_dir, "original_prog01_I-V-I-V.mp3")
  audio_second <- file.path(audio_dir, "prog01_I-V-I-V_3_maj_6.mp3")
  audio_separator <- file.path(audio_dir, "rain-noise-update-5.mp3")
  trial_wait = 0.5
  HPT_item(
    audio_first = audio_first,
    audio_second = audio_second,
    audio_separator = audio_separator,
    item_number = 1,
    num_items_in_test = 1,
    onsets = onsets,
    offsets = offsets,
    trial_wait = trial_wait,
    pos_in_test = 3,
    num_items = 3
  )
}
