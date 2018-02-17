import random

directions = {1: 'top',
              2: 'bottom_left',
              3: 'top_left',
              4: 'bottom_right',
              5: 'top_right',
              6: 'bottom'}

steps = 16
tests = 10000

class hexagon:
    def __init__(self):
        self.neighbors = {}
    
    def setNeighbor(self, location, neighbor)
        self.neighbors[location] = neighbor
    
    def getNeighbor(self, d):
        self.neighbors.setdefault(d, createNeighbor(d))

    def createNeighbor(self, d):
        newLoc = hexagon()
        newLoc.setNeighbor(directions[7 - d], self)


class grid:
    def __init__(self):
        self.center = hexagon()
        

        self.location = self.center
        self.distance = 0
        self.curDirection = None

    def step(self):
        r = random.randint(1, 6)
        self.updateDistance(self.directions[r])
        self.location = self.location.getNeighbor(self.directions[r])

    def updateDistance(self, direction):
        if self.curDirection == None:
            self.distance += 1
            self.curDirection = direction
        else:

    
    def calculateDistance(self):
        
        return self.isCenter(self.location)

    # def isCenter(self, node, dist=0):
    #     if node == self.center:
    #         return dist
    #     else:
    #         for neighbor in node.neighbors.values():
    #             return self.isCenter(neighbor, dist=dist+1)

def main():
    for (tests in range(1, 10000)):
        g = grid()
        for (step in range(0, 16)):
            g.step()
        
        g.calculateDistance()