# Recent


### Openbox config for volume

- Edit file `.config/openbox/lxde-rc.xml`

```
    <!-- Keybinding for Volume management -->
    <keybind key="XF86AudioRaiseVolume">
      <action name="Execute">
        <command>pactl set-sink-volume @DEFAULT_SINK@ +10%</command>
      </action>
    </keybind>
    <keybind key="XF86AudioLowerVolume">
      <action name="Execute">
        <command>pactl set-sink-volume @DEFAULT_SINK@ -10%</command>
      </action>
    </keybind>
    <keybind key="XF86AudioMute">
      <action name="Execute">
        <command>pactl set-sink-mute @DEFAULT_SINK@ toggle</command>
      </action>
    </keybind>
```


### eduVPN

- What is my ip https://ipinfo.io/what-is-my-ip

```
eduvpn-cli connect -c https://eduvpn1.eduvpn.de
eduvpn-cli connect -c https://eduvpn.uni-heidelberg.de
eduvpn-cli list
eduvpn-cli status
eduvpn-cli disconnect
```

### pulse audio

```
pacmd list-sinks | grep -e name: -e index -e description
  * index: 30
	name: <bluez_sink.A1_B2_C3_D4_E5_F6.a2dp_sink>
		device.description = "Grundig BAND"
    index: 31
	name: <alsa_output.pci-0000_07_00.6.HiFi__Speaker__sink>
		device.profile.description = "Speaker"
		device.description = "Ryzen HD Audio Controller Speaker"
user@acer: ~/bin $ pactl set-default-sink 31
user@acer: ~/bin $ pactl set-default-sink 30
```

For auto-switch add to `/etc/pulse/default.pa` this line
`load-module module-switch-on-connect`

Use this commandline for

```
pactl list cards
pactl set-card-profile  bluez_card.A1_B2_C3_D4_E5_F6  off
pactl set-card-profile  bluez_card.A1_B2_C3_D4_E5_F6 a2dp_sink
```

### Android list media files

```
adb shell 'find /storage/emulated/0 \
  \( -iname Android -o -iname DCIM -o -iname Pictures \) -prune -o \
  -type f \
  \( -iname "*.mkv" -o -iname "*.mp4" -o -iname "*.webm" \) \
  ! -iname "VID*.mp4"'
```

### Allow username to mount filesystems in debian

`/etc/polkit-1/rules.d/10-allow-mount.rules`

```
polkit.addRule(function(action, subject) {
    if ((action.id == "org.freedesktop.udisks2.filesystem-mount" ||
        action.id == "org.freedesktop.udisks2.filesystem-mount-system")&&
        subject.local && subject.active && subject.user == "username")
    {
            return polkit.Result.YES;
    }
});
```

# Ignore mount partitions

Edit file 

`/etc/udev/rules.d/98-mmc-A29128.rules`

```
KERNEL=="mmcblk0p1", ENV{UDISKS_IGNORE}="1"
KERNEL=="mmcblk0p2", ENV{UDISKS_IGNORE}="1"
KERNEL=="mmcblk0p3", ENV{UDISKS_IGNORE}="1"
KERNEL=="mmcblk0p4", ENV{UDISKS_IGNORE}="1"
KERNEL=="mmcblk0p5", ENV{UDISKS_IGNORE}="1"
KERNEL=="mmcblk0p6", ENV{UDISKS_IGNORE}="1"
KERNEL=="mmcblk0p7", ENV{UDISKS_IGNORE}="1"
KERNEL=="mmcblk0p8", ENV{UDISKS_IGNORE}="1"
KERNEL=="mmcblk0p9", ENV{UDISKS_IGNORE}="1"
KERNEL=="mmcblk0p10", ENV{UDISKS_IGNORE}="1"
KERNEL=="mmcblk0p11", ENV{UDISKS_IGNORE}="1"
KERNEL=="mmcblk0p12", ENV{UDISKS_IGNORE}="1"

```

### Change the cache dir
```
$ cat /etc/profile.d/xdg-cache.sh 
# shellcheck shell=sh
export XDG_CACHE_HOME="/tmp/.cache"
```

