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


# Packages

```apt-get install -y openbox-lxde-session lxde-icon-theme  lxsession lxde-core lxappearance gtk-chtheme gkrellm-cpufreq  lxterminal pm-utils qpdfview ubuntu-mono inxi openjdk-11-jdk gkrellm-cpufreq

apt-get purge lxlock
```

Final list of packages are in file packages.impish.txt
