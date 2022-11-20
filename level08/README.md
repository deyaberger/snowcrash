# LEVEL 08

## 💡 Explanation

In this level we have to:
1. Check the file ./level08 and token permissions
2. Try to execute the `./level08` with different files => It gives different errors depending on the file regardless of the permissions!
4. We check what `ltrace ./level08 token`ouputs => Literally `strstr("token", "token")`... hahaha
5. We can create a symbolic link to the file token with another name so it won't detect it! Voilà
6. Last but not least, this level works as the ones at the beginning, we have to `su flag08` and `getflag`.

## 👾 Commands

```
./level08
./level08 token
./level08 .profile
ltrace ./level08 token
ln -s /home/user/level08/token /tmp/tkn
./level08 /tmp/tkn
```

## 🔍 Resources

- [Linux ltrace command](https://man7.org/linux/man-pages/man1/ltrace.1.html)
- [Ln Command in Linux (Create Symbolic Links)](https://linuxize.com/post/how-to-create-symbolic-links-in-linux-using-the-ln-command/)

## 🔥 Password
`quif5eloekouj29ke0vouxean`
