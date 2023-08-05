# Sample to write to STDOUT and STDERROR
# Both streams seem to write to STDOUT
import sys

sys.stdout.write( "Hello Standard Output!\n" )
sys.stderr.write( "Hello Standard Error!\n" )
