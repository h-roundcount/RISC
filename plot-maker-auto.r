library(tmap)

load("data/vdem.RData")

tmap_save(my_map, "map1.html", selfcontained = TRUE)