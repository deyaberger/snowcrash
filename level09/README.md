# LEVEL 09

- On commence par regarder ce qu'il y a avec un `ls -l`
result:
total 12
```
-rwsr-sr-x 1 flag09 level09 7640 Mar  5  2016 level09
----r--r-- 1 flag09 level09   26 Mar  5  2016 token
```

- on tente `ltrace ./level09`
result:
```
__libc_start_main(0x80487ce, 1, 0xbffff6e4, 0x8048aa0, 0x8048b10 <unfinished ...>
ptrace(0, 0, 1, 0, 0xb7e2fe38)                            = -1
puts("You should not reverse this"You should not reverse this
)                       = 28
+++ exited (status 1) +++
```
Hummm petit indice ici concernant quelque chose qui va/doit/ne doit pas/ etre reverse engineer....

ltrace utilise [ptrace](https://man7.org/linux/man-pages/man2/ptrace.2.html) - dans linux il ne peut y avoir qu'un seul programme qui en suit un autre - donc si on `trace` un programme qui `s'auto trace` deja, le programme va crasher, d'ou se message d'erreur. C'est une forme de protection pour eviter qu'on aille fouiller a l'interieur du programme.


- On essaye de comprendre au pif ce que fait `./level09` :
```
You need to provied only one arg.
```

- `./level09 aaaaaaaaa` :
```
abcdefghi
```
 - `./level09 0000000000000000000000000000000000`
```
0123456789:;<=>?@ABCDEFGHIJKLMNOPQ
```

Ok on commence a capter qu'il y a un pattern de decalage ASCII (chaque charactere de la string se voit rajouter son indice dans la string pour se deplacer dans la table ascii)

- `cat token`
```
f4kmm6p|=�p�n��DB�Du{��
```
token semble avoir été généré par level09, si on reverse son encodage, on peut trouver le token

- `hexdump -C token`
00000000  66 34 6b 6d 6d 36 70 7c  3d 82 7f 70 82 6e 83 82  |f4kmm6p|=..p.n..|
00000010  44 42 83 44 75 7b 7f 8c  89 0a                    |DB.Du{....|
0000001a

```bash
scp -o IdentitiesOnly=yes -P 4242 level09@192.168.1.50:/etc/token /tmp/snow/
chmod 777 /tmp/snow/token
xxd -p /tmp/snow/token | sed 's/../& /g' > /tmp/snow/hex_token
```

On creer un petit programme python sur notre machine qui va pouvoir nous donner le token original:

```python
my_str = "66 34 6b 6d 6d 36 70 7c 3d 82 7f 70 82 6e 83 82 44 42 83 44 75 7b 7f 8c 89".split(" ")

for i, c in enumerate(my_str):
    print(chr(int(c, 16) - i), end="")
```

Resultat:
`f3iji1ju5yuevaus41q1afiuq`

```
su flag09
Password:
Don't forget to launch getflag !
flag09@SnowCrash:~$ getflag
Check flag.Here is your token : s5cAJpM8ev6XHw998pRWG728z
```

## 🔥 Password
`f3iji1ju5yuevaus41q1afiuq`

## ⚡ Flag
`s5cAJpM8ev6XHw998pRWG728z`
