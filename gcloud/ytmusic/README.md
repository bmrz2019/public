# ytmusic-deleter
A command-line interface for performing batch delete operations on your YouTube Music library. You can use this to remove items from both your library and from your uploads.

## Install

- Open terminal in gcloud
- https://github.com/apastel/ytmusic-deleter
- Do `pip3 install ytmusicapi`
- Open music.youtube.com
- Developer tools
- Look for music.youtube.com/browse then filter for browse
- Go Network tab
- Headers
- Request Headers; Look for "cookie: CONSENT="
- Create file `headers_auth.json`

```
{
    "User-Agent": "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/100.0.4896.127 Safari/537.36",
    "Accept": "*/*",
    "Accept-Language": "en-US,en;q=0.5",
    "Content-Type": "application/json",
    "X-Goog-AuthUser": "0",
    "x-origin": "https://music.youtube.com",
    "Cookie" : "CONSENT=YES+US.us+19770830-14-0; LOGIN_INFO=ddddd-OUKU8PdfOeyg0AiAsL22d0aB39-57RYB_4ECv8oLSY1eqcGXn-ddddd; VISITOR_INFO1_LIVE=5555555555; YSC=55555555; SID=55555555555-I8l5EZ2Z5tQqS_toeY_U42zNu81b8Z_MaaXxd6wGheGfRYA.; __Secure-1PSID=55555555-I8l5EZ2Z5tQqS_toeY_U42zNuS8xCC8JUF_Jw9VMBD18oHg.; __Secure-3PSID=Nzzzzzzzzzzzzzzzzzzzz_toeY_U42zNuARBlhKT92oV4CSB71tWsyg.; HSID=zzzzzzzzz; SSID=zzzzzzz; APISID=_Qvxzzzzzzzzzzzzzzzzza-F7aTUi; SAPISID=ddddd/AH9fJdddddddddddddddddddddddddddrA_HTw5AujEE; __Secure-1PAPISID=zz/zzzz; __Secure-3PAPISID=1HddddddddddddddddddddddddddddddddddddujEE; PREF=tz=Europe.NewYork&volume=100&library_tab_browse_id=FEmusic_liked_playlists; SIDCC=AEf-dddddddddddddddddddddddddddddddd; __Secure-1PSIDCC=AEf-X55555555555555555555I; __Secure-3PS555555555555KZQ"
}
```

- Follow syntax `ytmusic-deleter --help`