### Encryption
- Edit `/etc/crypttab` file
- `home UUID=SOMETHING none  luks,discard,no-read-workqueue,no-write-workqueue`
- `xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/logind-handle-lid-switch -s true`

### Users
- Login as a different user

- `sudo -i -u username`

### Fast copy

- `tar cf - . | ( cd  /destination/path ; tar xvf -)`

### PDF to poster

- `pdfposter  -pa2  -ma4  input.pdf output.pdf`

### Keep both video and opus file

- `yt-dlp -f 'bv+ba,ba' --merge mkv --remux 'webm>opus'`

### Seagate external tips

```
lsusb | grep -i seagate
Bus 004 Device 012: ID 0bc2:2037 Seagate
```

`echo "0x0bc2:0x2344:u" | sudo tee /sys/module/usb_storage/parameters/quirks`


### disable pulseaudio HDMI 

- Edit `/etc/pulse/default.pa`

and comment the line.

```
#load-module module-switch-on-port-available
```

### Docker

```
systemctl status gitlab-runner.service
systemctl restart gitlab-runner
docker images | grep '3 weeks ago' | awk '{print $1 ":" $2}' | xargs -n 1 docker rmi
journalctl -u gitlab-runner.service -f
```


```
#!/bin/bash

PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin

LOCK="/tmp/disk_usage_docker_cleanup.lock"
if [ -f $LOCK ] ; then
 echo "Lockfile exists, aborting."
 exit 0
fi
touch $LOCK
  
#use $HOSTNAME

echo "------------------------------------------" >> /root/README.df
echo -n "Disk usage on " >> /root/README.df
date +%F >> /root/README.df

df -h  / | grep / >> /root/README.df

echo " " >> /root/README.df
echo " " >> /root/README.df
echo "Information from clear-docker-cache space " >> /root/README.df
/usr/share/gitlab-runner/clear-docker-cache space >> /root/README.df

echo "------------------------------------------" >> /root/README.df
echo " " >> /root/README.df
echo " " >> /root/README.df

#next line determines current % use
CURRENT=$(df / | grep / | awk '{ print $5}' | sed 's/%//g')
if [[ $CURRENT -gt 50 ]]; then
 FREE=$(df -h / | grep / | awk '{ print $4}')
 #echo "Low disk space home in $HOSTNAME Only $FREE available."  | mail -s "Warning low disk space in $HOSTNAME" noreply@example.com
 #/usr/share/gitlab-runner/clear-docker-cache space
 docker rmi $(docker images -q --no-trunc) > /dev/null 2>&1
fi
rm -f $LOCK

exit 0
```

### git export tar

```
git archive main | tar -x -C /existing/dir/
```


### RFC 3339 date-time now

`2023-08-10T09:41:36+00:00`

### adb

```
adb shell am broadcast -a android.intent.action.MEDIA_SCANNER_SCAN_FILE -d file:///storage/emulated/0/DCIM/Camera/
adb shell content query --uri "content://media/external/file"
```

# ffmpeg

```
ffmpeg -i input.mp3 -ss 60 output.mp3 # skip 60 seconds at start
ffmpeg -i input.mp3 -to 00:52:00 output.mp3 # Stop writing the output at time
ffmpeg -i input.mp4 -vf scale=1920:-1 -vcodec libx265 -crf 24 output.mp4 # mastodon
```

# Last installed packages

```
grep --color=auto "install" /var/log/dpkg.log | awk '$3~/^install$/ {printf $4" ";}'
```


# Minimal Debian or ubuntu

- Minimal Debian or ubuntu https://wiki.debian.org/ReduceDebian
- To restore ``` apt-get install groff groff-base ```

## Rename

- To rename all files so that they are compatible with FAT32

```
find ./DIRECTORY -maxdepth 1  -exec rename -n 's/[^[:ascii:]]/_/g' {} \;
```


## ChromeOS


### recovery 

- https://chromiumdash.appspot.com/serving-builds?deviceCategory=ChromeOS

- https://cros.tech/

### subtitles player

- https://github.com/guancio/ChromeOsSubtitle

### Change keyboard layout Chromebook

