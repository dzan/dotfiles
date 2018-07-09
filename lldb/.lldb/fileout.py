import lldb
import sys

def toFile(debugger, command, result, dict):
    f=open("/Users/dzan/lldb.tmp.txt","w")
    debugger.SetOutputFileHandle(f,True);
    debugger.HandleCommand(command)  
    f.close()
    debugger.SetOutputFileHandle(sys.stdout, True)

def __lldb_init_module (debugger, dict):
    debugger.HandleCommand('command script add -f fileout.toFile tf ')
