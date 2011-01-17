PYPL: A simple prolog trace to graph utility
============================================

This script is able to interpret the output of prolog's tracing capabilities
and to reconstruct the execution tree based only on its contents.

The reconstructed tree is then rendered as an image thanks to the graphviz
bindings.


Dependencies
------------

The script depends on python (tested on 2.6, but maybe 2.5 works too) and the
following packages:

 * ``Twisted`` Networking and subprocessing (this is a really really stupid
   dependency and the code should be rewritten to use the stdlib subprocess
   module).
 * ``yapgvb`` Graphviz bindings
 * ``pyparsing`` Parsers generation support


Files
-----

 * ``runner.py`` Main program
 * ``parser.py`` Basic parser for prolog's trace output
 * ``source.pl`` The source of the tree to analyze


Executing
---------

Simply run the following command from the command line::

    python runner.py


Known bugs and limitations
--------------------------

 * Sometimes the process protocol waits for output from the prolog interpreter
   which it never recevies (^C to exit cleanly);
 * At the moment is is only possible to navigate a single branch of the tree;
 * The twisted dependency shall be removed;
 * Add some command line parameters (prolog sources, image format,...)

