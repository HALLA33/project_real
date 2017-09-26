package spring.controller.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import spring.model.board.Board;
import spring.model.board.Book;
import spring.model.board.BookDao;
import spring.model.board.Movie;
import spring.model.board.MovieDao;

@Controller
public class DefaultController {
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private BookDao bookDao;
	
	@Autowired
	private MovieDao movieDao;
	
	@RequestMapping("/recommend")
	public String recommend(Model model, String emo, String wea) {
		
		System.out.println("컨트롤러 emo="+emo+", wea="+wea);
		
		List<Board> recomTwo = bookDao.recomTwo(emo, wea);//둘 다 일치
		List<Board> recomEmo = bookDao.recomEmo(emo, wea);//감정 일치
		List<Board> recomWea = bookDao.recomWea(emo, wea);//날씨 일치
		
		Map<Integer, String> nickname = new HashMap<>();	
		Map<Integer, Book> book = null;
		Map<Integer, Movie> movie = null;
		for(Board b: recomTwo) {
			book = bookDao.book_list(b.getSearch_no());
			movie = movieDao.movie_list(b.getSearch_no());
			b.setB_item_no(b.getItem_no());
			b.setB_head(b.getHead());
			replaceDetail(b);
			nickname.put(b.getNo(), bookDao.search_nickname(b.getWriter()));
		}
		
		for(Board b: recomEmo) {
			book = bookDao.book_list(b.getSearch_no());
			movie = movieDao.movie_list(b.getSearch_no());
			b.setB_item_no(b.getItem_no());
			b.setB_head(b.getHead());
			replaceDetail(b);
			nickname.put(b.getNo(), bookDao.search_nickname(b.getWriter()));
		}
		
		for(Board b: recomWea) {
			book = bookDao.book_list(b.getSearch_no());
			movie = movieDao.movie_list(b.getSearch_no());
			b.setB_item_no(b.getItem_no());
			b.setB_head(b.getHead());
			replaceDetail(b);
			nickname.put(b.getNo(), bookDao.search_nickname(b.getWriter()));
		}
		
		model.addAttribute("recomTwo", recomTwo);
		model.addAttribute("recomEmo", recomEmo);
		model.addAttribute("recomWea", recomWea);
		model.addAttribute("nickname", nickname);
		model.addAttribute("book", book);
		model.addAttribute("movie", movie);
		
		return "board/recommend";
	}
	
	public void replaceDetail(Board board) {
		String detail = board.getDetail();

		detail = detail.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", " ").replaceAll("&nbsp;", " ");
		
		if(detail.length() >= 100){
			detail = detail.substring(0, 100) + "...";
		}

		board.setDetail(detail);
	}
	
	@RequestMapping("/home")
	public String home() {
		return "redirect:/";
	}

}
