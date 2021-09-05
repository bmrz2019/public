<?php
                    function getContent() {
                        //Thanks to https://davidwalsh.name/php-cache-function for cache idea
                        $file = "./feed-cache.txt";
                        $current_time = time();
                        $expire_time = 5 * 60;
                        $file_time = filemtime($file);

                        if(file_exists($file) && ($current_time - $expire_time < $file_time)) {
                            return file_get_contents($file);
                        }
                        else {
                            $content = getFreshContent();
                            file_put_contents($file, $content);
                            return $content;
                        }
                    }

                    function getFreshContent() {
                        $html = '<html lang="en"><head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>Lite</title>

    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" rel="stylesheet">


  </head>

  <body><div class="container">';
          
                        $newsSource = array(
                            array(
                                "title" => "Jeffrey Sachs",
                                "url" => "https://www.twitrss.me/twitter_user_to_rss/?user=jeffdsachs"
                            ),                            
                            array(
                                "title" => "Nature",
                                "url" => "https://www.twitrss.me/twitter_user_to_rss/?user=NatureNews"
                            ),                            
                            array(
                                "title" => "TechCrunch",
                                "url" => "http://feeds.feedburner.com/Techcrunch/europe"
                            ),                            
                            array(
                                "title" => "Handelsblatt",
                                "url" => "http://www.handelsblatt.com/contentexport/feed/top-themen"
                            ),                            
                            array(
                                "title" => "Google US",
                                "url" => "https://news.google.com/news/rss/?gl=US&ned=us&hl=en"
                            ),
                            array(
                                "title" => "Google IN",
                                "url" => "https://news.google.com/news/rss/?ned=in&gl=IN&hl=en-IN"
                            ),
                            array(
                                "title" => "Google GB",
                                "url" => "https://news.google.com/news/rss/?ned=uk&gl=GB&hl=en-GB"
                            ),
                            array(
                                "title" => "The Hindu",
                                "url" => "http://www.thehindu.com/news/national/?service=rss"
                            ),
                            array(
                                "title" => "Hacker News",
                                "url" => "https://news.ycombinator.com/rss"
                            ),
                            array(
                                "title" => "The Local",
                                "url" => "https://www.thelocal.de/feeds/rss.php"
                            ),
                            array(
                                "title" => "Spiegel",
                                "url" => "http://www.spiegel.de/schlagzeilen/tops/index.rss"
                            ),
                            array(
                                "title" => "Reuters",
                                "url" => "http://feeds.reuters.com/reuters/topNews"
                            ),
                            array(
                                "title" => "FAZ",
                                "url" => "http://www.faz.net/rss/aktuell/"
                            ),
                            array(
                                "title" => "Hessenschau",
                                "url" => "http://www.hessenschau.de/index.rss"
                            ),
                            array(
                                "title" => "Gnome",
                                "url" => "http://planet.gnome.org/rss20.xml"
                            ),
                            array(
                                "title" => "Hessenschau",
                                "url" => "http://www.hessenschau.de/index.rss"
                            ),
                        );
                        function getFeed($url){
                            $rss = simplexml_load_file($url);
                            $count = 0;
                            $html .= '<ul>';
                            foreach($rss->channel->item as$item) {
                                $count++;
                                if($count > 5){
                                    break;
                                }
                                $html .= '<li><a href="'.htmlspecialchars($item->link).'">'.htmlspecialchars($item->title).'</a></li><br>';
                            }
                            $html .= '</ul>';
                            return $html;
                        }

                        foreach($newsSource as $source) {
                            $html .= '<h2>'.$source["title"].'</h2>';
                            $html .= getFeed($source["url"]);
                        }
                        return $html;
                    }

                    print getContent();

