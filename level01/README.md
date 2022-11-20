# LEVEL 01

## 💡 Explanation

In this level we have to:
1. Copy the file `/etc/passwd` from the VM to our computer (because we see that for user level01, the password is not written as ```x``` (encrypted) like the others)
2. Use john the reaper to decrypt this 'non-crypted' password

## 👾 Commands

On our machine:
```
sudo apt install john
scp -o IdentitiesOnly=yes -P 4242 level01@192.168.1.50:/etc/passwd /tmp/snow/
cd .tmp/snow
john passwd
john passwd --show
flag01:abcdefg:3001:3001::/home/flag/flag01:/bin/bash
```

Here we have decrypted the password, that we can copy paste into our VM to get to the next level :)

## 🔍 Resources

- [understanding /etc/passwd format](https://www.cyberciti.biz/faq/understanding-etcpasswd-file-format/)
- [John - Simple user guide](https://linuxcommandlibrary.com/man/john)

## 🔥 Password
`abcdefg`
