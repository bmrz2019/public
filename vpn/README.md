# How to setup UFW for VPN
Just get these rules

```
user@localhost:~$ sudo ufw status numbered
Status: active

     To                         Action      From
     --                         ------      ----
[ 1] 2022                       ALLOW IN    10.147.20.0/24            
[ 2] 2022                       ALLOW IN    10.147.17.0/24            
[ 3] 2022                       ALLOW IN    a.b.c.d/27           
[ 4] 9993/udp                   ALLOW IN    Anywhere                  
[ 5] 9993/udp (v6)              ALLOW IN    Anywhere (v6)             

```


