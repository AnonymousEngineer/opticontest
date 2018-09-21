import math

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
