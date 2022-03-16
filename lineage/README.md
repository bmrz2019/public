## Bromite systemwebview

- https://github.com/bromite/bromite/releases
- Replace `arm64_SystemWebView.apk` in the directory `lineage-17.1/external/chromium-webview/prebuilt/arm64`
 
## microG patch

- https://github.com/lineageos4microg/docker-lineage-cicd/tree/master/src/signature_spoofing_patches
- Once you've downloaded the correct patch for your build version, change to the `frameworks/base` directory of your build tree and run `patch -p1 -i "path/to/where/you/saved/the/patch"`
  
## Shutdown

- Change `SHUTDOWN_VIBRATE_MS = 50`
- in the file `services/core/java/com/android/server/power/ShutdownThread.java`

## SSE

- Edit ```build/art.go```

```diff
-       if !envFalse(ctx, "CPU_SSE42") {
-               cflags = append(cflags, "-msse4.2")
-               cflags = append(cflags, "-mpopcnt")
-       }
```

- or `export CPU_SSE42=false`


## Custom include dirs

- Assuming the `includes/lib/bin` are local prefix `/home/username/soft` (see section below)

```diff
Directory lineage/kernel/google/msm-4.9
$ git diff
diff --git a/Makefile b/Makefile
index e00787c5..5f6292ce 100644
--- a/Makefile
+++ b/Makefile
@@ -13,7 +13,7 @@ NAME = Roaring Lionus
 # o Do not use make's built-in rules and variables
 #   (this increases performance and avoids hard-to-debug behaviour);
 # o Look for make include files relative to root of kernel src
-MAKEFLAGS += -rR --include-dir=$(CURDIR)
+MAKEFLAGS += -rR --include-dir=$(CURDIR) --include-dir=/home/username/soft/include
 
 # Avoid funny character set dependencies
 unexport LC_ALL
diff --git a/scripts/Makefile b/scripts/Makefile
index 1d80897a..daa3b0ef 100644
--- a/scripts/Makefile
+++ b/scripts/Makefile
@@ -10,6 +10,8 @@
 # check-lc_ctype: Used in Documentation/DocBook
 
 HOST_EXTRACFLAGS += -I$(srctree)/tools/include
+HOST_EXTRACFLAGS += -I/home/username/soft/include
+HOST_EXTRACFLAGS += -L/home/username/soft/lib
 
 hostprogs-$(CONFIG_KALLSYMS)     += kallsyms
 hostprogs-$(CONFIG_LOGO)         += pnmtologo

```

## Assorted packages

- If the local install dir is `$HOME/soft` then please add the file `$HOME/soft/share/config.site`

``` 
CPPFLAGS=-I$HOME/soft/include
LDFLAGS=-L$HOME/soft/lib 
```

- Then

```
cd libsdl1.2-1.2.15+dfsg2
./configure --prefix=$HOME/soft --disable-esd --disable-video-x11
cd lz4-1.9.3
cp lz4 ~/soft/bin
cp liblz4.so* ~/soft/lib
cp liblz4.a ~/soft/lib
apt-get source ccache
cd ccache-4.2
mkdir build
cmake ../ -DCMAKE_PREFIX_PATH=$HOME/soft -DZSTD_FROM_INTERNET=ON  -DCMAKE_BUILD_TYPE=Release
cp ccache ~/soft/bin
```
