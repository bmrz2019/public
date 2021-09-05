#!/bin/bash
set -e

### adb shell pm list packages -f|grep -v system|awk -F"=" '{print "adb shell am start -a android.intent.action.VIEW -d  https://f-droid.org/packages/" $2}'


repo="https://ftp.fau.de/fdroid/repo/"

#downloadFromFdroid packageName overrides
downloadFromFdroid() {
	mkdir -p tmp
    [ "$oldRepo" != "$repo" ] && rm -f tmp/index.xml
    oldRepo="$repo"
	if [ ! -f tmp/index.xml ];then
		#TODO: Check security keys
		wget --quiet --connect-timeout=10 $repo/index.jar -O tmp/index.jar
		unzip -p tmp/index.jar index.xml > tmp/index.xml
	fi
	marketvercode="$(xmlstarlet sel -t -m '//application[id="'"$1"'"]' -v ./marketvercode tmp/index.xml || true)"
	apk="$(xmlstarlet sel -t -m '//application[id="'"$1"'"]/package[versioncode="'"$marketvercode"'"]' -v ./apkname tmp/index.xml || xmlstarlet sel -t -m '//application[id="'"$1"'"]/package[1]' -v ./apkname tmp/index.xml)"
   #if [ ! -f $apk ];then
        while ! wget --no-use-server-timestamps --connect-timeout=10 $repo/$apk -O $1".apk";do sleep 1; done
   #fi
   #rm -f $apk
   adb install $1".apk"
}
repo="https://ftp.fau.de/fdroid/repo/"
downloadFromFdroid com.kgurgul.cpuinfo
downloadFromFdroid com.android.gpstest.osmdroid
downloadFromFdroid de.eidottermihi.raspicheck
downloadFromFdroid org.shadowice.flocke.andotp
downloadFromFdroid org.schabi.newpipe
downloadFromFdroid io.kuenzler.blogger1
downloadFromFdroid com.vonglasow.michael.satstat
downloadFromFdroid org.lineageos.openweathermapprovider
downloadFromFdroid me.austinhuang.instagrabber
downloadFromFdroid com.vrem.wifianalyzer
downloadFromFdroid com.tengu.sharetoclipboard
downloadFromFdroid com.aurora.store
downloadFromFdroid de.t_dankworth.secscanqr
downloadFromFdroid com.artifex.mupdf.mini.app
downloadFromFdroid de.corona.tracing
downloadFromFdroid com.enrico.filemanager
downloadFromFdroid com.android.news
downloadFromFdroid com.android.sony
downloadFromFdroid org.wikipedia
downloadFromFdroid org.fdroid.fdroid
downloadFromFdroid com.oF2pks.applicationsinfo
downloadFromFdroid com.battlelancer.seriesguide
downloadFromFdroid org.lineageos.jelly
downloadFromFdroid org.xbmc.kore
downloadFromFdroid org.videolan.vlc
downloadFromFdroid de.schildbach.oeffi
downloadFromFdroid com.fsck.k9
downloadFromFdroid ws.xsoh.etar
downloadFromFdroid in.blogspot.anselmbros.torchie
downloadFromFdroid com.android.devanagari_offline
downloadFromFdroid lanchon.sigspoof.checker
downloadFromFdroid net.programmierecke.radiodroid2
downloadFromFdroid org.bromite.bromite
downloadFromFdroid org.quantumbadger.redreader
downloadFromFdroid io.kuenzler.nitter
downloadFromFdroid net.osmand.plus
downloadFromFdroid at.bitfire.icsdroid
downloadFromFdroid de.danoeh.antennapod
