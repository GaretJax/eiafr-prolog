
import string
import itertools
import yapgvb as graphviz

from pyparsing import Literal, Word, alphas, Suppress, Optional, \
                      delimitedList, nums, ParseException


class Atom(str):
    def __init__(self, val, offset=0):
        self.val = val
        self.offset = offset
        self.body = []
        if val is True:
            self.body.append(True)
    
    def complete(self):
        if not self.body:
            self.body = True
    
    def getBody(self):
        return self.body[self.offset:]
    
    def __repr__(self):
        return "%s:%d:[%s]" % (self.val, self.offset, ",".join(map(str, self.getBody())))
    
    def __str__(self):
        return str(self.val)

class Unknown(str):
    def __repr__(self):
        return "Unknown(%s)" % super(Unknown, self).__str__()

def wrap(klass):
    def inner(s, loc, tokens):
        return [klass(t) for t in tokens]
    
    return inner

class Node(object):
    def __init__(self, atoms=[], edge=''):
        self.children = []
        self.parent = None
        self.atoms = atoms
        self.depth = 1
        self.edge = edge
    
    def graph(self, graph, parent=None):
        s = ', '.join(list(itertools.chain(*[map(str, a.getBody()) for a in self.atoms])))
        #s = str(self.atoms)
        node = graph.add_node(label=s)
        
        if parent:
            edge = graph.add_edge(parent, node)
            edge.label = self.edge
            edge.decorate = True
        
        for c in self.children:
            c.graph(graph, node)
        
        return graph
    
    def add_to(self, parent):
        self.parent = parent
        parent.children.append(self)
        self.depth = parent.depth + 1
        
        return self
    
    def rewind(self, depth=1):
        assert 0 < depth <= self.depth, "Cannot go from %d to %d" % (self.depth, depth)
        
        if self.depth is depth:
            return self
        else:
            return self.parent.rewind(depth)

class TraceParser(object):
    def __init__(self, trace):
        self.trace = trace
    
    def command(self):
        atom = Word(string.lowercase, alphas).setParseAction(wrap(Atom))
        unknown = Word(string.uppercase, alphas).setParseAction(wrap(Unknown))
        
        p = delimitedList(atom | unknown) + Suppress('.')
        
        return p.parseString(self.trace[0])
        
    def tick(self, tick):
        integer = Word(nums).setParseAction(lambda toks: int(toks[0]))
        
        action = (Literal('Call') | Literal('Redo') | Literal('Exit')).setParseAction(lambda toks: toks[0].lower()) + Suppress(':')
        atom = Word(string.lowercase, alphas).setParseAction(wrap(Atom))
        unknown = Word(string.uppercase, alphas).setParseAction(wrap(Unknown))
        event = integer + integer + action + (atom | unknown) + Suppress('?')
        solution = (Literal('true') + Suppress('?') + Optional(Suppress(';'))) | Literal('yes').setParseAction(lambda s,l,t:['true'])
        
        p = event | solution
        
        return p.parseString(tick)
    
    def parse(self, start=0):
        current = root = Node([Atom('#'), ])
        
        from copy import copy
        
        for t in self.trace[start+1:]:
            try:
                event = self.tick(t)
            except ParseException:
                continue
            
            if event[0] == 'true':
                current.atoms = [Atom(True)]
            elif event[2] == 'call':
                atoms = list(current.rewind(event[0]).atoms)
                atoms[0] = copy(atoms[0])
                atoms[0].body.append(event[3])
                atoms[0].offset += 1
                atoms.insert(0, event[3])
                current = Node(atoms, edge=t).add_to(current)
            elif event[2] == 'exit':
                event[3].body = True
                current.atoms.pop(0)
            elif event[2] == 'redo':
                break #current = current.rewind(event[0])
        
        self.tree2graph(root)
        
    def tree2graph(self, root):
        graph = graphviz.Digraph()
        
        root.graph(graph)
        
        graph.layout(graphviz.engines.dot)
        graph.render('graph.png')
