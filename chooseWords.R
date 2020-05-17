

# try to read in deutsch-english file
library(tidyverse)

# file paths
de_en <- "/Users/felix/Documents/spiderweb/data/de_en_dic.txt"
out_words <- "/Users/felix/Documents/spiderweb/data/10randomwords.csv"

# read data 
deEnDat <- read_tsv(file = de_en)

# format
toDefine <- deEnDat %>%
  slice(as.vector(sample(1:nrow(deEnDat), 10))) %>% 
  rename(german = 1, english = 2) %>% 
  mutate(gender = ifelse(str_detect(german, "\\{n\\}"), "das ", 
                  ifelse(str_detect(german, "\\{f\\}"), "die ",
                  ifelse(str_detect(german, "\\{m\\}"), "der ", NA))),
         gender = ifelse(is.na(gender), "", gender),
         german = str_remove_all(german, "\\{n\\}"),
         german = str_remove_all(german, "\\{f\\}"),
         german = str_remove_all(german, "\\{m\\}")) %>% 
  mutate(germanf = str_c(gender,  german)) %>% 
  dplyr::select(germanf, english) %>% 
  rename(german = germanf)

# write output as csv
write_csv(x = toDefine, path = out_words)

total_time <- Sys.time() - start_time
