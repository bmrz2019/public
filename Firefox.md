### about:config

- For increasing scrollbar width


```
widget.gtk.overlay-scrollbars.enabled  false
widget.non-native-theme.gtk.scrollbar.thumb-size 1
```

- For really wide scrollbar use

```
widget.gtk.overlay-scrollbars.enabled  false
widget.non-native-theme.scrollbar.style   4
```

### policies.json

- ```xattr -r -d com.apple.quarantine /Applications/Firefox.app```

#### ExtensionSettings


- macOS: `/Applications/Firefox.app/Contents/Resources/distribution/policies.json`
- linux: `/etc/firefox/policies/policies.json`


```
{
  "policies": {
    "AIControls": {
      "Default": {
        "Value": "blocked",
        "Locked": true
      },
      "Translations": {
        "Value": "available",
        "Locked": false
      }
    },
    "ExtensionSettings": {
      "uBlock0@raymondhill.net": {
        "installation_mode": "force_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
      }
    },
    "DisableFirefoxStudies": true,
    "DisablePocket": true,
    "DisableTelemetry": true,
    "DontCheckDefaultBrowser": true,
    "FirefoxHome": {
      "Highlights": false,
      "Pocket": false,
      "Search": false,
      "Snippets": false,
      "TopSites": false
    },
    "Homepage": {
      "URL": "https://www.google.com",
      "StartPage": "none"
    },
    "OverrideFirstRunPage": "",
    "OverridePostUpdatePage": "",
    "DownloadDirectory": "/tmp",
    "DisplayMenuBar": "always",
    "DisplayBookmarksToolbar": "always",
    "Preferences": {
      "browser.tabs.drawInTitlebar": {
        "Value": 0
      },
      "widget.non-native-theme.scrollbar.style": {
        "Value": 1
      },
      "widget.non-native-theme.enabled": {
        "Value": true
      }
    }
  }
}
```

