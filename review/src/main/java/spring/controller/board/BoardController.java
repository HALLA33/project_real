package spring.controller.board;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

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
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import net.sf.jmimemagic.Magic;
import net.sf.jmimemagic.MagicException;
import net.sf.jmimemagic.MagicMatchNotFoundException;
import net.sf.jmimemagic.MagicParseException;
import spring.model.board.Board;
import spring.model.board.BoardDao;
import spring.model.board.Book;
import spring.model.member.Member;
import spring.service.NaverBookService;

@Controller
public class BoardController {
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
    private NaverBookService service; 
	
	@Autowired
	private BoardDao boardDao;
	
	@RequestMapping("/text")
	public String test() {
		return "board/text";
	}
	
	@RequestMapping("/list")
	public String list(Model model, HttpServletRequest request, 
			@RequestParam(required=false) int item_no, @RequestParam(defaultValue="100")int headVal, @RequestParam(defaultValue="0")int alignVal) {
		String pageStr = request.getParameter("page");
		int pageNo;
		
		try{
			pageNo = Integer.parseInt(pageStr);
			if(pageNo <= 0) throw new Exception();
		} catch(Exception e){
			pageNo = 1;
		}
		
		int boardSize = 10;
		int boardCount = boardDao.count(item_no); 
		
		int start = boardSize * pageNo - boardSize + 1;
		int end = start + boardSize - 1;
		if(end > boardCount)
			end = boardCount;
		
		int blockSize = 10;
		int blockTotal = (boardCount + boardSize-1) / boardSize;
		int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
		int endBlock = startBlock + blockSize - 1;
		
		if(blockTotal<endBlock)
			endBlock = blockTotal;
		
		String url = "list?a=1";
		
		int head = (int)headVal;
		int align = (int)alignVal;
		
		System.out.println("controller head ="+head);
		System.out.println("controller align = "+align);
		
		List<Board> board = boardDao.board_list(start, end, item_no, head, align);
		
		Map<Integer, String> nickname = new HashMap<>();	
		Map<Integer, Book> book = null;
		for(Board b: board) {
			book = boardDao.book_list(b.getSearch_no());
			b.setB_item_no(b.getItem_no());
			b.setB_head(b.getHead());
			replaceDetail(b);
			nickname.put(b.getNo(), boardDao.search_nickname(b.getWriter()));
		}
		
		model.addAttribute("nickname", nickname);
		model.addAttribute("board", board);
		model.addAttribute("book", book);
		model.addAttribute("startBlock", startBlock);
		model.addAttribute("endBlock", endBlock);
		model.addAttribute("blockTotal", blockTotal);
		model.addAttribute("boardCount", boardCount);
		model.addAttribute("url", url);
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("item_no", item_no);
		model.addAttribute("head", head);
		model.addAttribute("align", align);
		
		return "board/list"; 
	}
	
	public void replaceDetail(Board board) {
		String detail = board.getDetail();

		detail = detail.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", " ").replaceAll("&nbsp;", " ");
		
		if(detail.length() >= 100){
			detail = detail.substring(0, 100) + "...";
		}

		board.setDetail(detail);
	}
	
	@RequestMapping(value= {"/book-write"}, method=RequestMethod.GET)
	public String book_write(Model model, @RequestParam(required=false) int item_no){
		model.addAttribute("item_no", item_no);
		
		return "board/book-write";
	}

