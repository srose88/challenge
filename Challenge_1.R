steps <- 1

count <- 0
distance <- 0
while (count < steps){
  distance <- if (distance == 0){
    distance <- distance + 1
  } else {
    corner <- ((1/6)*(distance-1) + (2/6)*(distance) + (3/6)*(distance+1))
    side <- ((2/6)*(distance-1) + (2/6)*(distance) + (2/6)*(distance+1))
    distance <- (1/(distance))*corner + (1-1/(distance))*side
  }
  count <- count + 1
}

# Experimental
steps <- 16
tests <- 6

count_e <- 0
distance_e <- 0
location <- 'corner'
test <- 1
result <- c()
while (test <= tests){
  while (count_e < steps){
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
    count_e <- count_e + 1
  }
  result <- append(result, distance_e)
  test <- test + 1
}


