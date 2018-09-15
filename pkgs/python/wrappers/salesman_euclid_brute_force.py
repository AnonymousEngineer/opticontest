#!/usr/bin/env python3

import sys
import os

scripts_path = os.path.dirname(os.path.realpath(__file__))

sys.path.insert(0, os.path.realpath(os.path.join(scripts_path, '..')))

from opticontest.salesman_euclid.brute_force import Algorithm

count = int(input())

points = []

for x in range(0, count):
    points.append(list(map(float, input().split())))

algorithm = Algorithm(points)

print(' '.join(map(str, algorithm.solution.indices)))
