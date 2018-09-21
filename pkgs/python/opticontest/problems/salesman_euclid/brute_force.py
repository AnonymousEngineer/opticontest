from opticontest.problems.salesman_euclid.common import Solution

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
