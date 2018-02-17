# Experimental
steps <- 16
tests <- 1000

distance_e <- 0
location <- 'corner'
result <- c()
for (test in seq(1:tests)){
  for (count_e in seq(1:steps)){
    if (distance_e == 0){
      distance_e <- distance_e + 1
      location <- 'corner'
    } else if (location == 'corner') {
      rand <- sample(1:6, 1)
      if (rand < 4){
        distance_e <- distance_e + 1
        randf <- sample(1:3, 1)
        if (randf == 1){
          location == 'corner'
        } else {
          location == 'side'
        }
      } else if (rand >= 4 && rand < 6){
        distance_e <- distance_e
        if (distance_e == 1){
          location <- 'corner'
        } else {
          location <- 'side'
        }
      } else {
        distance_e <- distance_e - 1
        location <- 'corner'
      }
    } else {
      rand <- sample(1:6, 1)
      if (rand < 3){
        distance_e <- distance_e + 1
        location <- 'side'
      } else if (rand >= 3 && rand < 5){
        randl <- sample(1:distance_e-1, 1)
        distance_e <- distance_e
        if (randl == 1){
          location <- 'corner'
        } else {
          location <- 'side'
        }
      } else {
        randb <- sample(1:distance_e-1, 1)
        distance_e <- distance_e - 1
        if (randb == 1){
          location <- 'corner'
        } else {
          location <- 'side'
        }
      }
    }
  }
  result <- append(result, distance_e)
  distance_e <- 0
  location <- 'corner'
}

hist(result)
options(digits = 10)
print(mean(result))