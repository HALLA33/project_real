package spring.controller.board;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.imageio.ImageIO;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import net.sf.jmimemagic.Magic;
import net.sf.jmimemagic.MagicException;
import net.sf.jmimemagic.MagicMatchNotFoundException;
import net.sf.jmimemagic.MagicParseException;
import oracle.jdbc.proxy.annotation.OnError;
import spring.model.board.Board;
import spring.model.board.BookDao;
import spring.model.board.Image;
import spring.model.board.Movie;
import spring.model.board.MovieDao;
import spring.model.board.Reply;
import spring.model.board.ReplyDao;
import spring.model.member.Member;
import spring.model.member.Tags;
import spring.service.NaverMovieService;

@Controller
@RequestMapping("/movie")
public class MovieController {
	private Logger log = LoggerFactory.getLogger(getClass());
	private List<Image> imageList = new ArrayList<>();
	
	@Autowired
    private NaverMovieService naverMovieService; 
	
	@Autowired
	private BookDao bookDao;
	
	@Autowired
	private MovieDao movieDao;
	
	@Autowired
	private ReplyDao replyDao;
	
	@RequestMapping(value= {"/movie-write"}, method=RequestMethod.GET)
	public String movie_write(Model model, @RequestParam(required=false) int item_no, @RequestParam(required=false) int head, HttpSession session){
		model.addAttribute("item_no", item_no);
		model.addAttribute("head", head);
		
		Member member = (Member) session.getAttribute("member");
		if(member==null)
			return "redirect:/home";
		
		List<Tags> taglist = bookDao.taglist();
		
		session.setAttribute("tags", taglist);
		
		return "board/movie/movie-write";
	}

	@RequestMapping(value= {"/movie-write"}, method=RequestMethod.POST)
	public String write_post(HttpServletRequest request, HttpSession session) {
		Movie movie = new Movie();
		movie.setImage(request.getParameter("image"));
		movie.setTitle(request.getParameter("movie_title"));
		movie.setDirector(request.getParameter("director"));
		movie.setActor(request.getParameter("actor"));
		movie.setPubDate(request.getParameter("pubDate"));
		
		Board board = new Board();
		board.setItem_no(Integer.parseInt(request.getParameter("item_no")));
		board.setB_item_no(board.getItem_no());
		board.setHead(Integer.parseInt(request.getParameter("head")));
		board.setB_head(board.getHead());
		board.setTag(request.getParameter("tag"));
		board.setWriter(request.getParameter("writer"));
		board.setTitle(request.getParameter("title"));
		board.setDetail(request.getParameter("ir1"));
		board.setEmotion(request.getParameter("emotion"));
		board.setWeather(request.getParameter("weather"));
		board.setSearch_title(request.getParameter("search_title"));
		board.setSearch_artist(request.getParameter("search_artist"));
		
		Member member =(Member)session.getAttribute("member");
		if(member==null)
			return "redirect:/home";
		
		String notice = "false";		
		if(board.getItem_no()==0 || board.getHead()==0)
			notice = "true";
		board.setNotice(notice);
		
		String tag = board.getTag();
		String convert_tag = null;
		if(tag.length()>0) {
			convert_tag = "#"+ tag.trim().replace(",", "/#").replaceAll(" ", "");
		}	
		board.setTag(convert_tag);
		
		int num = 0;
		List<Movie> list = movieDao.exist_movie(movie);
		for(Movie m:list) {
			num = m.getNo();
		}

		//영화가 존재하지 않으면 새로 저장
		if(num==0) 
			num = movieDao.search_write(movie);

		int no = bookDao.write(board, num);
		board = bookDao.detail_board(no, board.getItem_no());
		
		for(Image i: imageList) {
			log.info("originfilename : " + i.getOriginFileName());
			log.info("movefilename : " + i.getMoveFileName());
			bookDao.upload_image(no, board.getItem_no(), i.getOriginFileName(), i.getMoveFileName());
		}
		
		String nickname = bookDao.search_nickname(board.getWriter());
		int point = bookDao.getpoint(nickname);
		member.setPoint(point);
		
		List<Tags> taglist = bookDao.taglist();
		
		session.setAttribute("tags", taglist);
		
		session.setAttribute("member", member);
		
		log.info(board.toString());
		
		//서버를 clean하면 업로드한 사진들은 없어지기 때문에 copyPath에 사진 업로드 
		//글쓰기 할 때 저장
		String savePath = request.getServletContext().getRealPath("/resources/image");
		File targetPath = new File(savePath);
		File copyPath = new File("E:\\sw\\image");		
		copy(targetPath, copyPath);
		imageList.clear();
		
		return "redirect:/movie/movie-detail?no="+board.getNo()+"&item_no="+board.getItem_no();
	}
	
