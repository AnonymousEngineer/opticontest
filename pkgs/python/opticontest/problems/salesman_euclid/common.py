import math
import random

class Points:
    def __init__(self):
        self.coordinates = []

    def add(self, x, y):
        coordinate = (x, y)
        if coordinate in self.coordinates:
            raise 'already exist'
        self.coordinates.append(coordinate)

    def __getitem__(self, index):
        return self.coordinates[index]

    def __len__(self):
        return len(self.coordinates)

    def distance(self, index1, index2):
        prev_point = self[index1]
        cur_point  = self[index2]

        delta_x = prev_point[0] - cur_point[0]
        delta_y = prev_point[1] - cur_point[1]

        return math.sqrt(delta_x**2 + delta_y**2)

class Solution:
    @staticmethod
    def random(points):
        indices = list(range(0, len(points)))
        random.shuffle(indices)
        return Solution(points, indices)

    def __init__(self, points, indices):
        self.points = points
        self.indices = indices
        self.length = self.__length()

    def __length(self):
        result = 0.0
        for index in range(0, len(self.points) - 1):
            result += self.points.distance(self.indices[index],
                                           self.indices[index + 1])
        return result

    def partial_reverse(self):
        new_indices = self.indices[:]
        stochastic_two_opt(new_indices)
        return Solution(self.points, new_indices)

def stochastic_two_opt(perm):
    c1 = random.randrange(0, len(perm))
    c2 = random.randrange(0, len(perm))
    while c1 == c2:
        c2 = random.randrange(0, len(perm))
    if c2 < c1:
        c1, c2 = c2, c1
    subperm = perm[c1:c2 + 1]
    subperm.reverse()
    perm[c1:c2 + 1] = subperm
