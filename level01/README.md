# LEVEL 01

1. Il n'y a rien dans notre home en faisant `ls -l`
2. On check a nouveau la commande du premier exo, rien non plus
3. On check l'endroit où sont stockées les infos concernant les differents utilisateurs: `cat /etc/passwd`
4. On y voit plus claire en faisant: `cat /etc/passwd | grep "flag01"`
```
flag01:42hDRfypTqqnw:3001:3001::/home/flag/flag01:/bin/bash
```
5. On se renseigne sur ce que veut dire chaque champ de chaque utilisateur: [understanding /etc/passwd format](https://www.cyberciti.biz/faq/understanding-etcpasswd-file-format/)
6. On capte qu'au niveau du password il devrait y avoir un `x` au lieu de `42hDRfypTqqnw`
7. On tente de l'utiliser comme pwd pour flag01, ca ne marche pas...
8. Ca doit être encrypté comme pour l'exo précédent... où le fichier s'appelait john, comme ....[John the reaper - Simple user guide](https://linuxcommandlibrary.com/man/john)
9. On recupere le mdp encrypté sur notre machine et on le donne a johnnyyy
```bash
sudo apt install john
scp -o IdentitiesOnly=yes -P 4242 level01@192.168.1.50:/etc/passwd /tmp/snow/
john /tmp/snow/passwd
john /tmp/snow/passwd --show
```
On a ce resultat:
```
flag01:abcdefg:3001:3001::/home/flag/flag01:/bin/bash
```
## 🔥 Password
`abcdefg`


## ⚡ Flag
`f2av5il02puano7naaf6adaaf`