	@RequestMapping(value= {"/movie-preview"}, method=RequestMethod.GET)
	public String movieGetPreview(HttpSession session) {
		return "redirect:/home";
	}
	
	@RequestMapping(value= {"/movie-preview"}, method=RequestMethod.POST)
	public String moviePreview(Model model, HttpServletRequest request, HttpSession session) {
		Movie movie = new Movie();
		movie.setImage(request.getParameter("image"));
		movie.setTitle(request.getParameter("movie_title"));
		movie.setDirector(request.getParameter("director"));
		movie.setActor(request.getParameter("actor"));
		movie.setPubDate(request.getParameter("pubDate"));
		
		Board board = new Board();
		board.setItem_no(Integer.parseInt(request.getParameter("item_no")));
		board.setB_item_no(board.getItem_no());
		board.setHead(Integer.parseInt(request.getParameter("head")));
		board.setB_head(board.getHead());
		board.setTag(request.getParameter("tag"));
		board.setWriter(request.getParameter("writer"));
		board.setTitle(request.getParameter("title"));
		board.setDetail(request.getParameter("ir1"));
		board.setEmotion(request.getParameter("emotion"));
		board.setWeather(request.getParameter("weather"));
		
		String tag = board.getTag();
		String convert_tag = null;
		if(tag.length()>0) {
			convert_tag = "#"+ tag.trim().replace(",", "#");
		}	
		board.setTag(convert_tag);
		
		model.addAttribute("board", board);
		model.addAttribute("movie", movie);
		
		return "board/movie/movie-preview";
	}
	
	public Map<String, String> image_check(HttpServletRequest request, int no, int item_no, HttpServletResponse response, HttpSession session){
		Map<String, String> result = good_bad(0, request, no, item_no, response, session);
		Map<String, String> map = new HashMap<>();
		
		String good_img = null;
		String bad_img = null;
		
		if(result.get("good").equals("black")) {
			good_img = "img/before_goods.png"; 
		}
		else if(result.get("good").equals("blue")){
			good_img = "img/after_goods.png"; 
		}
		
		if(result.get("bad").equals("black")) {
			bad_img = "img/before_bads.png"; 
		}
		else if(result.get("bad").equals("blue")){
			bad_img = "img/after_bads.png"; 
		}
		
		map.put("good_img", good_img);
		map.put("bad_img", bad_img);
		
		return map;
	}
	
