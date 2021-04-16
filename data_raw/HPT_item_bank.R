item_bank <- read.csv("data_raw/HPT_item_bank.csv")
item_bank <- item_bank[,3:15]
HPT_item_bank <- as.data.frame(item_bank)

#stopifnot(is.numeric(item_bank$answer))
usethis::use_data(HPT_item_bank, overwrite = TRUE)