- Put in developer mode by Hold down the Escape and Refresh keys.
- Click the power button. You can release the Escape and Refresh keys at this point.
- Once you see the Recovery screen, hit Ctrl-D.
- Wait a while. The Chromebook will beep at you once or twice.
- Eventually, it’ll boot back up to the normal Chrome OS login screen.
- Hit Ctrl-Alt-F2 (F2 is the right-facing arrow next to the refresh key) to get to a login prompt.

```
login as chronos (no password needed)
sudo -s
vpd -l  # to list current status
vpd -s region=de
```

- it was NOT necessary to remove battery (i.e) modern write protect

### systemd suspend modules

```
#!/bin/bash

# Put into /lib/systemd/system-sleep/suspend-modules
# chmod a+x /lib/systemd/system-sleep/suspend-modules

# Unloads kernel modules defined in /etc/suspend-modules.d/*.conf
# and /etc/suspend-modules
# with one module per line

# Too see credits, see git history
# https://gist.github.com/sigboe/2602f9318b8f55ca92c7755a5b70644d/edit

case $1 in
    pre)
        for mod in $(cat /etc/suspend-modules 2> /dev/null; awk 1 /etc/suspend-modules.d/*.conf 2> /dev/null); do
            rmmod $mod
        done
    ;;
    post)
        for mod in $(cat /etc/suspend-modules 2> /dev/null; awk 1 /etc/suspend-modules.d/*.conf 2> /dev/null); do
            modprobe $mod
        done
    ;;
esac
```

### Android

- OTAs are downloaded is android.googleapis.com  ota.googlezip.net


### Xresources

- lower numbers make fonts small (hard to read)
- For a 14 inch screen 135 is good
- Edit `.Xresources`

```
Xft.dpi: 135
```

| Size | dpi |
|--|--|
| 14 | 135 |
| 17 | 128 |

### List only security updates

```
apt-get --just-print upgrade | grep -i security   | awk '{print $2}'
```

### fsarchiver rsync full system backup

```
#fsarchiver savefs /home/user/FSARCHIVER/10.01.2022-nvme0n1p2-root.fsa /dev/nvme0n1p2 -s 900 --exclude=/snap --exclude="/home/*"  --exclude='/media' --exclude='/var/lib/lxd/*' --exclude='/tmp/*' --exclude='/var/lib/snapd/*' -A -v
#rsync -aAXHv -x  --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found","/snap/*","/home/*"}  /   /media/500GB/SYSTEM_ROOT/
```
### Email encoder

- https://freetools.dev/email-encoder
- https://hoax-info.tubit.tu-berlin.de/software/emailencoder.shtml


### Google cloud

- https://myaccount.google.com/dashboard?continue=https%3A%2F%2Fmyaccount.google.com%2Fdata-and-privacy
- https://www.google.com/setting/search/privateresults
- https://myaccount.google.com/connections/settings?hl=en
- https://console.cloud.google.com/apis/library/photospicker.googleapis.com
- https://console.cloud.google.com/marketplace/product/google/drive.googleapis.com
- https://groups.google.com/a/chromium.org/g/google-browser-signin-testaccounts
- https://groups.google.com/a/chromium.org/g/chromium-dev
- https://console.cloud.google.com/apis/api/chromesync.googleapis.com

### optional

- https://myaccount.google.com/connections/settings
- https://console.cloud.google.com/marketplace/product/google/cloudsearch.googleapis.com
- https://console.cloud.google.com/marketplace/product/google/safebrowsing.googleapis.com
- https://console.cloud.google.com/marketplace/product/google/timezone-backend.googleapis.com
- https://console.cloud.google.com/marketplace/product/google/admin.googleapis.com
- 💱 https://console.cloud.google.com/marketplace/product/google/translate.googleapis.com
- https://console.cloud.google.com/marketplace/product/google/embeddedassistant.googleapis.com
- https://console.cloud.google.com/marketplace/product/google/calendar-json.googleapis.com
- https://console.cloud.google.com/marketplace/product/google/copresence.googleapis.com

### Cloudready

`sudo dd if=cloudready.bin of=/dev/sdX bs=4M `

### Disable auto update of secureboot keys