	@RequestMapping("/movie-detail")
	public String movieDetail(Model model, @RequestParam(required=false) int no, @RequestParam(required=false) int item_no, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		plusCount(request, no, item_no, response, session);
		Map<String, String> result = image_check(request, no, item_no, response, session);
		
		Board board = null;
		Movie movie = null;
		
		board = bookDao.detail_board(no, item_no);
		movie = movieDao.detail_movie(board.getSearch_no());
		board.setB_item_no(board.getItem_no());
		board.setB_head(board.getHead());
		
		Member member =(Member)session.getAttribute("member");
		if(member==null)
			return "redirect:/home";
		
//		String[] tags = board.getTag().split("/");
//		
//		for(String s : tags) {
//			log.info("tag : " + s);
//		}
//		
		List<Image> list = bookDao.detail_board_image(no, item_no);
		List<String> imageName = new ArrayList<>();
		for(Image image: list) {
			imageName.add(image.getMoveFileName());
		}
		
		Map<Integer, String> replyNickname = new HashMap<>();	
		List<Reply> listReply = replyDao.reply_list(no, item_no);
		
		for(Reply r: listReply) {
			replyNickname.put(r.getNo(), bookDao.search_nickname(r.getWriter()));
		}
		
		String nickname = bookDao.search_nickname(board.getWriter());

		List<Tags> taglist = bookDao.taglist();
		
		session.setAttribute("tags", taglist);
		
		model.addAttribute("nickname", nickname);		
		model.addAttribute("board", board);
		model.addAttribute("movie", movie);
		model.addAttribute("item", board.getItem_no());
		model.addAttribute("good_img", result.get("good_img"));
		model.addAttribute("bad_img", result.get("bad_img"));
		model.addAttribute("imageName", imageName);
		model.addAttribute("listReply", listReply);
		model.addAttribute("replyNickname", replyNickname);
		
		return "board/movie/movie-detail";
	}
	
	//키워드가 있을때도 있고 없을때도있음 
    //있을때는 가져가고 없을때는 안가져가고 
    @RequestMapping("/movieList")
    public String movieList(Model model, @RequestParam(required=false)String keyword){        
        if(keyword !=null)
        {
        	model.addAttribute("movieList", naverMovieService.searchMovie(keyword,10,1));
            model.addAttribute("keyword", keyword);
        }
        
        return "board/movie/movieList";
    }
    
	@RequestMapping(value= {"/movie-revise/{no}/{item_no}"}, method=RequestMethod.GET)
	public String movieDetail_re(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable int no, @PathVariable int item_no, HttpSession session) {
		Member member = (Member)session.getAttribute("member");
		if(member==null)
			return "redirect:/home";
		
		Board b = bookDao.detail_board(no, item_no);
		if(!member.getId().equals(b.getWriter()))
			return "err/err500";
		
		Board board = null;
		Movie movie = null;
		log.info("아이디 : " + member.getId());
		board = bookDao.detail_board(no, item_no, member.getId());	
		movie = movieDao.detail_movie(board.getSearch_no());

		String tag = board.getTag();
		if(tag != null) {
			tag = tag.replace("#", "").replace("/", ",");
		}
			
		board.setTag(tag);
		
		String nickname = bookDao.search_nickname(member.getId());

		model.addAttribute("nickname", nickname);		
		model.addAttribute("board", board);
		model.addAttribute("movie", movie);
		model.addAttribute("item_no", board.getItem_no());
		
		
		return "board/movie/movie-revise";
	}
	
