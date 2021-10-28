#;; Snippets for presentation

library(jsonlite)
library(tidyverse)

#;; Make a sample df
example_df <-
    tibble(col1=1:3, col2=LETTERS[1:3], col3=c("x", "x", "y"))

#;; What does it look like when converted to JSON?
toJSON(example_df, pretty = TRUE)
toJSON(example_df, dataframe = "columns", pretty = TRUE)

#;; Let's reparse from JSON to R object:

#;; This format natively converts to dataframes
toJSON(example_df, pretty = TRUE) %>%
    fromJSON()

#;; This one you have to explicitly ask to convert, but is not hard.
toJSON(example_df, dataframe = "columns", pretty = TRUE) %>%
    fromJSON() %>%
    as_tibble()


#;;-----------------------------------------------------------------------------
#;; Starting from a list of lists.
#;; This is a common structure for a data.frame encoded in a JSON string, and
#;; what it gets parsed to in R from tools such as `jsonlite`.
example_lst <- list(
    list(col1=1, col2="A", col3="x"),
    list(col1=2, col2="B", col3="x"),
    list(col1=3, col2="C", col3="y")
)

#;; This doesn't work
example_lst %>%
    as_tibble()

#;; Can make work by reshaping, assuming that this really represents a
#;; dataframe, and all columns are of the same length, and align properly.
#;; Takes some extra work though.
example_lst %>%
    transpose() %>%
    as_tibble() %>%
    mutate_all(unlist)


#;; The tidyr rectangling approach:
tibble(obj=example_lst) %>%
    unnest_wider(obj)

#;; You can hoist out parts.  It is actually removed from the obj column list-column
tibble(obj=example_lst) %>%
    hoist(obj, "col2")






#;;=============================================================================
#;; For presentation

#;; ss-01
read_json(here::here("dat", "simple-character-list.json")) %>%
    str(list.len=3)

#;; ss-02
read_json(here::here("dat", "simple-character-list.json")) %>%
    as_tibble()

#;; ss-03
read_json(here::here("dat", "simple-character-list.json")) %>%
    transpose() %>%
    str(list.len=3)

#;; ss-03
read_json(here::here("dat", "simple-character-list.json")) %>%
    transpose() %>%
    as_tibble() %>%
    str(list.len=3)

#;; ss-04
read_json(here::here("dat", "simple-character-list.json")) %>%
    transpose() %>%
    as_tibble() %>%
    print(n=3)

#;; ss-05
read_json(here::here("dat", "simple-character-list.json")) %>%
    transpose() %>%
    as_tibble() %>%
    mutate_all(unlist) %>%
    print(n=3)

#;; ss-06
read_json(here::here("dat", "simple-character-list.json")) %>%
    tibble(obj=.) %>%
    unnest_wider(obj) %>%
    print(n=3)

#;; ss-07
read_json(here::here("dat", "simple-character-list.json")) %>%
    tibble(obj=.) %>%
    hoist(obj, "title") %>%
    print(n=3)




#;;=============================================================================
#;; Gnarly demo

#;; ss-08
jsonComplex_lst <-
    read_json(here::here("dat", "complex-json.json"))
listviewer::jsonedit(jsonComplex_lst)


#;; ss-09
parameters_df <-
  tibble(obj=jsonComplex_lst) %>%
  filter(names(obj) == "data") %>%
  unnest_longer(obj) %>%
  unnest_wider(obj) %>%
  select(tisObjectId, parameters) %>%
  unnest_longer(parameters) %>%
  unnest_wider(parameters) %>%
  select(tisObjectId, parameterName=name, values) %>%
  unnest_longer(values) %>%
  unnest_wider(values) %>%
  mutate(value = unlist(value)) %>%
  pivot_wider(names_from = "parameterName", values_from = "value")
parameters_df %>%
    print(n=3)
