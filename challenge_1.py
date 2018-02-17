import numpy as np
steps = 1

# Initialize list of maximum distance
max_distance = list(range(1,steps+1))

# Initialize list of position at 0 distance
positions = {0:[1]}

# Create / append possible positions lists for each distance
for distance in max_distance:
    positions[distance] = list(range(positions[distance-1][-1]+1,6*distance+positions[distance-1][-1]+1))

corners = [1]
# Define list of corners
for distance in max_distance:
    corners += list(range(positions[distance-1][-1]+1,6*distance+positions[distance-1][-1]+1, distance))

# Initialize list defining possible directions from each position
directions = list(range(1,7))
            

# Define recursive function
def walk_hex(steps, current_distance=0, current_position=1, current_index=0):
    if steps == 0:
        return current_distance
    else:
        if current_distance == 0:
            change = 1
            current_position = 
        else:
            if current_position in corners:
                if direction == 1:
                    current_position = positions[current_distance+1][int((current_index*(current_distance+1))/current_distance)]
                    change = 1
                elif direction == 2:
                    current_position = positions[current_distance+1][int((current_index*(current_distance+1))/current_distance+1)]
                    change = 0
                elif direction == 3:
                    current_position = positions[current_distance+1][int((current_index*(current_distance+1))/current_distance-1)]
                    change = 0
                elif direction == 4:
                    current_position = positions[current_distance][int(current_index+1)]
                    change = 0
                elif direction == 5:
                    current_position = positions[current_distance][int(current_index-1)]
                    change = 0
                else:
                    current_position = positions[current_distance-1][int((current_index*(current_distance-1))/current_distance)]
                    change = -1
            else:
                if direction == 1:
                    current_position = positions[current_distance+1][]
                    change = 1
                elif direction == 2:
                    current_position = positions[current_distance+1][]
                    change = 1
                elif direction == 3:
                    current_position = positions[current_distance][int(current_index+1)]
                    change = 0
                elif direction == 4:
                    current_position = positions[current_distance][int(current_index-1)]
                    change = 0
                elif direction == 5:
                    current_position = positions[current_distance-1][]
                    change = -1
                else:
                    current_position = positions[current_distance-1][]
                    change = -1        
            
        return np.mean(walk_hex(steps-1, current_distance+change, current_position, positions[current_distance+change].index(current_position)) for direction in directions)

print(walk_hex(2))