import math

class Algorithm:
    def __init__(self, points):
        self.points = points
        self.solution = None
        self.__rec([])

    def count(self):
        return len(self.points)

    def __rec(self, indices):
        if len(indices) == self.count():
            self.__add_solution(indices)
            return

        for index in [i for i in range(0, self.count()) if i not in indices]:
            self.__rec(indices + [index])

    def __add_solution(self, indices):
        new_solution = Solution(self.points, indices)
        if not self.solution or new_solution.length < self.solution.length:
            self.solution = new_solution

class Solution:
    def __init__(self, points, indices):
        self.points = points
        self.indices = indices
        self.length = self.__length()

    def __length(self):
        result = 0.0
        for index in range(0, len(self.points) - 1):
            result += self.__distance(self.indices[index],
                                      self.indices[index + 1])
        return result

    def __distance(self, index1, index2):
        prev_point = self.points[index1]
        cur_point  = self.points[index2]

        delta_x = prev_point[0] - cur_point[0]
        delta_y = prev_point[1] - cur_point[1]

        return math.sqrt(delta_x**2 + delta_y**2)
