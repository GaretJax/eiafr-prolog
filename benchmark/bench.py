#!/usr/bin/env python

OPTIMIZATIONS = ('1', '2', '2a', '3')
NAME = 'triplet'
REPETITIONS = 2
N = (100, 500, 1000)


from itertools import combinations

ps = ['']

for i in range(len(OPTIMIZATIONS)):
    ps += combinations(OPTIMIZATIONS, i+1)

goals = [
    "gprolog",
    "--query-goal [ex03]",
    "--query-goal [clp]",
]

for p in ps:
    for n in N:
        goals.append('--query-goal "benchmark({2}, {0}{1}(A, B, C, {3}))"'.format(NAME, ''.join(p), REPETITIONS, N))

print " \\\n".join(goals)