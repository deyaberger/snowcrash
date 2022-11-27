# LEVEL 02

1. En faisant un simple: `ls -l` on trouve:
```
----r--r-- 1 flag02 level02 8302 Aug 30  2015 level02.pcap
```
2. On copie colle ce fichier dans notre ordi pour voir ce qu'il y a dedans:
```
scp -o IdentitiesOnly=yes -P 4242 level02@192.168.1.50:level02.pcap /tmp/snow/
chmod 777 level02.pcap
```
3. On voit que [pcap](https://fr.wikipedia.org/wiki/Pcap) est une interface de prog qui permet de capturer un trafic reseau
4. On installe Wireshark pour voir ce qu'il passe dans ce trafic reseau: [Download Wireshark](https://www.wireshark.org/download.html)
5. On y ajoute le fichier `pcap`: \
Dans Transmission Control Protocol on voit la mention `Flags` \
clique droit dessus + `follow` + `stream` \
puis `Show data as Hex Dump` \
```
    000000D6  00 0d 0a 50 61 73 73 77  6f 72 64 3a 20            ...Passw ord:
000000B9  66                                                 f
000000BA  74                                                 t
000000BB  5f                                                 _
000000BC  77                                                 w
000000BD  61                                                 a
000000BE  6e                                                 n
000000BF  64                                                 d
000000C0  72                                                 r
000000C1  7f                                                 .
000000C2  7f                                                 .
000000C3  7f                                                 .
000000C4  4e                                                 N
000000C5  44                                                 D
000000C6  52                                                 R
000000C7  65                                                 e
000000C8  6c                                                 l
000000C9  7f                                                 .
000000CA  4c                                                 L
000000CB  30                                                 0
000000CC  4c                                                 L
000000CD  0d                                                 .
```
Les points correspondent a des `delete` en ascii, on decode donc le password : \

`ft_wandrNDRelL0L` => `ft_waNDReL0L`

## 🔥 Password
`ft_waNDReL0L`


## ⚡ Flag
`kooda2puivaav1idi4f57q8iq`