- check for secureboot

`mokutil --sb-state`

```
systemctl stop secureboot-db.service
systemctl disable secureboot-db.service
journalctl -o short-precise -b -u secureboot-db.service
```

### hibernate

- Allow remote users to reboot
- Create (as root) a file named `/etc/polkit-1/rules.d/10-shutdown-reboot.rules`:

```
polkit.addRule(function(action, subject) {
    if ((action.id == "org.freedesktop.login1.reboot-multiple-sessions" ||
         action.id == "org.freedesktop.login1.reboot" ||
         action.id == "org.freedesktop.login1.suspend-multiple-sessions" ||
         action.id == "org.freedesktop.login1.suspend" ||
         action.id == "org.freedesktop.login1.hibernate-multiple-sessions" ||
         action.id == "org.freedesktop.login1.hibernate" ||
         action.id == "org.freedesktop.login1.power-off-multiple-sessions" ||
         action.id == "org.freedesktop.login1.power-off") &&
        (subject.isInGroup("sudo") || (subject.user == "root")))
    {
        return polkit.Result.YES;
    }
});
```

- Create (as root) a file named `/etc/polkit-1/rules.d/10-enable-hibernate.rules`:

```
polkit.addRule(function(action, subject) {
    if (action.id == "org.freedesktop.login1.hibernate" ||
        action.id == "org.freedesktop.login1.hibernate-multiple-sessions" ||
        action.id == "org.freedesktop.upower.hibernate" ||
        action.id == "org.freedesktop.login1.handle-hibernate-key" ||
        action.id == "org.freedesktop.login1.hibernate-ignore-inhibit")
    {
        return polkit.Result.YES;
    }
});
```
- Test

`user@laptop: ~ $ busctl call org.freedesktop.login1 /org/freedesktop/login1 org.freedesktop.login1.Manager CanHibernate`

the result

`s yes `


### inxi
`inxi -Fxxrzc0`

### RSS podcasts

```
wget   https://example.com/something.rss
xmlstarlet sel -t -v "//media:content/@url"  something.rss| grep mp3  |  sed -e 's/?.*//' > list
wget --random-wait --wait 120 --no-clobber -i list

```

### encfs

```
sudo apt install encfs
encfs ~/.encrypted ~/visible
fusermount -u ~/visible

```

### fat32

```
mkfs.vfat -s 16 -S 4096
```

### Samba

```
apt-get install samba tdb-tools samba-common-bin samba-common python3-samba python3-tdb python3-dnspython
systemctl disable smbd.service nmbd.service
chown nobody:nogroup /path/to/share # or give rx permissions to the directory of share
```

edit ` /etc/samba/smb.conf`

```
[share]
    comment = Ubuntu File Server Share
    path = /path/to/share
    browsable = yes
    guest ok = yes
    read only = yes
    create mask = 0755
```

### Clone your favorite OS
```
sfdisk -d /dev/sda
sfdisk -d /dev/sda > /tmp/backup-partition-file-sda.bak
```
To restore to a new drive
```
sfdisk /dev/sdb < /tmp/backup-partition-file-sda.bak
```
To directly copy to a new disk
```
sfdisk -d /dev/sda | sfdisk /dev/sdb
```
If you need to backup bootsector/MBR. I do not know why and which command works but running these sucessively made it work. This works only if both disks have same size and partitions. (May be they can be smaller?)

```
dd if=/dev/sda of=/dev/sdb bs=512 count=1
dd if=/dev/sda of=/dev/sdb bs=512 count=63
```


### commands

- Android project rename

