#!/usr/bin/env python3

import sys
import os

scripts_path = os.path.dirname(os.path.realpath(__file__))

sys.path.insert(0, os.path.realpath(os.path.join(scripts_path, '..')))

from opticontest.problems.salesman_euclid.common import Points
from opticontest.problems.salesman_euclid.random_search import Config, Algorithm

from yaml import load as loadYaml

count = int(input())

points = Points()

for x in range(0, count):
    points.add(*map(float, input().split()))

config = Config(
    **loadYaml(
        open(
            os.path.join(
                scripts_path,
                '../../../config/salesman_euclid_random_search.yml',
            ),
        ),
    ),
)

algorithm = Algorithm(config, points)

print(' '.join(map(str, algorithm.solution.indices)))
