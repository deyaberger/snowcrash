# LEVEL 13

- On check ce qu'on a ici avec les commandes suivantes:
```
level13@SnowCrash:~$ ls -l
total 8
-rwsr-sr-x 1 flag13 level13 7303 Aug 30  2015 level13
```
- Quand on lance le programme en question on a :
```
level13@SnowCrash:~$ ./level13
UID 2013 started us but we we expect 4242
```
- UID nous rappelle quelque chose, ca a un rapport avec le fichier `/etc/passwd` qui contient les UID de chaque user:
```
level13@SnowCrash:~$ cat /etc/passwd | grep -E "level13|flag13|4242"
level13:x:2013:2013::/home/user/level13:/bin/bash
flag13:x:3013:3013::/home/flag/flag13:/bin/bash
```
`2013` correspond a l'UID de notre user, mais on ne sait pas a quoi correspond `4242`

- On lance plusieurs commande pour voir ce qu'il se passe
```
strings level13
ltrace ./level13
strace ./level13
hexdump -C level13
objdump -d level13
nm level13
```

Usefull: [peda library](https://github.com/longld/peda)

Quand on lance le debugger on a:
- `objdump -D level13`

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
- On voit qu'il y a des appels aux [UID d'un fichier](https://linuxhandbook.com/uid-linux/#:~:text=UID%20stands%20for%20user%20identifier,resources%20the%20user%20can%20access.) et qu'il vont comparer un UID precis (variable `$0x1092`, qui doit correspondre au fameux `4242`) au retour de la fonction getuid (%eax)
- A cet endroit la on veut faire croire que le retour de getuid est le meme que la variable de comparaison pour pouvoir passer le chekckpoint

- `gdb level13` \
Les commandes a executer dans gdp seront les suivantes:
```
b *0x0804859a
r
print $eax=4242
s
```
Ca donne ca:
```
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

cf: [gdb tutorial](https://www.tutorialspoint.com/gnu_debugger/gdb_commands.htm)
## ⚡ Flag
`2A31L79asukciNyi8uppkEuSx`
