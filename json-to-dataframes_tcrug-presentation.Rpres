Turning JSON into Dataframes
========================================================
author: Matt Pettis (matthew.pettis@gmail.com)
date: 2021-10-28
autosize: true

Who am I?
========================================================
incremental: true

- Matt Pettis.  Hi.
- Sr. Data Scientist, TraneTechnology
- Avid something-something.



Common JSON Input
========================================================
```
[
    {
        "id": 0,
        "name": "Daenerys Targaryen",
        "title": "Mother of Dragons"
    },
    {
        "id": 1,
        "name": "Samwell Tarly",
        "title": "Maester"
    },
    ..
]
```

Common JSON Input, parsed by jsonlite
========================================================

```
read_json(here::here("dat", "simple-character-list.json")) %>%
    str(list.len=3)

List of 20
 $ :List of 3
  ..$ id   : int 0
  ..$ name : chr "Daenerys Targaryen"
  ..$ title: chr "Mother of Dragons"
 $ :List of 3
  ..$ id   : int 1
  ..$ name : chr "Samwell Tarly"
  ..$ title: chr "Maester"
 $ :List of 3
  ..$ id   : int 2
  ..$ name : chr "Jon Snow"
  ..$ title: chr "King of the North"
  [list output truncated]
```



Common JSON Input, converting to dataframe, simple try
========================================================
```
read_json(here::here("dat", "simple-character-list.json")) %>%
    as_tibble()

Error: Columns 1, 2, 3, 4, 5, and 15 more must be named.
Use .name_repair to specify repair.
Run `rlang::last_error()` to see where the error occurred.
```


Common JSON Input, converting to dataframe, extra work
========================================================

`transpose`, and `mutate`/`unlisting` are clunky.
```
read_json(here::here("dat", "simple-character-list.json")) %>%
    transpose() %>%
    as_tibble() %>%
    mutate_all(unlist) %>%
    print(n=3)

# A tibble: 20 x 3
     id name               title            
  <int> <chr>              <chr>            
1     0 Daenerys Targaryen Mother of Dragons
2     1 Samwell Tarly      Maester          
3     2 Jon Snow           King of the North
# ... with 17 more rows
```


`tidyr` Rectangling
========================================================

We can do this with an API designed for such things:

```
read_json(here::here("dat", "simple-character-list.json")) %>%
    tibble(obj=.) %>%
    unnest_wider(obj) %>%
    print(n=3)

# A tibble: 20 x 3
     id name               title            
  <int> <chr>              <chr>            
1     0 Daenerys Targaryen Mother of Dragons
2     1 Samwell Tarly      Maester          
3     2 Jon Snow           King of the North
# ... with 17 more rows
```



`tidyr` Rectangling
========================================================

We can use the API to just pull out parts we want:
```
read_json(here::here("dat", "simple-character-list.json")) %>%
    tibble(obj=.) %>%
    hoist(obj, "title") %>%
    print(n=3)

# A tibble: 20 x 2
  title             obj             
  <chr>             <list>          
1 Mother of Dragons <named list [2]>
2 Maester           <named list [2]>
3 King of the North <named list [2]>
# ... with 17 more rows
```

`tidyr` Rectangling: The Deep End Demo
========================================================
![Gnarly JSON to DataFrames in 2 simple steps](img/draw-the-rest-of-the-owl.png)



References
========================================================
- Rectangling Vignette, tidyr: https://tidyr.tidyverse.org/articles/rectangle.html
