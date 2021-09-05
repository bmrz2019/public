# Policy Kit
Policy kit

https://blog.xfce.org/category/xfce/page/11/

Verify files 
```

/usr/share/polkit-1/actions/org.freedesktop.login1.policy

/usr/share/polkit-1/actions/org.xfce.power.policy

/etc/polkit-1/rules.d/85-suspend.rules
```

Run command

```
pkaction --action-id org.freedesktop.login1.suspend --verbose
org.freedesktop.login1.suspend:
  description:       Suspend the system
  message:           Authentication is required for suspending the system.
  vendor:            The systemd Project
  vendor_url:        http://www.freedesktop.org/wiki/Software/systemd
  icon:              
  implicit any:      auth_admin_keep
  implicit inactive: auth_admin_keep
  implicit active:   yes
```
## To check hibernate
```
pkaction --action-id org.freedesktop.login1.hibernate --verbose
org.freedesktop.login1.hibernate:
  description:       Hibernate the system
  message:           Authentication is required for hibernating the system.
  vendor:            The systemd Project
  vendor_url:        http://www.freedesktop.org/wiki/Software/systemd
  icon:              
  implicit any:      yes
  implicit inactive: yes
  implicit active:   yes

```
