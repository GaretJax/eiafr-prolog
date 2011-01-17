#!/usr/bin/env python

import sys
from itertools import combinations

OPTIMIZATIONS = sys.argv[3:]
NAME = sys.argv[2]
PROG = sys.argv[1]
REPETITIONS = 2
N = (100, 500, 1000)

ps = ['']

for i in range(len(OPTIMIZATIONS)):
    ps += combinations(OPTIMIZATIONS, i+1)

goals = [
    "gprolog",
    "--query-goal [{0}]".format(PROG),
    "--query-goal [clp]",
]

for p in ps:
    for n in N:
        goals.append('--query-goal "benchmark({0}, {1}{2}(A, B, C, {3}))"'.format(REPETITIONS, NAME, ''.join(p), n))

print " \\\n".join(goals)