    @RequestMapping(value= {"/movie-revise/{no}/{item_no}"}, method=RequestMethod.POST)
    public String movieRevise(Model model, HttpServletRequest request, HttpServletResponse response, @PathVariable int no, @PathVariable int item_no, 
    		HttpSession session, @RequestParam(value = "tag", required=false) String tag) {
    	log.info("tag : " + tag);
    	if(tag != null) {
    		tag = "#" + tag.replace(",", "/#").replaceAll(" ", "");
    	}
	    plusCount(request, no, item_no, response, session);
		Map<String, String> result = image_check(request, no, item_no, response, session);
		
    	Member member = (Member)session.getAttribute("member");
    	Movie movie = new Movie();
		movie.setImage(request.getParameter("image"));
		movie.setTitle(request.getParameter("movie_title"));
		movie.setDirector(request.getParameter("director"));
		movie.setActor(request.getParameter("actor"));
		movie.setPubDate(request.getParameter("pubDate"));
		
		Board board = new Board();
		board.setItem_no(Integer.parseInt(request.getParameter("item_no")));
		board.setB_item_no(board.getItem_no());
		board.setHead(Integer.parseInt(request.getParameter("head")));
		board.setB_head(board.getHead());
		board.setWriter(request.getParameter("writer"));
		board.setTitle(request.getParameter("title"));
		board.setDetail(request.getParameter("ir1"));
	    board.setEmotion(request.getParameter("emotion"));
		board.setWeather(request.getParameter("weather"));
		
		String notice = "false";		
		if(board.getItem_no()==0 || board.getHead()==0)
			notice = "true";
		
		board.setNotice(notice);
		
		board.setTag(tag);
		
		int num = 0;
		List<Movie> list = movieDao.exist_movie(movie);
		for(Movie m:list) {
			num = m.getNo();
		}
		
		//영화가 존재하지 않으면 새로 저장
		if(num==0) 
			num = movieDao.search_write(movie);
			
		board.setSearch_no(num);
		bookDao.update_board(board, no, item_no, member.getId(), tag);
		board = bookDao.detail_board(no, board.getItem_no());
		
		if(item_no!=0)
			model.addAttribute("item", item_no);
		else
			model.addAttribute("item", board.getItem_no());
		
		List<Image> imageName = bookDao.delete_image(no, item_no);
		
		for(Image i: imageName) {
			String savePath = request.getServletContext().getRealPath("/resources/image");
			File targetPath = new File(savePath, i.getOriginFileName());
			File copyPath = new File("E:\\sw\\image", i.getOriginFileName());
			delete(targetPath);
			delete(copyPath);
		}
		
		for(Image i: imageList) {
			bookDao.upload_image(no, board.getItem_no(), i.getOriginFileName(), i.getMoveFileName());
		}
		
		String savePath = request.getServletContext().getRealPath("/resources/image");
		File tPath = new File(savePath);
		File cPath = new File("E:\\sw\\image");		
		copy(tPath, cPath);
		imageList.clear();
		
		return "redirect:/movie/movie-detail?no="+board.getNo()+"&item_no="+board.getItem_no();
    }
    
    @RequestMapping(value= {"/movie-delete/{no}/{item_no}"}, method=RequestMethod.GET)
    public String movieDelete(Model model, @PathVariable int no, @PathVariable int item_no, HttpSession session, 
    		@RequestParam(value = "tag", required=false) String tag, HttpServletRequest request, HttpServletResponse reponse) {
    	Member member = (Member)session.getAttribute("member");
    	if(member==null)
    		return "redirect:/home";

    	Board board = bookDao.detail_board(no, item_no);
    	if(!member.getId().equals(board.getWriter()) && !member.getPower().equals("관리자") && !member.getPower().equals("스"))
    		return "redirect:/home";
    	
    	log.info("실행됨"  + tag);
    	
    	if(member.getPower().equals("일반")) {
    		bookDao.delete_board(no, item_no, member.getId(), tag);    		
    	}else if(member.getPower().equals("관리자") || member.getPower().equals("스탭")) {
    		bookDao.delete_board(no, item_no, tag);
    	}
		
    	bookDao.board_delete_cookie(no, item_no);
    	
    	List<Tags> taglist = bookDao.taglist();
		
		session.setAttribute("tags", taglist);
	    
	List<Image> imageName = bookDao.delete_image(no, item_no);
    	for(Image i: imageName) {
			String savePath = request.getServletContext().getRealPath("/resources/image");
			File targetPath = new File(savePath, i.getOriginFileName());
			File copyPath = new File("E:\\sw\\image", i.getOriginFileName());
			delete(targetPath);
			delete(copyPath);
		}

    	String savePath = request.getServletContext().getRealPath("/resources/image");
		File tPath = new File(savePath);
		File cPath = new File("E:\\sw\\image");		
		copy(tPath, cPath);
    	
    	return "redirect:/list?item_no="+item_no;
    }
    
