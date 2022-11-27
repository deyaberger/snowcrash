# LEVEL 14

scp -r -o IdentitiesOnly=yes -P 4242 ~/peda level14@192.168.1.50:/var/crash/

```
gdb /bin/getflag
#breakpoint at ptrace to break trace detection
set the return eax to 0 (no error)
breakpoint at getuid
set return to 3014 (flag14 uid)
continue to finish
flex
```
7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ

## 💡 Explanation

In this level we have to DO SOMETHING VERY FUNNY 2.0 🎉🎉
1. In this level there's nothing... So it is time to exploit the binary `getflag`
2. What we are going to do is to use the program gdb to modify the program during its execution LOL; not really the program but the value of its variables, so we can do whatever we want.
3. The problem we find here is the function `ptrace` which is used to block the use of gdb => What we should do is to execute it until that exact point, and then modify the value that the function outputs.
4. Then, we are going to do exactly the same but with the funciton `getuid`, used to verify if we are the right user to give the flag to.

## 👾 Commands

- `cat /etc/passwd` => To check the uid of flag14
- `cp /bin/getflag /tmp/getflag` => For security reasons :)
- `cd /tmp`
- `gdb ./getflag`
- [gdb] `b ptrace` => Set a breaking point on the function ptrace
- [gdb] `run` => Executes the program until the function ptrace
- [gdb] `step 1` => Goes one step further: the exis of the function ptrace
- [gdb] `info registers`
- [gdb] `set ($eax) = 0` => We set the return of the function to 0 (success)
- [gdb] `info registers`
- [gdb] `b getuid` => We set another breaking point at the fuction getuid
- [gdb] `continue` => Executes until reach it
- [gdb] `step 1` => Goes one step further: the exis of the function getuid
- [gdb] `info registers`
- [gdb] `set ($eax) = 3014` => We modify the return value of the function to fake that we are flag14
- [gdb] `info registers`
- [gdb] `continue`

## 🔍 Resources

- [Linux ptrace command](https://man7.org/linux/man-pages/man2/ptrace.2.html)
- [Easy bypass for ptrace(PTRACE_TRACEME, 0, 0) in GDB)](https://gist.github.com/poxyran/71a993d292eee10e95b4ff87066ea8f2)
- [GDB - Step by Step Introduction](https://www.geeksforgeeks.org/gdb-step-by-step-introduction/)
- [GDB - QuickStart](http://web.eecs.umich.edu/~sugih/pointers/gdbQS.html#:~:text=You%20can%20also%20set%20breakpoints,quit%20gdb%20and%20restart%20it.)
- [GDB - Continuing and Stepping](http://sourceware.org/gdb/download/onlinedocs/gdb/Continuing-and-Stepping.html)
- [GDB - How to print register values?](https://stackoverflow.com/questions/5429137/how-to-print-register-values-in-gdb)

## 🔥 Password
`7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ`
