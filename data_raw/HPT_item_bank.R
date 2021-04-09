item_bank <- read.csv("data_raw/HPT_item_bank.csv")
HPT_item_bank <- as.data.frame(item_bank)

#stopifnot(is.numeric(item_bank$answer))
usethis::use_data(HPT_item_bank, overwrite = TRUE)

