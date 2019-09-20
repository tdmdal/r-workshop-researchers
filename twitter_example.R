library(rtweet)
library(tidytext)
library(dplyr)
library(ggplot2)
library(wordcloud2)

# search for 1000 tweets (non-retweeted) using the "rstats" hashtag
rt <- search_tweets(
  "#rstats", n = 1000, include_rts = FALSE
)

# extra stop words
extra_sw <- "t.co|https|rstats"

# top words
rt %>%
  select(text) %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words) %>%
  filter(!grepl(extra_sw, word)) %>%
  count(word, sort = TRUE) %>%
  top_n(10) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
    geom_col() +
    xlab(NULL) +
    coord_flip()

# world cloud
rt %>%
  select(text) %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words) %>%
  filter(!grepl(extra_sw, word)) %>%
  count(word, sort = TRUE, name = "freq") %>%
  top_n(50) %>%
  wordcloud2()

