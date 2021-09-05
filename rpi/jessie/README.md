# journal

```
apt-get purge inputlirc
service lirc stop
service lirc start
```


# journal

```
sudo journalctl _COMM=sshd --since=today

sudo journalctl -n 10

sudo journalctl -f

sudo  journalctl /dev/sda
```

# autofs

```sudo apt-get install nfs-common nfs-server```

Edit ```/etc/exports```

```
sudo service nfs-kernel-server status
sudo exportfs -ra
sudo showmount -e 192.168.1.10
```


## config and tips for raspi

For ffmpeg see this https://squarepenguin.co.uk/forums/thread-964.html
wget https://github.com/ccrisan/motioneye/wiki/precompiled/ffmpeg_3.1.1-1_armhf.deb
sudo dpkg -i ffmpeg_3.1.1-1_armhf.deb

# Convert all addon stuff to https

```
grep -r --color=ALWAYS "http:" * | more
find . -iname "*.xml" -print0 | xargs -0 -I % perl -pi -e 's/http\:/https\:/g'  %
find . -iname "*py"   -print0 | xargs -0 -I % perl -pi -e 's/http\:/https\:/g'  %
```

# how to email setup
```apt-get purge bsd-mailx
apt-get install heirloom-mailx
```
see ```/root/.mailrc```
## Test email 
echo This is a test | mail -v -s "A mail from your pi" destination@example.com