     @RequestMapping(value= {"/goodCount"}, method=RequestMethod.POST)
    @ResponseBody
    public Map<String, String> goodCount(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
    	int no = Integer.parseInt(request.getParameter("no"));
    	int item_no = Integer.parseInt(request.getParameter("item_no"));
    	String bad_img = request.getParameter("bad_tag");
    	String[] bad_imgs = bad_img.split("/");
    	Map<String, String> result = good_bad(1, request, no, item_no, response, session);
    	Map<String, String> map = new HashMap<>();
    	String good_img = null;

		if(result.get("good").equals("black")) {
			if(bad_img.equals("/review/img/after_bads.png") || bad_img.equals("img/after_bads.png")){
				bad_img = "img/before_bads.png";
				bookDao.plus_minus_Count(4, no, item_no);
			}
			else {
				bad_img = "img/before_bads.png";
			}
			good_img = "img/after_goods.png";
			bookDao.plus_minus_Count(1, no, item_no);
		}
		else {
			bad_img = bad_imgs[bad_imgs.length-2] + "/" +bad_imgs[bad_imgs.length-1];
			good_img = "img/before_goods.png";
			bookDao.plus_minus_Count(2, no, item_no);
		}

		Board board = bookDao.detail_board(no, item_no);
		//board.getGood()

		map.put("good_img", good_img);
		map.put("good_number", String.valueOf(board.getGood()));
		map.put("bad_img", bad_img);
		map.put("bad_number", String.valueOf(board.getBad()));
		
		return map;
    }
    
    @RequestMapping(value= {"/badCount"}, method=RequestMethod.POST)
    @ResponseBody
    public Map<String, String> badCount(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
    	int no = Integer.parseInt(request.getParameter("no"));
    	int item_no = Integer.parseInt(request.getParameter("item_no"));
    	String good_img = request.getParameter("good_tag");
    	String[] good_imgs = good_img.split("/");
    	Map<String, String> result = good_bad(2, request, no, item_no, response, session);
    	Map<String, String> map = new HashMap<>();
		String bad_img = null;
		log.info("전 : " + good_img);
		if(result.get("bad").equals("black")) {
			if(good_img.equals("/review/img/after_goods.png") || good_img.equals("img/after_goods.png")){
				good_img = "img/before_goods.png";
				bookDao.plus_minus_Count(2, no, item_no);
			}
			else {
				good_img = "img/before_goods.png";
			}
			bad_img = "img/after_bads.png";
			bookDao.plus_minus_Count(3, no, item_no);
		}
		else {
			good_img = good_imgs[good_imgs.length-2] + "/" +good_imgs[good_imgs.length-1];
			bad_img = "img/before_bads.png";
			bookDao.plus_minus_Count(4, no, item_no);
		}
		log.info("후 : " + good_img);
		Board board = bookDao.detail_board(no, item_no);
		
		map.put("bad_img", bad_img);
		map.put("bad_number", String.valueOf(board.getBad()));
		map.put("good_img", good_img);
		map.put("good_number", String.valueOf(board.getGood()));
		
    	return map;
    }
    
