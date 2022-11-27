# LEVEL 14

- Let's beggin with the usual:
```
level14@SnowCrash:~$ ls -l
total 0
```
- Ici ya plus rien, donc on va aller checker direct le binaire `getflag` et appliquer ce qu'on a decouvert dans les exos precedents
- On va essayer de changer la valeur des variables que va printer getflag

- `objdump -d /bin/getfalg/`
```
08048946 <main>:
 8048946:	55                   	push   %ebp
 8048947:	89 e5                	mov    %esp,%ebp
 8048949:	53                   	push   %ebx
 804894a:	83 e4 f0             	and    $0xfffffff0,%esp
                    .......
 804897a:	c7 44 24 04 00 00 00 	movl   $0x0,0x4(%esp)
 8048981:	00
 8048982:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
 8048989:	e8 b2 fb ff ff       	call   8048540 <ptrace@plt>      <------ Interesting
 804898e:	85 c0                	test   %eax,%eax
 8048990:	79 16                	jns    80489a8 <main+0x62>
 8048992:	c7 04 24 a8 8f 04 08 	movl   $0x8048fa8,(%esp)
 8048999:	e8 42 fb ff ff       	call   80484e0 <puts@plt>
 804899e:	b8 01 00 00 00       	mov    $0x1,%eax
                    .......
 8048af5:	89 04 24             	mov    %eax,(%esp)
 8048af8:	e8 c3 f9 ff ff       	call   80484c0 <fwrite@plt>
 8048afd:	e8 ae f9 ff ff       	call   80484b0 <getuid@plt>      <------ Interesting
 8048b02:	89 44 24 18          	mov    %eax,0x18(%esp)
 8048b06:	8b 44 24 18          	mov    0x18(%esp),%eax
 8048b0a:	3d be 0b 00 00       	cmp    $0xbbe,%eax
```

On va utiliser gdp pour faire les choses suivantes:
1. breakpoint at ptrace to break trace detection
2. set the return eax to 0 (no error)
3. breakpoint at getuid
4. set return to 3014 (flag14 uid)
5. continue to finish

On lancera donc les commandes ainsi:
```gdb
gdb /bin/getflag
b *0x804898e
r
print $eax=0
b *0x8048b02
c
print $eax=3014
c
```

## 🔥 Password
`7QiHafiNa3HVozsaXkawuYrTstxbpABHD8CPnHJ`
