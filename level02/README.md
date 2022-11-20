# LEVEL 02

## 💡 Explanation

In this level we have to:
1. Copy the file `level02.pcap` from the VM to our computer
2. Log in into wireshark and upload the file
3. Select the last packet and use the tool "Follow Stream", display the results as HEX
4. Decode the password

## 👾 Commands
```
scp -o IdentitiesOnly=yes -P 4242 level02@192.168.1.50:level02.pcap /tmp/snow/
chmod 777 level02.pcap
```

## 🔍 Resources

- [Download Wireshark](https://www.wireshark.org/download.html)

## 🔥 Password
`ft_wandrNDRelL0L` => `ft_waNDReL0L`
