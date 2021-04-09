HPT_dict_raw <- readxl::read_xlsx("data_raw/HPT_dict.xlsx")
names(HPT_dict_raw) <- c("key", "DE", "EN")
HPT_dict_raw <- HPT_dict_raw[,c("key", "EN", "DE")]
HPT_dict <- psychTestR::i18n_dict$new(HPT_dict_raw)
usethis::use_data(HPT_dict, overwrite = TRUE)
