#!/usr/bin/env lua

print("Introduce command:")
local pass = io.read()
print("\n==> INPUT: "..pass)
print("==> COMMAND: ".."echo "..pass.." | sha1sum")
prog = io.popen("echo "..pass.." | sha1sum", "r")
print("\n==> PROG: ")
print(prog)
data = prog:read("*all")
print("\n==> DATA: ")
print(data)
