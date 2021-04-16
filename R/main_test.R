onsets <- 0:3
offsets <- 1:4

get_eligible_first_items_HPT <- function(){
  lower_sd <- mean(HPT::HPT_item_bank$difficulty) - stats::sd(HPT::HPT_item_bank$difficulty)
  upper_sd <- mean(HPT::HPT_item_bank$difficulty) + stats::sd(HPT::HPT_item_bank$difficulty)
  which(HPT::HPT_item_bank$difficulty >= lower_sd  &
          HPT::HPT_item_bank$difficulty <= upper_sd)
}

main_test <- function(label, audio_dir, num_items,
                      next_item.criterion,
                      next_item.estimator,
                      next_item.prior_dist = next_item.prior_dist,
                      next_item.prior_par = next_item.prior_par,
                      final_ability.estimator,
                      constrain_answers) {
  item_bank <- HPT::HPT_item_bank
  psychTestRCAT::adapt_test(
    label = label,
    item_bank = item_bank,
    show_item = show_item(audio_dir),
    stopping_rule = psychTestRCAT::stopping_rule.num_items(n = num_items),
    opt = HPT_options(next_item.criterion = next_item.criterion,
                      next_item.estimator = next_item.estimator,
                      next_item.prior_dist = next_item.prior_dist,
                      next_item.prior_par = next_item.prior_par,
                      final_ability.estimator = final_ability.estimator,
                      constrain_answers = constrain_answers,
                      eligible_first_items = get_eligible_first_items_HPT(),
                      item_bank = item_bank)
  )
}

show_item <- function(audio_dir) {
  function(item, state, ...) {
    stopifnot(is(item, "item"), nrow(item) == 1L)
    items <- psychTestR::get_local("items", state)
    pos_in_test <- psychTestR::get_local("pos_in_test", state)
    item_number <- psychTestRCAT::get_item_number(item)
    num_items_in_test <- psychTestRCAT::get_num_items_in_test(item)
    answer <- item$answer
    first_audio_link <- item$orig_prog
    second_audio_link <- item$prog_name
    audio_first <- file.path(audio_dir, first_audio_link)
    audio_second <- file.path(audio_dir, second_audio_link)
    audio_separator <- file.path(audio_dir, "rain-noise-update-5.mp3")
    trial_wait <- 0.5
    HPT_item(
      audio_first = audio_first,
      audio_second = audio_second,
      audio_separator = audio_separator,
      item_number = item_number,
      num_items_in_test = num_items_in_test,
      onsets = onsets,
      offsets = offsets,
      trial_wait = trial_wait,
      pos_in_test = item,
      num_items = length(items)
    )
    }
}


