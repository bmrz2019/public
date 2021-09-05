
# Webview problem

https://stackoverflow.com/questions/47771494

https://issuetracker.google.com/issues/70698550

https://bugs.chromium.org/p/chromium/issues/detail?id=794020

```
public class WebViewBugFixDemo extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        // todo : set your content layout

        final WebView webView = (WebView) findViewById(R.id.webview);
        final String indexUrl = "http://www.yourhost.com";
        final String indexHost = Uri.parse(indexUrl).getHost();
        webView.loadUrl(indexUrl);

        webView.setWebViewClient(new WebViewClient() {
            public boolean shouldOverrideUrlLoading(WebView view, String url) {
                if (isSameWithIndexHost(url, indexHost)) {
                    return false;
                }
                view.loadUrl(url);
                return true;
            }

            @Override
            public boolean shouldOverrideUrlLoading(WebView view, WebResourceRequest request) {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP && request != null && request.getUrl() != null) {
                    String url = request.getUrl().toString();
                    if (isSameWithIndexHost(url, indexHost)) {
                        return false;
                    }
                    view.loadUrl(url);
                    return true;
                }
                return super.shouldOverrideUrlLoading(view, request);
            }
        });
    }

    /**
     * if the loadUrl's host is same with your index page's host, DON'T LOAD THE URL YOURSELF !
     * @param loadUrl the new url to be loaded
     * @param indexHost Index page's host
     * @return
     */
    private boolean isSameWithIndexHost(String loadUrl, String indexHost) {
        if (TextUtils.isEmpty(loadUrl)) {
            return false ;
        }
        Uri uri = Uri.parse(loadUrl) ;
        Log.e("", "### uri " + uri) ;
        return uri != null && !TextUtils.isEmpty(uri.getHost()) ? uri.getHost().equalsIgnoreCase(indexHost) : false ;
    }
}
```
