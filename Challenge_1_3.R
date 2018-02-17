# Experimental "Engineering" Solution

# Define # of bee steps
steps <- 64

# Define number of experiments to run
tests <- 100000

# Set initial distance from center
distance_e <- 0

# Set initial location ('side' or 'corner')
location <- 'corner'

# Initialize empty vector for results
result <- c()

#Walking Experiment
for (test in seq(1:tests)){
  for (count_e in seq(1:steps)){
    if (distance_e == 0){ # Force bee to walk forward if currently at distance 0
      distance_e <- distance_e + 1
      location <- 'corner'
    } else if (location == 'corner') { # Determine if bee is on a corner or side
      rand <- sample(1:6, 1) # Select a random number, used to determine bee's next step
      if (rand < 4){
        distance_e <- distance_e + 1 # Move bee forward 3 out of 6 times
        randf <- sample(1:3, 1) # Select random number, used to determine if bee moves to corner or side
        if (randf == 1){
          location == 'corner' # Move bee to corner 1 out of 3 times
        } else {
          location == 'side' # Move bee to side 2 out of 3 times
        }
      } else if (rand == 4 || rand == 5){
        # Distance stays the same, Move bee sideways 2 out of 6 times
        if (distance_e == 1){
          location <- 'corner'
        } else {
          location <- 'side' # Sideways moves from a corner always result on a side unless distance = 1
        }
      } else {
        distance_e <- distance_e - 1 # Move bee backward 1 out of 6 times
        location <- 'corner' # Backward moves from a corner always result on a corner
      }
    } else { # Execute if bee is on a side
      rand <- sample(1:6, 1)  # Select random number, used to determine move direction
      if (rand < 3){
        distance_e <- distance_e + 1  # Move bee forward 2 out of 6 times
        location <- 'side' # Forward moves from a side always result on a side
      } else if (rand == 3 || rand == 4){
        randl <- sample(1:distance_e-1, 1)  # Select random number, used to determine if sideways move goes to corner or side
        distance_e <- distance_e  # Move bee sideways 2 out of 6 times
        if (randl == 1){
          location <- 'corner'  # Moves from side to corner become less likely with increasing distance
        } else {
          location <- 'side'   # Moves from side to side become more likely with increasing distance
        }
      } else {
        randb <- sample(1:distance_e-1, 1) # Select random number, used to determine if backward move goes to corner or side
        distance_e <- distance_e - 1  # Move bee backward 2 out of 6 times
        if (randb == 1){
          location <- 'corner'  # Moves from side to corner become less likely with increasing distance
        } else {
          location <- 'side'  # Moves from side to side become more likely with increasing distance
        }
      }
    }
  }
  result <- append(result, distance_e) # Append latest test to vector of previous tests
  distance_e <- 0 # Reset distance for next test
}

hist(result) # Sanity check, show histogram of results

mean_result <- mean(result) # Calculate average distance traveled
print(mean_result)
sd_result <- sd(result) # Calculate deviation from distance traveled
print(sd_result)

A <- 24
B <- 20
# Create an array of only results >= B, and calculate probability each of these results >= A
conditional_mean <- mean(result[result >= B] >= A)
print(conditional_mean)

