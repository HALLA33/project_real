package spring.service;

import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.URLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Service;
import org.xmlpull.v1.XmlPullParser;
import org.xmlpull.v1.XmlPullParserException;
import org.xmlpull.v1.XmlPullParserFactory;

import spring.model.board.Book;
import spring.model.board.Movie;

@Service("naverMovieService")
public class NaverMovieService {
	private Logger log = LoggerFactory.getLogger(getClass());

    //display ==> 몇개 출력
    //start==>몇번쨰부터 (item)
    public List<Movie> searchMovie(String keyword, int display, int start){
    	log.info("search 함수 실행");
    	
    	String clientID = "Ym24vNXnOwftAe2SaXT2";
    	String clientSecret = "VlzpYE7fBu";
    	    
        List<Movie> list = null;
        try {
            URL url;		
            url = new URL("https://openapi.naver.com/v1/search/"
                    + "movie.xml?query="
                    + URLEncoder.encode(keyword, "UTF-8")
                    + (display !=0 ? "&display=" +display :"")
                    + (start !=0 ? "&start=" +start :""));
 
            URLConnection urlConn = url.openConnection();
            urlConn.setRequestProperty("X-Naver-Client-Id", clientID);
            urlConn.setRequestProperty("X-Naver-Client-Secret", clientSecret);
            
            XmlPullParserFactory factory = XmlPullParserFactory.newInstance();
            XmlPullParser parser = factory.newPullParser();
            
            InputStream is = urlConn.getInputStream();
            //결과 인코딩
            parser.setInput(is, "UTF-8");
 
            int eventType = parser.getEventType();
            Movie m = null;
            while (eventType != XmlPullParser.END_DOCUMENT) {
                switch (eventType) {
                case XmlPullParser.END_DOCUMENT: // 문서의 끝
                    break;
                case XmlPullParser.START_DOCUMENT:
                    list = new ArrayList<Movie>();
                    break;
                case XmlPullParser.END_TAG: {
                    String tag = parser.getName();
                    if(tag.equals("item"))
                    {
                        list.add(m);
                        m = null;
                    }
                }
                case XmlPullParser.START_TAG: {
                    String tag = parser.getName();
                    switch (tag) {
                    case "item":
                        m = new Movie();
                        break;
                    case "title":
                        if(m != null)
                            m.setTitle(parser.nextText());
                        break;
                    case "link":
                        if(m != null)
                            m.setLink(parser.nextText());
                        break;
                    case "image":
                        if(m != null)
                            m.setImage(parser.nextText());
                        break;
                    case "director":
                        if(m != null)
                            m.setDirector(parser.nextText());
                        break;
                    case "subtitle":
                        if(m != null)
                            m.setSubtitle(parser.nextText());
                        break;
                    case "pubDate":
                        if(m != null)
                            m.setPubDate(parser.nextText());
                        break;
                    case "actor":
                        if(m != null)
                            m.setActor(parser.nextText());
                        break;
                    case "userRating":
                        if(m != null)
                            m.setUserRating(parser.nextText());
                        break;
                    }
 
                }
                }
                eventType = parser.next();
               
            }
 
        } catch (MalformedURLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (UnsupportedEncodingException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (IOException e) {
            // TODO Auto-generated catch block
        	System.out.println("error");
            e.printStackTrace();
        } catch (XmlPullParserException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
       
        
        return list;
    }
}