    public void plusCount(HttpServletRequest request, int no, int item_no, HttpServletResponse response, HttpSession session) {
		Cookie cookies[] = request.getCookies();
		Map<String, String> mapCookie = new HashMap<>();
		
		//저장된 쿠키 불러오기
		if(request.getCookies()!=null) {
			for(int i=0; i<cookies.length; i++) {
				Cookie obj = cookies[i];
				mapCookie.put(obj.getName(), obj.getValue());
			}
		}
		
		String origin_cookie = (String) mapCookie.get("read_count"+no+item_no);
		String new_cookie = "{" + no + "&" + item_no + "}";
		String cookie_name = "read_count"+no+item_no;
		Member member = (Member)session.getAttribute("member");

		//쿠키 검사
		if(StringUtils.indexOfIgnoreCase(origin_cookie, new_cookie)==-1) {	//read_count쿠키의 값에 new_cookie가 없으면
			//없으면 쿠키 생성
			Cookie cookie = new Cookie(cookie_name, new_cookie);
			response.addCookie(cookie);
			
			//조회수 업데이트
			bookDao.plus_minus_Count(0, no, item_no);
			//쿠키 테이블에 추가
			bookDao.insert_cookie(1, cookie_name, new_cookie, no, item_no, member.getId());
		}

	}
    //flag
    // 0 : detail 처음
    // 1 : 좋아요 눌렀을 때
    // 2 : 싫어요 눌렀을 때
    public Map<String, String> good_bad(int flag, HttpServletRequest request, int no, int item_no, HttpServletResponse response, HttpSession session) {
    	Cookie cookies[] = request.getCookies();
		Map<String, String> mapCookie = new HashMap<>();
		Map<String, String> result = new HashMap<>();
		Member member = (Member)session.getAttribute("member");
		
		//저장된 쿠키 불러오기
		if(request.getCookies()!=null) {
			for(int i=0; i<cookies.length; i++) {
				Cookie obj = cookies[i];
				mapCookie.put(obj.getName(), obj.getValue());
			}
		}

		String good_cookie = (String) mapCookie.get("good_count"+no+item_no);	//origin_cookie
		String bad_cookie = (String) mapCookie.get("bad_count"+no+item_no);	//origin_cookie
		String cookie = "{" + no + "&" + item_no + "}";				//new_cookie
		String good_cookie_name = "good_count"+no+item_no;						//cookie_name
		String bad_cookie_name = "bad_count"+no+item_no;
		
		if(flag ==0 ) {		
			//쿠키 검사
			if(StringUtils.indexOfIgnoreCase(good_cookie, cookie)==-1) {
				//"좋아요" 쿠기가 없으면
				result.put("good", "black");
			}
			else {
				result.put("good", "blue");
			}
			
			//쿠키 검사
			if(StringUtils.indexOfIgnoreCase(bad_cookie, cookie)==-1) {
				//"싫어요" 쿠기가 없으면
				result.put("bad", "black");
			}
			else {
				result.put("bad", "blue");
			}
		}
		else if(flag == 1) {
			if(StringUtils.indexOfIgnoreCase(good_cookie, cookie)==-1) {
				//"좋아요" 쿠기가 없으면
				result.put("good", "black");
				
				Cookie c_cookie = new Cookie(good_cookie_name, cookie);
				response.addCookie(c_cookie);
				
				//쿠키 테이블에 등록
				bookDao.insert_cookie(2, good_cookie_name, cookie, no, item_no, member.getId());
			}
			else {
				result.put("good", "blue");
				
				Cookie r_cookie = new Cookie("good_count"+no+item_no, null) ;
				r_cookie.setMaxAge(0) ;
			    response.addCookie(r_cookie) ;
			    
			    //쿠키 테이블에서 삭제
			    bookDao.delete_cookie(2, member.getId());
			}
		}
		else if(flag == 2) {
			//쿠키 검사
			if(StringUtils.indexOfIgnoreCase(bad_cookie, cookie)==-1) {
				//"싫어요" 쿠기가 없으면
				result.put("bad", "black");
				
				Cookie c_cookie = new Cookie(bad_cookie_name, cookie);
				response.addCookie(c_cookie);
				//쿠키 테이블에 등록
				bookDao.insert_cookie(3, bad_cookie_name, cookie, no, item_no, member.getId());
			}
			else {
				result.put("bad", "blue");
			
				Cookie r_cookie = new Cookie("bad_count"+no+item_no, null) ;
				r_cookie.setMaxAge(0) ;
			    response.addCookie(r_cookie) ;
			    
			    //쿠키 테이블에서 삭제
			    bookDao.delete_cookie(3, member.getId());
			}
		}
		return result;
    }
	
	@RequestMapping("/photo_uploader")
    public String photo_uploader() {
    	return "board/photo_uploader";
    }
    
    private String[] typeFilter = new String[] {
			"image/png", "image/jpeg", "image/gif", "image/bmp"
	};
	
