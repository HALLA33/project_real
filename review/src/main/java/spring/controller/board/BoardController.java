package spring.controller.board;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import spring.model.board.Board;
import spring.model.board.BoardDao;

@Controller
public class BoardController {
	private Logger log = LoggerFactory.getLogger(getClass());
	
	private BoardDao boardDao;
	public void setBoardDao(BoardDao boardDao) {
		this.boardDao = boardDao;
	}
	
	@RequestMapping("/text")
	public String test() {
		return "board/text";
	}
	
	@RequestMapping("/list")
	public String list(HttpServletRequest req) {
//		List<Board> list = boardDao.list();
//		req.setAttribute("list", list);
		log.info("함수 실행");
		return "board/list";
	}
	
	@RequestMapping(value =  {"/book-write", "/movie-write", "/show-write"}, method=RequestMethod.GET)
	public String write_get(HttpServletRequest request, HttpSession session) {
		session.getAttribute("nickname");
		
		String servletPath  = (String)request.getServletPath();
		if(servletPath.equals("/book-write")) return "board/book-write";
		else if(servletPath.equals("/movie-write")) return "board/movie-write";
		else if(servletPath.equals("/show-write")) return "/show-write";
		else return "/";
	}
	
	@RequestMapping(value= {"/book-write", "/movie-write", "/show-write"}, method=RequestMethod.POST)
	public String write_post(HttpServletRequest request) {
		Board b = new Board();
		b.setItem_no(Integer.parseInt(request.getParameter("item_no")));
		b.setHead(request.getParameter("head"));
		b.setWriter(request.getParameter("writer"));
		b.setTitle(request.getParameter("title"));
		b.setDetail(request.getParameter("detail"));
		
		String notice = request.getParameter("notice");
		notice = (notice.equals("true")) ? "true" : "false";
		
		b.setNotice(notice);
		
		String tag = request.getParameter("tag");
		tag.replaceAll(" ", "");//공백제거
		tag.replaceAll(",", "#");
		b.setTag(tag);
		
		boardDao.write(b);
		return "board/list";
	}
}
