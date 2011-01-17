#!/usr/bin/env python

import sys
from pyparsing import *

data = sys.stdin.read()

integer = Word(nums)
prefix = Literal('|') + Literal('?-')
name = Word(alphas, alphanums + "_")
end = Literal('.')

start = prefix + Literal('benchmark(') + integer.setResultsName("repetitions") + Literal(',') + name.setResultsName("name") + SkipTo(integer) + integer.setResultsName("n") + SkipTo(end) + end
solutions = Literal('there are') + integer.setResultsName("solutions") + Literal('solutions')
time = Literal('Real time :') + integer.setResultsName("time")
gpro_time = Optional(Literal('(') + integer + Literal('ms)')) + (Literal('no') | Literal('yes'))
parser = start + solutions + time + gpro_time

for t, s, e in parser.scanString(data):
    print "{name} found {solutions} solutions in {time} ms for N={n} and repeating for {repetitions} times".format(**t)