```
find ./ -type f \( -iname \*.iml -o -iname \*gradle  -o -iname \*.java -o -iname \*xml  \)  -printf '%P\n'  -exec perl -pi -e 's/OLDNAME/NEWNAME/g' '{}' \+


find  .  -type f \( -name '*.img' -o -name '*.mccd' -o -name '*.cbf' \) -print0 | xargs -0 gzip -v --best

function jgrep()
{
    find . -name .repo -prune -o -name .git -prune -o  -type f -name "*\.java" -print0 | xargs -0 grep --color -n "$@"
}

function cgrep()
{
    find . -name .repo -prune -o -name .git -prune -o -type f \( -name '*.c' -o -name '*.cc' -o -name '*.cpp' -o -name '*.h' \) -print0 | xargs -0 grep --color -n "$@"
}

resgrep () 
{ 
    for dir in `find . -type d \( -not -name "values-*" -a -not -name "mipmap*" -a -not -name "drawable-*" -a -not -name "." \)`;
    do
        find $dir -type f -name '*\.xml' -exec grep --color -n "$@" {} +;
    done
}

function mangrep()
{
    find . -name .repo -prune -o -name .git -prune -o -path ./out -prune -o -type f -name 'AndroidManifest.xml' -print0 | xargs -0 grep --color -n "$@"
}

function sgrep()
{
    find . -name .repo -prune -o -name .git -prune -o  -type f -iregex '.*\.\(c\|h\|cpp\|S\|java\|xml\|sh\|mk\)' -print0 | xargs -0 grep --color -n "$@"
}

function mgrep()
{
    find . -name .repo -prune -o -name .git -prune -o -path ./out -prune -o -regextype posix-egrep -iregex '(.*\/Makefile|.*\/Makefile\..*|.*\.make|.*\.mak|.*\.mk)' -type f -print0 | xargs -0 grep --color -n "$@"
}

function treegrep()
{
    find . -name .repo -prune -o -name .git -prune -o -regextype posix-egrep -iregex '.*\.(c|h|cpp|S|java|xml)' -type f -print0 | xargs -0 grep --color -n -i "$@"
}

function findfile()
{
    find . -name .repo -prune -o -name .git -prune -o -path ./out -prune -o -type f -iname "$@"| grep -v ".git" | grep -v ".repo"
}

function finddir()
{
    find . -name .repo -prune -o -name .git -prune -o -path ./out -prune -o -type d -iname "$@"| grep -v ".git" | grep -v ".repo"
}

function renameapp()
{
    find ./ -type f \( -iname \*.iml -o -iname \*gradle  -o -iname \*.java -o -iname \*xml  \)  -printf '%P\n'  -exec perl -pi -e 's/OLDNAME/NEWNAME/g' '{}' \+
}


```


# CPU

```
./kcbench -b -j 4 -s ./ -i 1 | tee acer-silver.log
Processor:           Intel(R) Pentium(R) Silver N6000 @ 1.10GHz [4 CPUs]
Cpufreq; Memory:     powersave [intel_pstate]; 3728 MiB
Linux running:       5.15.0-47-generic [x86_64]
Compiler:            gcc (Ubuntu 11.2.0-19ubuntu1) 11.2.0
Linux compiled:      6.0.9 [/linux-6.0.9/./]
Config; Environment: defconfig; CCACHE_DISABLE="1"
Build command:       make vmlinux
Run 1 (-j 4):        1010.36 seconds / 3.56 kernels/hour [P:391%, 1678 maj. pagefaults]

./kcbench -b -j 4 -s ./ -i 1
Processor:           Intel(R) Core(TM) i3-1005G1 CPU @ 1.20GHz [4 CPUs]
Cpufreq; Memory:     powersave [intel_pstate]; 7605 MiB
Linux running:       5.15.0-47-generic [x86_64]
Compiler:            gcc (Ubuntu 11.2.0-19ubuntu1) 11.2.0
Linux compiled:      6.0.9 [/linux-6.0.9/./]
Config; Environment: defconfig; CCACHE_DISABLE="1"
Build command:       make vmlinux
Run 1 (-j 4):        508.25 seconds / 7.08 kernels/hour [P:391%, 1464 maj. pagefaults]

./kcbench -b -j 16 -s ./ -i 1 | tee thinkpad.log
Processor:           AMD Ryzen 7 PRO 5850U with Radeon Graphics [16 CPUs]
Cpufreq; Memory:     schedutil [amd-pstate]; 11788 MiB
Linux running:       5.15.0-47-generic [x86_64]
Compiler:            gcc (Ubuntu 11.2.0-19ubuntu1) 11.2.0
Linux compiled:      6.0.9 [/linux-6.0.9/./]
Config; Environment: defconfig; CCACHE_DISABLE="1"
Build command:       make vmlinux
Run 1 (-j 16):       178.47 seconds / 20.17 kernels/hour [P:1497%, 2450 maj. pagefaults]

```

