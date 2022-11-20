# LEVEL 13

## 💡 Explanation

In this level we have to DO SOMETHING VERY FUNNY 🎉🎉
1. We don't really care for the permissions of the file LOL
2. We have to understand what the binary is doing and how to exploit it => To do so, we should use a bunch of commands and read some documentation about assembler
3. Once we've found out that what it is doing is retrieving the UID and comparing it to 4242, we can change the binary to compare it to our UID (`id`) so it'll print the token (eventually)
4. To do so, we have to first copy the file to /tmp; as before, I've `scp` to my CP to be able to test it easier
5. Change the permissions to the file; then, open vim, set the mode to be able to see the binary better, find the command that we want to change, change it, go back to binary, save and have fun!

## 👾 Commands

To find the solution:
```
./level13
strings level13
ltrace ./level13
strace ./level13
hexdump -C level13
objdump -d level13
nm level13
```

To modify the file and execute it:
- `cp level13 /tmp/level13_test`
- `cd /tmp`
- `chmod +w level13_test`
- `vim level13_test`
- [vim] `:%!xxd`
- [vim] `/3d`   => Press 'n' until we find "3d 92 10 00 00" == "cmpl	$4242, %eax"
- [vim] `i`     => Change it for "3d dd 07 00 00" == "cmpl	$2013, %eax"
- [vim] `:%!xxd -r`
- [vim] `:wq`
- `./level13_test`

## 🔍 Resources

- [Linux - how to analyze binary files](https://opensource.com/article/20/4/linux-binary-analysis)
- [Linux Objdump Command](https://www.thegeekstuff.com/2012/09/objdump-examples/)
- [UID](https://mtxserv.com/fr/serveur-vps/doc/comment-trouver-l-uid-ou-le-gid-d-un-utilisateur-linux)
- [Assembly Programming Tutorial](https://www.tutorialspoint.com/assembly_programming/index.htm)
- [Online Disassembler](https://defuse.ca/online-x86-assembler.htm#disassembly2)
- [HEX <--> DEC](https://www.rapidtables.com/convert/number/decimal-to-hex.html)
- [How to edit binary files with Vim? I](https://vi.stackexchange.com/questions/343/how-to-edit-binary-files-with-vim)
- [How to edit binary files with Vim? II](https://transang.me/edit-binary-file-with-vim-and-the-xxd-command/)
- [How to search in Vim?](https://linuxize.com/post/vim-search/)

## 🔥 Password
`2A31L79asukciNyi8uppkEuSx`
