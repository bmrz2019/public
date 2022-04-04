
### policies.json

```
xattr -r -d com.apple.quarantine /Applications/Firefox.app
```

#### ExtensionSettings


- macOS
- ```/Applications/Firefox.app/Contents/Resources/distribution/policies.json```

```
{
  "policies": {
    "ExtensionSettings": {
      "*": {
        "blocked_install_message": "Do it.",
        "install_sources": ["about:addons","https://addons.mozilla.org/"],
        "installation_mode": "allowed",
        "allowed_types": ["extension"]
      },
      "uBlock0@raymondhill.net": {
        "installation_mode": "force_installed",
        "install_url": "https://addons.mozilla.org/firefox/downloads/latest/ublock-origin/latest.xpi"
      },
      "https-everywhere@eff.org": {
        "installation_mode": "allowed"
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
      "StartPage": "none"
    },
    "OverrideFirstRunPage": "",
    "OverridePostUpdatePage": "",
    "Preferences": {
      "datareporting.policy.dataSubmissionPolicyBypassNotification": true
    }
  }
}
```

