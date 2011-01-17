import subprocess
import signal
import os

from parser import TraceParser

from twisted.internet import reactor, protocol, defer

class PrologProtocol(protocol.ProcessProtocol):
    
    def __init__(self, command):
        self.command = command
        self._prompt = None
        self.process = False
        self.out = ""
    
    def getprompt(self):
        if not self._prompt:
            def clear(val):
                self._prompt = None
                return None
            
            self._prompt = defer.Deferred()
            self._prompt.addCallback(clear)
        
        return self._prompt
    
    def isprompt(self, text):
        return text.strip().endswith('| ?-')
    
    def connectionMade(self):
        print "Process started"
        
        reactor.callLater(0, self.run)
    
    @defer.inlineCallbacks
    def run(self):
        print "Waiting for prompt"
        yield self.getprompt()
        
        print "Including external source"
        self.transport.write('[source].\n')
        yield self.getprompt()
        
        print "Activating tracing"
        self.transport.write('trace.\n')
        yield self.getprompt()
        
        print "Sending command"
        self.process = True
        self.transport.write(self.command + '\n')
        yield self.getprompt()
        print "Finished"
        
        self.transport.signalProcess('KILL')
    
    def processEnded(self, status):
        reactor.stop()
    
    def errReceived(self, err):
        print "[ERR]", err
    
    def gettrace(self):
        return [l.strip() for l in protocol.out.split('\r\n')]
    
    def outReceived(self, out):
        if self.isprompt(out) and self._prompt:
            if self.out:
                self.out += out
            self._prompt.callback(None)
        elif self.process:
            if out:
                self.out += out
                
                if out.strip().endswith('true ?'):
                    self.transport.write(';')
                
                if out.strip():
                    self.transport.write("\n")

protocol = PrologProtocol('a, e.')

reactor.spawnProcess(protocol, '/usr/local/bin/gprolog', env=os.environ, path=os.path.dirname(__file__), args=['/usr/local/bin/gprolog', ], usePTY=True)
reactor.run()

parser = TraceParser([p.strip() for p in protocol.gettrace() if p.strip()])
parser.parse()