	@RequestMapping(value= {"/book-write"}, method=RequestMethod.POST)
	public String write_post(HttpServletRequest request, HttpSession session) {
		Book book = new Book();
		book.setImage(request.getParameter("image"));
		book.setTitle(request.getParameter("book_title"));
		book.setAuthor(request.getParameter("author"));
		book.setPublisher(request.getParameter("publisher"));
		book.setPubdate(request.getParameter("pubdate"));
		
		Board board = new Board();
		board.setItem_no(Integer.parseInt(request.getParameter("item_no")));
		board.setB_item_no(board.getItem_no());
		board.setHead(Integer.parseInt(request.getParameter("head")));
		board.setB_head(board.getHead());
		board.setTag(request.getParameter("tag"));
		board.setWriter(request.getParameter("writer"));
		board.setTitle(request.getParameter("title"));
		board.setDetail(request.getParameter("ir1"));
		
		Member member =(Member)session.getAttribute("member");
		
		String notice = "false";		
		if(board.getItem_no()==0 || board.getHead()==0)
			notice = "true";
		board.setNotice(notice);
		
		String tag = board.getTag();
		String convert_tag = null;
		if(tag.length()>0) {
			convert_tag = "#"+ tag.trim().replace(",", "#");
		}	
		board.setTag(convert_tag);
		
		int num = 0;
		List<Book> list = boardDao.exist_book(book);
		for(Book b:list) {
			num = b.getNo();
		}

		//책이 존재하지 않으면 새로 저장
		if(num==0) 
			num = boardDao.search_write(book);

		int no = boardDao.write(board, num);
		board = boardDao.detail_board(no, board.getItem_no());
		
		String nickname = boardDao.search_nickname(board.getWriter());
		int point = boardDao.getpoint(nickname);
		member.setPoint(point);
		
		session.setAttribute("member", member);
		
		log.info(board.toString());
		
		return "redirect:/book-detail?no="+board.getNo()+"&item_no="+board.getItem_no();
	}
	
