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
import spring.model.board.Board;
import spring.model.board.Book;
import spring.model.board.BookDao;
import spring.model.board.FreeDao;
import spring.model.board.Image;
import spring.model.board.Movie;
import spring.model.board.MovieDao;
import spring.model.board.Reply;
import spring.model.board.ReplyDao;
import spring.model.member.Member;
import spring.model.member.Tags;
import spring.service.NaverMovieService;

@Controller
@RequestMapping("/free")
public class FreeController {
	private Logger log = LoggerFactory.getLogger(getClass());
	private List<Image> imageList = new ArrayList<>();

	@Autowired
	private BookDao bookDao;
	
	@Autowired
	private FreeDao freeDao;
	
	@Autowired
	private ReplyDao replyDao;
	
	@RequestMapping(value= {"/free-write"}, method=RequestMethod.GET)
	public String free_write(Model model, @RequestParam(required=false) int item_no, HttpSession session){
		model.addAttribute("item_no", item_no);
		
		Member member = (Member) session.getAttribute("member");
		if(member==null)
			return "redirect:/home";
		
		return "board/free/free-write";
	}

	@RequestMapping(value= {"/free-write"}, method=RequestMethod.POST)
	public String write_post(HttpServletRequest request, HttpSession session) {	
		Board board = new Board();
		board.setItem_no(Integer.parseInt(request.getParameter("item_no")));
		board.setB_item_no(board.getItem_no());
		board.setHead(Integer.parseInt(request.getParameter("head")));
		board.setB_head(board.getHead());
		board.setWriter(request.getParameter("writer"));
		board.setTitle(request.getParameter("title"));
		board.setDetail(request.getParameter("ir1"));
		board.setSearch_title(request.getParameter("search_title"));
		board.setSearch_artist(request.getParameter("search_artist"));
		
		Member member =(Member)session.getAttribute("member");
		if(member==null)
			return "redirect:/home";
		
		String notice = "false";		
		if(board.getItem_no()==0 || board.getHead()==0)
			notice = "true";
		board.setNotice(notice);

		int no = bookDao.write(board, -1);
		board = bookDao.detail_board(no, board.getItem_no());
		
		for(Image i: imageList) {
			log.info("originfilename : " + i.getOriginFileName());
			log.info("movefilename : " + i.getMoveFileName());
			bookDao.upload_image(no, board.getItem_no(), i.getOriginFileName(), i.getMoveFileName());
		}
		
		String nickname = bookDao.search_nickname(board.getWriter());
		int point = bookDao.getpoint(nickname);
		member.setPoint(point);
		
		session.setAttribute("member", member);
		
		log.info(board.toString());
		
		//서버를 clean하면 업로드한 사진들은 없어지기 때문에 copyPath에 사진 업로드 
		//글쓰기 할 때 저장
		String savePath = request.getServletContext().getRealPath("/resources/image");
		File targetPath = new File(savePath);
		File copyPath = new File("E:\\sw\\image");		
		copy(targetPath, copyPath);
		imageList.clear();
		
		return "redirect:/free/free-detail?no="+board.getNo()+"&item_no="+board.getItem_no();
	}
	
	@RequestMapping(value= {"/free-preview"}, method=RequestMethod.GET)
	public String movieGetPreview(HttpSession session) {
		return "redirect:/home";
	}
	
	@RequestMapping(value= {"/free-preview"}, method=RequestMethod.POST)
	public String freePreview(Model model, HttpServletRequest request) {
		Board board = new Board();
		board.setItem_no(Integer.parseInt(request.getParameter("item_no")));
		board.setB_item_no(board.getItem_no());
		board.setHead(Integer.parseInt(request.getParameter("head")));
		board.setB_head(board.getHead());
		board.setWriter(request.getParameter("writer"));
		board.setTitle(request.getParameter("title"));
		board.setDetail(request.getParameter("ir1"));
		
		model.addAttribute("board", board);
		
		return "board/free/free-preview";
	}
	
	@RequestMapping("/free-detail")
	public String freeDetail(Model model, @RequestParam(required=false) int no, @RequestParam(required=false) int item_no, HttpServletRequest request, HttpServletResponse response, HttpSession session) {
		plusCount(request, no, item_no, response, session);
		
		Board board = null;
		
		board = bookDao.detail_board(no, item_no);
		board.setB_item_no(board.getItem_no());
		board.setB_head(board.getHead());
			
		Member member =(Member)session.getAttribute("member");
		if(member==null)
			return "redirect:/home";
		
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
		
		model.addAttribute("nickname", nickname);		
		model.addAttribute("board", board);
		model.addAttribute("item", board.getItem_no());
		model.addAttribute("imageName", imageName);
		model.addAttribute("listReply", listReply);
		model.addAttribute("replyNickname", replyNickname);
		
		return "board/free/free-detail";
	}
    
	@RequestMapping(value= {"/free-revise/{no}/{item_no}"}, method=RequestMethod.GET)
	public String freeDetail_re(HttpServletRequest request, HttpServletResponse response, Model model, @PathVariable int no, @PathVariable int item_no, HttpSession session) {
		Member member = (Member)session.getAttribute("member");
		if(member==null)
			return "redirect:/home";
		
		Board b = bookDao.detail_board(no, item_no);
		if(!member.getId().equals(b.getWriter()))
			return "err/err500";
		
		Board board = null;
		log.info("아이디 : " + member.getId());
		board = bookDao.detail_board(no, item_no, member.getId());	
		
		String nickname = bookDao.search_nickname(member.getId());

		model.addAttribute("nickname", nickname);		
		model.addAttribute("board", board);
		model.addAttribute("item_no", board.getItem_no());
		
		return "board/free/free-revise";
	}
	
    @RequestMapping(value= {"/free-revise/{no}/{item_no}"}, method=RequestMethod.POST)
    public String freeRevise(Model model, HttpServletRequest request, HttpServletResponse response, @PathVariable int no, @PathVariable int item_no, 
    		HttpSession session) {
	    plusCount(request, no, item_no, response, session);
		
    	Member member = (Member)session.getAttribute("member");
		
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

		board.setSearch_no(-1);
		freeDao.update_board(board, no, item_no, member.getId());
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
		
		return "redirect:/free/free-detail?no="+board.getNo()+"&item_no="+board.getItem_no();
    }
    
    @RequestMapping(value= {"/free-delete/{no}/{item_no}"}, method=RequestMethod.GET)
    public String freeDelete(Model model, @PathVariable int no, @PathVariable int item_no, HttpSession session, 
    		HttpServletRequest request, HttpServletResponse reponse) {
    	Member member = (Member)session.getAttribute("member");
    	if(member==null)
    		return "redirect:/home";
    	
    	Board board = bookDao.detail_board(no, item_no);
    	if(!member.getId().equals(board.getWriter()))
    		return "redirect:/home";
    	
    	if(member.getPower().equals("일반")) {
    		freeDao.delete_board(no, item_no, member.getId());    		
    	}else if(member.getPower().equals("관리자") || member.getPower().equals("스탭")) {
    		freeDao.delete_board(no, item_no);
    	}
		
    	bookDao.board_delete_cookie(no, item_no);
	    
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
