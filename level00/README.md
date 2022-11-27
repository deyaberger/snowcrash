# LEVEL 00

1. on veut choper le mdp du user flag00 afin de s'y connecter et pouvoir y lancer la cmd getflag
2. on Fait un `ls -l`: \
il n'y a rien
3. On essaye de trouver des fichiers qui appartiennent au user flag00: \
`find / -name * -user flag00 2> /dev/null` \
```
/usr/sbin/john
/rofs/usr/sbin/john
```
4. I y a la meme chose dans les deux fichiers: `cat /usr/sbin/john`:
```
cdiiddwpgswtgt
```
Bad News, ce n'est pas le mdp du user flag00.... il est peut etre encodé (petit indice grâce au nom du fichier)
5. On utilise la methode cesar pour le decoder (simple copier coller entre VM et machine perso): [site web decodecesar](https://www.dcode.fr/chiffre-cesar) On choisit le mdp le plus probable qui est:
`
nottoohardhere
`
```bash
level00@SnowCrash:~$ su flag00
Password:
Dont forget to launch getflag !
flag00@SnowCrash:~$ getflag
Check flag.Here is your token : x24ti5gi3x0ol2eh4esiuxias
```

## 🔥 Password
`nottoohardhere`


## ⚡ Flag
`x24ti5gi3x0ol2eh4esiuxias`