    @RequestMapping("/file_uploader")
	@ResponseBody
	public Map<String,String> file_uploader(MultipartHttpServletRequest mRequest) {
		MultipartFile file = mRequest.getFile("Filedata");
		Map<String, String> map = new HashMap<>();

		String filename = file.getOriginalFilename();	//파일 이름
		long filesize = file.getSize();	//파일 크기
		String msg = null;
		boolean flag = true;
		String filetype = null;
		
		try {
			filetype = Magic.getMagicMatch(file.getBytes()).getMimeType(); //파일 유형		
			
			if(filesize > 10*1024*1024 ){
				flag = false;
				msg = "10M이하의 이미지 파일을 선택하세요";
				map.put("msg", msg);
				map.put("flag", "false");
				return map;
			} 
			else {
				// uuid 생성(Universal Unique IDentifier, 범용 고유 식별자)
				UUID uuid = UUID.randomUUID();
				String moveFileName = uuid.toString()+"_"+filename;	// 랜덤생성+파일이름 저장
				
				Arrays.sort(typeFilter);
				if(Arrays.binarySearch(typeFilter, filetype) < 0) {
					log.info("GIF, JPEG, PNG, BMP만 업로드 가능합니다.");
				}
				
				String savePath = mRequest.getServletContext().getRealPath("/resources/image");
				File targetPath = new File(savePath);
				File copyPath = new File("E:\\sw\\image");
				
				File path = new File(savePath, "");

				if(!path.exists()) {
					log.info("실제경로가 존재하지 않습니다");
					
					//서버를 clean하면 업로드한 사진들은 없어지기 때문에 copyPath에 있는 사진들을 다시 다운
					copy(copyPath, targetPath);
				}

				File target = new File(path, moveFileName);
				file.transferTo(target);
				
				BufferedImage bi = ImageIO.read( target );
				int width = bi.getWidth();
				int height = bi.getHeight();
				log.info("폭 : " + width);
				log.info("길이 : " + height);
				
				Image image = new Image();
				image.setOriginFileName(filename);
				image.setMoveFileName(moveFileName);
				imageList.add(image);
				
				filename = moveFileName;
				
				map.put("path", savePath);
				
				map.put("filename", filename);
				map.put("flag", "true");
				map.put("width", String.valueOf(width));
				map.put("height", String.valueOf(height));

				log.info("결과 : " + flag);
				
				
			}
		} catch (MagicParseException e) {
			log.info(e.getMessage());
		} catch (MagicMatchNotFoundException e) {
			flag = false;
			msg = "GIF, JPEG, PNG, BMP만 업로드 가능합니다.";
			map.put("msg", msg);
			map.put("flag", "false");
			return map;
		} catch (MagicException e) {
			log.info(e.getMessage());
		} catch (IOException e) {
			log.info(e.getMessage());
		} 
		
		return map;
	 }

	public void copy(File origin, File target){
		
		if(origin.isFile()){
			log.info(origin + "을" + target + "으로 복사");
			try(
				FileInputStream in = new FileInputStream(origin);
				FileOutputStream out = new FileOutputStream(target);
			){
				//if(!target.exists()) target.createNewFile();
				byte[] buffer = new byte[1024];
				while(true){
					int size = in.read(buffer);
					if(size==-1) break;
					out.write(buffer, 0, size);
				}

			} catch(IOException e){
				System.out.println("에러 : " + e.getMessage());
			}

		}
		else if(origin.isDirectory()){
			//[1] target 생성
			target.mkdirs();
			
			//[2] origin의 구성요소 추출
			File[] list = origin.listFiles();	
			if(list==null) return;
			
			//[3] 하나씩 복사
			for(File file : list){
				File newTarget = new File(target, file.getName());
				copy(file, newTarget);							
			}
		
		}
	}

	public void delete(File file){		
		if(file.isFile()){
			file.delete();
			System.out.println(file.getAbsolutePath()+" 삭제");
		}
		else if(file.isDirectory()){
			File[] list = file.listFiles();
			if(list == null) return;
			for(File target : list){
				delete(target);
			}
				
			file.delete();
			System.out.println(file.getAbsolutePath()+" 삭제");
		}
	}

	@ExceptionHandler(IllegalStateException.class)
	public String exceptionHandler() {
		log.info("에러");
		return "err/err500";
	}
}