# Android Go

```
build/make/target/product/go_defaults_512.mk
build/make/target/product/go_defaults_common.mk
build/make/target/product/go_defaults.mk
build/make/target/board/go_defaults_512.prop
build/make/target/board/go_defaults_common.prop
build/make/target/board/go_defaults.prop
```



# Pixel

- walleye

```
adb shell setprop persist.vendor.charge.start.level 20
adb shell setprop persist.vendor.charge.stop.level 30
```

- sargo 
- `lineage-sdk/sdk/src/java/lineageos/providers/LineageSettings.java`
```
diff --git a/sdk/src/java/lineageos/providers/LineageSettings.java b/sdk/src/java/lineageos/providers/LineageSettings.java
index 98884790..bb7fe8ad 100644
--- a/sdk/src/java/lineageos/providers/LineageSettings.java
+++ b/sdk/src/java/lineageos/providers/LineageSettings.java
@@ -1397,7 +1397,7 @@ public final class LineageSettings {
 
         /** @hide */
         public static final Validator CHARGING_CONTROL_LIMIT_VALIDATOR =
-                new InclusiveIntegerRangeValidator(70, 100);
+                new InclusiveIntegerRangeValidator(20, 100);
 
         /**
          * Whether the battery light should be enabled (if hardware supports it)
```
- `LineageParts/res/layout/preference_charging_limit.xml`

```
diff --git a/res/layout/preference_charging_limit.xml b/res/layout/preference_charging_limit.xml
index 2b4c1879..48c2ebe7 100644
--- a/res/layout/preference_charging_limit.xml
+++ b/res/layout/preference_charging_limit.xml
@@ -45,7 +45,7 @@
         android:layout_width="match_parent"
         android:layout_height="wrap_content"
         android:paddingVertical="15dip"
-        android:min="70"
+        android:min="20"
         android:max="100" />
 
 </LinearLayout>

```

- Sargo A11 installation

```
cd sargo-rq3a.211001.001
mkdir tmp && TMPDIR="$PWD/tmp" ./flash-all.sh
fastboot flash boot  lineage-19.1-20230404-nightly-sargo-BOOT-RECOVERY.img
adb sideload lineage-19.1-20230419-microG-sargo.zip
adb sideload lineage-18.1-20220406-microG-sargo.zip
adb sideload lineage-18.1-20230817-UNOFFICIAL-sargo.zip
```

- URLs

```
storage.googleapis.com
afwprovisioning-pa.googleapis.com
www.gstatic.com
googlehosted.l.googleusercontent.com
ota-cache1.googlezip.net
dl.google.com
instantmessaging-pa.googleapis.com
www.google.com
ssl.gstatic.com
ota.googlezip.net
digitalassetlinks.googleapis.com
clients.l.google.com
gstatic.com
mobile-gtalk.l.google.com
mobile.l.google.com
lpa.ds.gsma.com
connectivitycheck.gstatic.com
app-measurement.com
```


- Pixel battery

```
I cut the Battery Management PCB off of the battery and soldered the output of the buck converter to the B+ and B- pads (remember to check polarity). I then soldered another wire to the B- pad and grounded it on the screw that secures the LCD.  4.2V 5A Buck Converter.

You will need to cut the small battery management PCB from the battery. Solder 3 wire to the battery management board. (1 wire to battery [B+], and 2 wire to battery[B-]). Connect one of 2 wire that connected to battery [B-] terminal to a ground point of the pixel main PCB. Supply the power for the phone with about 4.2V PSU. I tried some ground points of the pixel main board. Some point will allow the phone power up but cannot pass the boot screen. The most easy and fully working ground point is the bolt that hold LCD cable(Check the image below ).

I managed to also make mine work, but ended up using less hardware. I have an old Oneplus brick that supplies 5V 4A. I took that and wired it up to the board exactly like everyone else. So far it's running. I want to run it for awhile before considering it a complete great success.

```