	@RequestMapping(value= {"/book-preview"}, method=RequestMethod.POST)
	public String bookPreview(Model model, HttpServletRequest request) {
		Book book = new Book();
		book.setImage(request.getParameter("image"));
		book.setTitle(request.getParameter("book_title"));
		book.setAuthor(request.getParameter("author"));
		book.setPublisher(request.getParameter("publisher"));
		book.setPubdate(request.getParameter("pubdate"));
		
		Board board = new Board();
		board.setItem_no(Integer.parseInt(request.getParameter("item_no")));
		board.setB_item_no(board.getItem_no());
		board.setHead(Integer.parseInt(request.getParameter("head")));
		board.setB_head(board.getHead());
		board.setTag(request.getParameter("tag"));
		board.setWriter(request.getParameter("writer"));
		board.setTitle(request.getParameter("title"));
		board.setDetail(request.getParameter("ir1"));
		
		String tag = board.getTag();
		String convert_tag = null;
		if(tag.length()>0) {
			convert_tag = "#"+ tag.trim().replace(",", "#");
		}	
		board.setTag(convert_tag);
		
		model.addAttribute("board", board);
		model.addAttribute("book", book);
		
		return "board/book-preview";
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
	
	@RequestMapping("/book-detail")
	public String bookDetail(Model model, @RequestParam(required=false) int no, @RequestParam(required=false) int item_no, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		plusCount(request, no, item_no, response, session);
		Map<String, String> result = image_check(request, no, item_no, response, session);
		
		Board board = null;
		Book book = null;
		
		board = boardDao.detail_board(no, item_no);
		book = boardDao.detail_book(board.getSearch_no());
		board.setB_item_no(board.getItem_no());
		board.setB_head(board.getHead());
		
		String nickname = boardDao.search_nickname(board.getWriter());

		model.addAttribute("nickname", nickname);		
		model.addAttribute("board", board);
		model.addAttribute("book", book);
		model.addAttribute("item", board.getItem_no());
		model.addAttribute("good_img", result.get("good_img"));
		model.addAttribute("bad_img", result.get("bad_img"));
		
		return "board/book-detail";
	}
	
	//키워드가 있을때도 있고 없을때도있음 
    //있을때는 가져가고 없을때는 안가져가고 
    @RequestMapping("/bookList")
    public String bookList(Model model, @RequestParam(required=false)String keyword){        
        if(keyword !=null)
        {
        	model.addAttribute("bookList", service.searchBook(keyword,10,1));
            model.addAttribute("keyword", keyword);
        }
        
        return "board/bookList";
    }
    
	@RequestMapping(value= {"/book-revise/{no}/{item_no}"}, method=RequestMethod.GET)
	public String bookDetail_re(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable int no, @PathVariable int item_no, HttpSession session) {
		Member member = (Member)session.getAttribute("member");
		Board board = null;
		Book book = null;
		log.info("아이디 : " + member.getId());
		board = boardDao.detail_board(no, item_no, member.getId());	
		book = boardDao.detail_book(board.getSearch_no());
		
		String tag = board.getTag();
		String convert_tag = null;

		if(tag!=null) {
			String[] tag_split = tag.split("#");
			for(int i=0; i<tag_split.length; i++) {
				if(i==0)
					convert_tag = tag_split[i]+",";
				else if(i==tag_split.length-1)
					convert_tag = tag_split[i];
				else
					convert_tag += tag_split[i]+",";
			}
		}
		board.setTag(convert_tag);
		
		String nickname = boardDao.search_nickname(member.getId());

		model.addAttribute("nickname", nickname);		
		model.addAttribute("board", board);
		model.addAttribute("book", book);
		model.addAttribute("item_no", board.getItem_no());
		
		
		return "board/book-revise";
	}
	
    @RequestMapping(value= {"/book-revise/{no}/{item_no}"}, method=RequestMethod.POST)
    public String bookRevise(Model model, HttpServletRequest request, HttpServletResponse response, @PathVariable int no, @PathVariable int item_no, HttpSession session) {
    	plusCount(request, no, item_no, response, session);
		Map<String, String> result = image_check(request, no, item_no, response, session);
		
    	Member member = (Member)session.getAttribute("member");
    	Book book = new Book();
		book.setImage(request.getParameter("image"));
		book.setTitle(request.getParameter("book_title"));
		book.setAuthor(request.getParameter("author"));
		book.setPublisher(request.getParameter("publisher"));
		book.setPubdate(request.getParameter("pubdate"));
		
		Board board = new Board();
		board.setItem_no(Integer.parseInt(request.getParameter("item_no")));
		board.setB_item_no(board.getItem_no());
		board.setHead(Integer.parseInt(request.getParameter("head")));
		board.setB_head(board.getHead());
		board.setWriter(request.getParameter("writer"));
		board.setTitle(request.getParameter("title"));
		board.setDetail(request.getParameter("ir1"));
		
		String notice = "false";		
		if(board.getItem_no()==0 || board.getHead()==0)
			notice = "true";
		
		board.setNotice(notice);
		
		String tag = board.getTag();
		String convert_tag = null;
		if(tag!=null) {
			convert_tag ="#" + tag.trim().replace(",", "#");
		}
		board.setTag(convert_tag);
		
		int num = 0;
		List<Book> list = boardDao.exist_book(book);
		for(Book b:list) {
			num = b.getNo();
		}
		
		//책이 존재하지 않으면 새로 저장
		if(num==0) 
			num = boardDao.search_write(book);
			
		board.setSearch_no(num);
		boardDao.update_board(board, book, no, item_no, member.getId());
		board = boardDao.detail_board(no, board.getItem_no());
		
		String nickname = boardDao.search_nickname(board.getWriter());
		
		model.addAttribute("nickname", nickname);
		model.addAttribute("book", book);
		model.addAttribute("board", board);
		model.addAttribute("good_img", result.get("good_img"));
		model.addAttribute("bad_img", result.get("bad_img"));
		log.info("수정 후 board : " + board.toString());
		
		if(item_no!=0)
			model.addAttribute("item", item_no);
		else
			model.addAttribute("item", board.getItem_no());
		
		return "board/book-detail";
    }
    
    @RequestMapping(value= {"/book-delete/{no}/{item_no}"}, method=RequestMethod.GET)
    public String bookDelete(Model model, @PathVariable int no, @PathVariable int item_no, HttpSession session, HttpServletRequest request, HttpServletResponse reponse) {
    	Member member = (Member)session.getAttribute("member");

    	if(member.getPower().equals("일반")) {
    		boardDao.delete_board(no, item_no, member.getId());    		
    	}else if(member.getPower().equals("관리자") || member.getPower().equals("스탭")) {
    		boardDao.delete_board(no, item_no);
    	}
		
    	boardDao.board_delete_cookie(no, item_no);
    	
    	return "redirect:/list?item_no="+item_no;
    }
    
    @RequestMapping(value =  {"/movie-write", "/show-write"}, method=RequestMethod.GET)
	public String write_get(HttpServletRequest request,HttpSession session) {
		session.getAttribute("nickname");
		
		String servletPath  = (String)request.getServletPath();
		if(servletPath.equals("/movie-write")) return "board/movie-write";
		else if(servletPath.equals("/show-write")) return "/show-write";
		else return "/";
	}
    
    @RequestMapping(value= {"/goodCount"}, method=RequestMethod.POST)
    @ResponseBody
    public Map<String, String> goodCount(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
    	int no = Integer.parseInt(request.getParameter("no"));
    	int item_no = Integer.parseInt(request.getParameter("item_no"));
    	Map<String, String> result = good_bad(1, request, no, item_no, response, session);
    	Map<String, String> map = new HashMap<>();
    	String good_img = null;
		
		if(result.get("good").equals("black")) {
			good_img = "img/after_goods.png";
			boardDao.plus_minus_Count(1, no, item_no);
		}
		else {
			good_img = "img/before_goods.png";
			boardDao.plus_minus_Count(2, no, item_no);
		}

		Board board = boardDao.detail_board(no, item_no);
		//board.getGood()
		
		map.put("good_img", good_img);
		map.put("good_number", String.valueOf(board.getGood()));
		
		return map;
    }
    
    @RequestMapping(value= {"/badCount"}, method=RequestMethod.POST)
    @ResponseBody
    public Map<String, String> badCount(HttpServletRequest request, HttpServletResponse response, HttpSession session) {
    	int no = Integer.parseInt(request.getParameter("no"));
    	int item_no = Integer.parseInt(request.getParameter("item_no"));
    	Map<String, String> result = good_bad(2, request, no, item_no, response, session);
    	Map<String, String> map = new HashMap<>();
		String bad_img = null;
		
		if(result.get("bad").equals("black")) {
			bad_img = "img/after_bads.png";
			boardDao.plus_minus_Count(3, no, item_no);
		}
		else {
			bad_img = "img/before_bads.png";
			boardDao.plus_minus_Count(4, no, item_no);
		}

		Board board = boardDao.detail_board(no, item_no);
		
		map.put("bad_img", bad_img);
		map.put("bad_number", String.valueOf(board.getBad()));
		
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
			boardDao.plus_minus_Count(0, no, item_no);
			//쿠키 테이블에 추가
			boardDao.insert_cookie(1, cookie_name, new_cookie, no, item_no, member.getId());
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
				boardDao.insert_cookie(2, good_cookie_name, cookie, no, item_no, member.getId());
			}
			else {
				result.put("good", "blue");
				
				Cookie r_cookie = new Cookie("good_count"+no+item_no, null) ;
				r_cookie.setMaxAge(0) ;
			    response.addCookie(r_cookie) ;
			    
			    //쿠키 테이블에서 삭제
			    boardDao.delete_cookie(2, member.getId());
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
				boardDao.insert_cookie(3, bad_cookie_name, cookie, no, item_no, member.getId());
			}
			else {
				result.put("bad", "blue");
			
				Cookie r_cookie = new Cookie("bad_count"+no+item_no, null) ;
				r_cookie.setMaxAge(0) ;
			    response.addCookie(r_cookie) ;
			    
			    //쿠키 테이블에서 삭제
			    boardDao.delete_cookie(3, member.getId());
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
				
				//서버를 clean하면 업로드한 사진들은 없어지기 때문에 copyPath에 사진 업로드
				copy(targetPath, copyPath);
				
				filename = moveFileName;
				
				map.put("path", savePath);
				
				map.put("filename", filename);
				map.put("flag", "true");
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


}
