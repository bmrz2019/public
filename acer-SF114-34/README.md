# Hibernate

Verify

`pm-is-supported  --hibernate`

And edit

`systemctl edit --full systemd-hibernate.service`

And change to

```
[Unit]
Description=Hibernate
Documentation=man:systemd-suspend.service(8)
DefaultDependencies=no
Requires=sleep.target
After=sleep.target

[Service]
Type=oneshot
ExecStart=/usr/sbin/pm-hibernate
#ExecStart=/lib/systemd/systemd-sleep hibernate
```

then

```
systemctl daemon-reload
```

Edit

```
/usr/lib/pm-utils/defaults 
HIBERNATE_MODE="shutdown"
```

```
/etc/systemd/sleep.conf

[Sleep]
AllowSuspend=no
AllowHibernation=yes
AllowSuspendThenHibernate=no
AllowHybridSleep=no
#SuspendMode=
#SuspendState=mem standby freeze
HibernateMode=shutdown
#HibernateState=disk
#HybridSleepMode=suspend platform shutdown
#HybridSleepState=disk
#HibernateDelaySec=180min
```

Then

```
systemctl daemon-reload
update-initramfs  -k all -u
```

# systemd

```
/etc/systemd/system.conf

DefaultTimeoutStartSec=30s
DefaultTimeoutStopSec=9s
```

# Packages

```apt-get install -y openbox-lxde-session lxde-icon-theme  lxsession lxde-core lxappearance gtk-chtheme gkrellm-cpufreq  lxterminal pm-utils qpdfview ubuntu-mono inxi openjdk-11-jdk gkrellm-cpufreq

apt-get purge lxlock
```

Final list of packages are in file packages.impish.txt


# inxi

```
$ inxi -Fz
System:
  Kernel: 5.13.0-19-generic x86_64 bits: 64 Desktop: LXDE 0.10.1 
  Distro: Ubuntu 21.10 (Impish Indri) 
Machine:
  Type: Laptop System: Acer product: Swift SF114-34 v: V1.07 
  serial: <filter> 
  Mobo: JSL model: Labatt_JL v: V1.07 serial: <filter> UEFI: Insyde v: 1.07 
  date: 03/21/2021 
Battery:
  ID-1: BAT0 charge: 45.5 Wh (91.4%) condition: 49.8/48.0 Wh (103.8%) 
CPU:
  Info: Quad Core model: Intel Pentium Silver N6000 bits: 64 type: MCP 
  cache: L2: 4 MiB 
  Speed: 800 MHz min/max: 800/3300 MHz Core speeds (MHz): 1: 800 2: 770 
  3: 799 4: 786 
Graphics:
  Device-1: Intel JasperLake [UHD Graphics] driver: i915 v: kernel 
  Device-2: Quanta HD User Facing type: USB driver: uvcvideo 
  Display: x11 server: X.Org 1.20.13 driver: loaded: modesetting 
  unloaded: fbdev,vesa resolution: 1920x1080~60Hz 
  OpenGL: renderer: Mesa Intel UHD Graphics (JSL) v: 4.6 Mesa 21.2.2 
Audio:
  Device-1: Intel driver: snd_hda_intel 
  Sound Server-1: ALSA v: k5.13.0-19-generic running: yes 
  Sound Server-2: PulseAudio v: 15.0 running: yes 
  Sound Server-3: PipeWire v: 0.3.32 running: yes 
Network:
  Device-1: Intel Wi-Fi 6 AX201 160MHz driver: iwlwifi 
  IF: wlp0s20f3 state: up mac: <filter> 
Bluetooth:
  Device-1: Intel type: USB driver: btusb 
  Report: hciconfig ID: hci0 state: up address: <filter> bt-v: 3.0 
Drives:
  Local Storage: total: 116.62 GiB used: 32 GiB (27.4%) 
  ID-1: /dev/mmcblk0 model: A29128 size: 116.62 GiB 
Swap:
  ID-1: swap-1 type: partition size: 7.99 GiB used: 0 KiB (0.0%) 
  dev: /dev/mmcblk0p4 
Sensors:
  System Temperatures: cpu: 45.0 C mobo: N/A 
  Fan Speeds (RPM): N/A 

```
