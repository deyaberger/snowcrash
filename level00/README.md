# LEVEL 00

## 💡 Explanation

In this level we have to:
1. Find the files from the user 'flag00' for which we have the right to see the content (do a ```cat```)
2. Decode the content of the files using caesar encoding (We use the best option given by the decoding programm - offset of 11)

## 👾 Commands

```bash
level00@SnowCrash:~$ find / -name * -user flag00 2> /dev/null
/usr/sbin/john
/rofs/usr/sbin/john
level00@SnowCrash:~$ cat /rofs/usr/sbin/john
cdiiddwpgswtgt
```
Here we see that the two files contain the same thing, which is a Cesar encoded password.
We use a website to decode this token:</br></br>
```cdiiddwpgswtgt``` Becomes ```nottoohardhere```
So all is left is to give this decrypted password when connecting to flag00,
then use the command ```getflag``` to get the token to switch to level01

## 🔍 Resources

- [Dcode Caesar](https://www.dcode.fr/chiffre-cesar)

## 🔥 Password
`nottoohardhere`
