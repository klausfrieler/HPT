HPT_dict_raw <- readxl::read_xlsx("data_raw/HPT_dict.xlsx")
HPT_dict_raw <- HPT_dict_raw[,c("key", "EN", "DE", "DE_F")]
HPT_dict <- psychTestR::i18n_dict$new(HPT_dict_raw)
usethis::use_data(HPT_dict, overwrite = TRUE)
