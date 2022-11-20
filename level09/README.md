# LEVEL 09

## 💡 Explanation

In this level we have to:
1. Check the permissions of ./level09 and token
2. Check the content of ./level09 => We see that one of the strings says "You should not reverse this" LOL
3. Run `level09` with several different inputs, we soon realize that there's a clear pattern!
4. Then we check the file `token`, we can think that this token has been created by using the level09 binary
5. We should create a program that decrypts the exact content of the token file.
6. Same as before `su flag09` and `getflag`. Voilà!

## 👾 Commands

```
./level09
ltrace ./level09
./level09 token
scp -P 4242 level09@192.168.56.3:/home/user/level09/token .
gcc decrypt.c -o decryptor && ./decryptor "$(cat token)"
```

## 🔍 Resources

- [Imagination](https://c.tenor.com/BfGFYekoftQAAAAC/spongebob-squarepants-spongebob.gif)

## 🔥 Password
`f3iji1ju5yuevaus41q1afiuq`
