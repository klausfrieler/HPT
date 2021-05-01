training_answers  <- c("chord_btn_3", "chord_btn_2", -1)


ask_repeat <- function(prompt) {
  psychTestR::NAFC_page(
    label = "ask_repeat",
    prompt = prompt,
    choices = c("go_back", "continue"),
    labels = lapply(c("GOBACK", "CONTINUE"), psychTestR::i18n),
    save_answer = FALSE,
    arrange_vertically = FALSE,
    on_complete = function(state, answer, ...) {
      psychTestR::set_local("do_intro", identical(answer, "go_back"), state)
    }
  )
}


make_practice_page <-  function(page_no, audio_dir) {
  psychTestR::reactive_page(function(answer, ...) {
    correct <- "INCORRECT"
    if (page_no > 1 && answer == training_answers[page_no-1]) correct <- "CORRECT"
    feedback <- psychTestR::i18n(correct)
    get_practice_page(page_no, feedback, audio_dir)
  })
}


get_practice_page <- function(page_no, feedback, audio_dir){
  sample_audios <- list(
    c("I-ii-V-I___original.mp3", "I-ii-V-I____3_aug_5_sharp.mp3"),
    c("original_prog01_I-V-I-V.mp3", "prog01_I-V-I-V_2_min_6.mp3")
  )
  audio_separator = file.path(audio_dir, "rain-noise-update-5.mp3")

  if(page_no < 3) {
    key <- sprintf("PRACTICE%d", page_no)
    audio_first = file.path(audio_dir, sample_audios[[page_no]][1])
    audio_second = file.path(audio_dir,sample_audios[[page_no]][2] )
    page <- HPT_item(
      audio_first = audio_first,
      audio_second = audio_second,
      audio_separator = audio_separator,
      item_number = page_no,
      num_items_in_test = 3,
      feedback = feedback,
      key = key
    )
  }
  else {
    key <- "TRANSITION"
    prompt <- psychTestR::i18n(key, html = T, sub = list(feedback = feedback))
    page <- ask_repeat(prompt)
  }
  page
}


practice <- function(audio_dir) {
  lapply(1:3, make_practice_page, audio_dir) %>% unlist()
}
