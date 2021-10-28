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


![Input structure](img/ss-00.png)

***
![Input structure](img/ss-01.png)


Common JSON Input, converting to dataframe, simple try
========================================================
From this form, we get an error.

![Try to parse simply](img/ss-02.png)



Common JSON Input, converting to dataframe, extra work
========================================================

![Try the transpose](img/ss-03.png)


Common JSON Input, converting to dataframe, extra work
========================================================

![Try the transpose](img/ss-04.png)


Common JSON Input, converting to dataframe, extra work
========================================================

![Try the transpose](img/ss-05.png)


Common JSON Input, tidyr Rectangling API
========================================================
Stick the list in a table, and unnest it.

![Try the transpose](img/ss-06.png)


Common JSON Input, tidyr Rectangling API
========================================================
You can use `hoist()` to pick out only parts you want.

![Try the transpose](img/ss-07.png)


`tidyr` Rectangling: The Deep End Demo
========================================================
![Gnarly JSON to DataFrames in 2 simple steps](img/draw-the-rest-of-the-owl.png)


`tidyr` Rectangling: The Deep End Demo
========================================================

![Complex code](img/ss-08.png)
![Complex listview](img/listviewer-complex-json.png)


`tidyr` Rectangling: The Deep End Demo
========================================================
![Complex code result](img/ss-09.png)



References
========================================================
- Rectangling Vignette, tidyr: https://tidyr.tidyverse.org/articles/rectangle.html
