package spring.controller.board;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.swing.tree.RowMapper;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import spring.model.board.Board;
import spring.model.board.BoardDao;
import spring.model.board.Book;
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
	public String list(HttpServletRequest req) {
//		List<Board> list = boardDao.list();
//		req.setAttribute("list", list);
		log.info("함수 실행");
		return "board/list";
	}
	
	@RequestMapping("/book-write")
	public String search_book(Model model, @RequestParam(required=false) String image, @RequestParam(required=false) String title, @RequestParam(required=false) String author, @RequestParam(required=false) String publisher, @RequestParam(required=false) String pubdate) {
		log.info("image : " + image);
    	log.info("title : " + title);
    	log.info("author : " + author);
    	log.info("publisher : " + publisher);
    	log.info("pubdate : " + pubdate);
    	
    	Book book = new Book();
    	
    	model.addAttribute("name", title);
    	
    	if(image==null)
    		image = "http://placehold.it/120x120";
    	if(title==null)
    		title = "책 제목";
    	if(author==null)
    		author = "저자";
    	if(publisher==null)
    		publisher = "출판사";
    	if(pubdate==null)
    		pubdate = "출판일";

    	book.setImage(image);
    	book.setTitle(title);
    	book.setAuthor(author);
    	book.setPublisher(publisher);
    	book.setPubdate(pubdate);
    	
    	model.addAttribute("search_book", book);
    	
    	return "board/book-write";
    }
	
	@RequestMapping(value =  {"/movie-write", "/show-write"}, method=RequestMethod.GET)
	public String write_get(HttpServletRequest request,HttpSession session) {
		session.getAttribute("nickname");
		
		String servletPath  = (String)request.getServletPath();
		if(servletPath.equals("/movie-write")) return "board/movie-write";
		else if(servletPath.equals("/show-write")) return "/show-write";
		else return "/";
	}
	
	@RequestMapping(value= {"/book-write", "/movie-write", "/show-write"}, method=RequestMethod.POST)
	public String write_post(HttpServletRequest request) {
		Book book = new Book();
		book.setImage(request.getParameter("p_image"));
		book.setTitle(request.getParameter("p_title"));
		book.setAuthor(request.getParameter("p_author"));
		book.setPublisher(request.getParameter("p_publisher"));
		book.setPubdate(request.getParameter("p_pubdate"));
		log.info("book : " + book.toString());
		
		Board b = new Board();
		b.setItem_no(Integer.parseInt(request.getParameter("item_no")));
		b.setHead(Integer.parseInt(request.getParameter("head")));
		b.setWriter(request.getParameter("writer"));
		b.setTitle(request.getParameter("title"));
		b.setDetail(request.getParameter("detail"));
		log.info("board : " + b.toString());
		
		//String notice = request.getParameter("notice");
		String notice = "false";
		notice = (notice.equals("true")) ? "true" : "false";
		
		b.setNotice(notice);
		
		String tag = request.getParameter("tag");
		//tag.replaceAll(" ", "");//공백제거
		//tag.replaceAll(",", "#");
		b.setTag(tag);
		
		int no = boardDao.search_write(book);
		log.info("no : " + no);
		boardDao.write(b, no);
		return "board/list";
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
}
