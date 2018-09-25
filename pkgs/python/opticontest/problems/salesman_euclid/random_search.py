from opticontest.problems.salesman_euclid.common import Solution

class Config:
    def __init__(self, **kwargs):
        self.__set_max_iterations(kwargs[':max_iterations'])

    def __set_max_iterations(self, value):
        value = int(value)
        if value < 1:
            raise RuntimeError('invalid value')
        self.max_iterations = value

class Algorithm:
    def __init__(self, config, points):
        self.config = config
        self.points = points

        self.solution = self.__solve()

    def __solve(self):
        best_solution = Solution.random(self.points)
        for x in range(0, self.config.max_iterations):
            current_solution = Solution.random(self.points)
            if current_solution.length < best_solution.length:
                best_solution = current_solution
        return best_solution
