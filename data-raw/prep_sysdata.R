RSCgenetable <- read.csv("data-raw/RSCgenetable.csv")
CBCgenetable <- read.csv("data-raw/CBCgenetable.csv")

use_data(RSCgenetable, CBCgenetable, internal = TRUE)
