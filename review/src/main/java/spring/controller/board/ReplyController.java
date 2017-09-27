package spring.controller.board;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import spring.model.board.BookDao;
import spring.model.board.Reply;
import spring.model.board.ReplyDao;
import spring.model.member.Member;

@Controller
@RequestMapping("/reply")
public class ReplyController {
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private ReplyDao replyDao;
	
	@Autowired
	private BookDao bookDao;
	
	@RequestMapping(value= {"/reply-insert", "reply-response-insert", "reply-delete"}, method=RequestMethod.GET)
	public String err() {
		return "err/err500";
	}
	
	@RequestMapping(value= {"/reply-insert"}, method=RequestMethod.POST)
	@ResponseBody
	public Reply insert(HttpServletRequest request, HttpSession session) {
		Reply reply = new Reply(request);
		log.info("reply : " + reply.toString());

		String ninkname = bookDao.search_nickname(reply.getWriter());
		Reply r = replyDao.reply_insert(reply);
		r.setNinkname(ninkname);
		
		return r;
	}
	
	@RequestMapping(value= {"/reply-response-insert"}, method=RequestMethod.POST)
	@ResponseBody
	public Reply response_insert(HttpServletRequest request) {
		Reply reply = new Reply();
		reply.setTitle(request.getParameter("title"));
		reply.setWriter(request.getParameter("writer"));
		reply.setDetail(request.getParameter("detail"));
		reply.setBoard_no(Integer.parseInt(request.getParameter("board_no")));
		reply.setBoard_item_no(Integer.parseInt(request.getParameter("board_item_no")));
		reply.setNo(Integer.parseInt(request.getParameter("reply_no")));
		
		log.info("reply : " + reply.toString());
		
		String ninkname = bookDao.search_nickname(reply.getWriter());
		Reply r = replyDao.reply_detail(reply.getNo());
		reply.setGno(r.getGno());
		reply.setGseq(r.getGseq());
		reply.setDepth(r.getDepth());
		log.info("gno, gseq, depth : " + r.toString());
		log.info("gno, gseq, depth : " + reply.toString());
		Reply re = replyDao.reply_insert(reply);
		re.setNinkname(ninkname);
		
		return re;
	}
	
	@RequestMapping(value= {"/reply-delete"}, method = RequestMethod.POST)
	@ResponseBody
	public boolean reply_delete(@RequestParam(required=false) int no, HttpSession session) {
		Member member =(Member)session.getAttribute("member");
		Reply reply = replyDao.reply_detail(no);
		
		boolean flag = true;
		String msg = null;
		log.info(member.getId());
		log.info(reply.getWriter());
		if(!member.getId().equals(reply.getWriter())) {
			msg = "작성자가 아닙니다";
			flag = false;
			return flag;
		}
		else {
			replyDao.reply_delete(no);
			msg = "성공적으로 삭제되었습니다.";
		}
		
		log.info("msg : " + msg);
		return flag;
	}
}
