# Nokia 2.2
https://en.wikipedia.org/wiki/Nokia_2.2

# Good
 
  - Android one
  -  removable 3000 mAh battery
  -  microUSB port.

# Bad

  - You will not get any notifications for user installed apps :-(

# Forums
https://community.phones.nokia.com/categories/nokia-2-2

# Remove junk (a.k.a. Play Services)

  - Import a HTML file and watch it magically convert to Markdown
  - Drag and drop images (requires your Dropbox account be linked)

### Enable 3 button navbar
https://community.phones.nokia.com/discussion/57250/guide-to-enable-3-button-navigation-in-android-10

  - set quickstep as default launcher
  - enable gesture navigation instead of 2 button
  - install another launcher like lawnchair and enable it as default.



### Remove crap

Taken from  XDA link https://forum.xda-developers.com/nokia-7-plus/how-to/stock-disabling-crap-device-ota-t3906929

Run this inside ```adb shell``` after enabling developer in settings.

```sh
adb shell  pm disable-user --user 0 com.mediatek.ims
adb shell  pm disable-user --user 0 com.android.cts.priv.ctsshim
adb shell  pm disable-user --user 0 com.google.android.youtube
adb shell  pm disable-user --user 0 com.google.android.ext.services
adb shell  pm disable-user --user 0 com.google.android.googlequicksearchbox
adb shell  pm disable-user --user 0 com.google.android.apps.googleassistant
adb shell  pm disable-user --user 0 com.mediatek.telephony
adb shell  pm disable-user --user 0 com.google.android.onetimeinitializer
adb shell  pm disable-user --user 0 com.google.android.ext.shared
adb shell  pm disable-user --user 0 com.mediatek.location.lppe.main
adb shell  pm disable-user --user 0 com.android.wallpapercropper
adb shell  pm disable-user --user 0 com.mediatek.simprocessor
adb shell  pm disable-user --user 0 com.hmdglobal.app.activation
adb shell  pm disable-user --user 0 com.google.android.apps.messaging
adb shell  pm disable-user --user 0 com.mediatek.omacp
adb shell  pm disable-user --user 0 com.google.android.overlay.gmsgsaconfig
adb shell  pm disable-user --user 0 com.google.ar.lens
adb shell  pm disable-user --user 0 com.android.vending
adb shell  pm disable-user --user 0 com.android.simappdialog
adb shell  pm disable-user --user 0 com.google.android.marvin.talkback
adb shell  pm disable-user --user 0 com.google.android.apps.work.oobconfig
adb shell  pm disable-user --user 0 com.android.nfc
adb shell  pm disable-user --user 0 com.android.stk
adb shell  pm disable-user --user 0 com.android.backupconfirm
adb shell  pm disable-user --user 0 com.google.android.gm
adb shell  pm disable-user --user 0 com.hmdglobal.app.myphonehelper
adb shell  pm disable-user --user 0 com.android.settings.intelligence
adb shell  pm disable-user --user 0 com.google.android.setupwizard
adb shell  pm disable-user --user 0 android.autoinstalls.config.hmdglobal.wasp
adb shell  pm disable-user --user 0 com.android.printspooler
adb shell  pm disable-user --user 0 com.android.dreams.basic
adb shell  pm disable-user --user 0 com.google.android.apps.wellbeing
adb shell  pm disable-user --user 0 com.google.android.dialer
adb shell  pm disable-user --user 0 com.android.bips
adb shell  pm disable-user --user 0 com.google.android.apps.nbu.files
adb shell  pm disable-user --user 0 com.google.android.overlay.gmsconfig
adb shell  pm disable-user --user 0 com.google.android.apps.docs
adb shell  pm disable-user --user 0 com.google.android.apps.maps
adb shell  pm disable-user --user 0 com.google.android.contacts
adb shell  pm disable-user --user 0 com.google.android.syncadapters.contacts
adb shell  pm disable-user --user 0 com.android.chrome
adb shell  pm disable-user --user 0 com.google.android.gms
adb shell  pm disable-user --user 0 com.google.android.gsf
adb shell  pm disable-user --user 0 com.google.android.ims
adb shell  pm disable-user --user 0 com.google.android.tag
adb shell  pm disable-user --user 0 com.google.android.tts
adb shell  pm disable-user --user 0 com.google.android.gmsintegration
adb shell  pm disable-user --user 0 com.android.calllogbackup
adb shell  pm disable-user --user 0 com.google.android.partnersetup
adb shell  pm disable-user --user 0 com.android.carrierdefaultapp
adb shell  pm disable-user --user 0 com.google.android.feedback
adb shell  pm disable-user --user 0 com.google.android.printservice.recommendation
adb shell  pm disable-user --user 0 com.google.android.apps.photos
adb shell  pm disable-user --user 0 com.google.android.calendar
adb shell  pm disable-user --user 0 com.android.wallpaper.livepicker
adb shell  pm disable-user --user 0 com.mediatek.gnssdebugreport
adb shell  pm disable-user --user 0 com.hmdglobal.support
adb shell  pm disable-user --user 0 com.google.android.projection.gearhead
adb shell  pm disable-user --user 0 com.google.android.apps.turbo
adb shell  pm disable-user --user 0 com.android.cts.ctsshim
adb shell  pm disable-user --user 0 com.google.android.apps.wallpaper
adb shell  pm disable-user --user 0 com.android.wallpaperbackup
adb shell  pm disable-user --user 0 com.android.providers.userdictionary
adb shell  pm disable-user --user 0 com.android.emergency
adb shell  pm disable-user --user 0 com.google.android.gms.location.history
adb shell  pm disable-user --user 0 com.android.traceur
adb shell  pm disable-user --user 0 com.android.apppredictionservice
adb shell  pm disable-user --user 0 com.hmdglobal.app.legalinformation
adb shell  pm disable-user --user 0 com.mediatek.dataprotection
adb shell  pm disable-user --user 0 com.google.android.inputmethod.latin
adb shell  pm disable-user --user 0 com.google.android.apps.restore
adb shell  pm disable-user --user 0 com.google.android.overlay.searchlauncherconfig
```

# Warning
Do not run the next command without verifying. Some packages with 'com.google.android' is needed for normal phone operation. Otherwise phone crashes boots to recovery. Then, just factory reset.

```sh
for crap in $(pm list packages | grep "evenwell\|google" | cut -d ":" -f2)
do
pm uninstall --user 0 $crap
done
```

