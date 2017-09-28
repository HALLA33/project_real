package spring.controller.member;

import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import spring.model.board.Board;
import spring.model.board.Book;
import spring.model.board.BookDao;
import spring.model.board.Movie;
import spring.model.board.MovieDao;
import spring.model.board.Reply;
import spring.model.member.Attendance;
import spring.model.member.Cookies;
import spring.model.member.Encryption;
import spring.model.member.Generator;
import spring.model.member.Member;
import spring.model.member.MemberDao;
import spring.model.member.Tags;

@Controller
public class MemberController {

	@Autowired
	private MemberDao memberDao;

	@Autowired
	private BookDao bookDao;

	@Autowired
	private MovieDao movieDao;

	private Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	private Generator generator;

	@Autowired
	private Encryption encryption;

	// 이용약관 뷰
	@RequestMapping("/tos")
	public String tosview() {
		System.out.println("실행됨");

		return "member/tos";
	}

	// 회원가입 뷰
	@RequestMapping("/sign")
	public String signview(HttpSession session) throws Exception {

		Member member = (Member) session.getAttribute("member");

		if (member != null) {
			throw new Exception("잘못된 접근");
		}

		return "member/sign";
	}

	// 회원가입 처리
	@RequestMapping(value = "/sign", method = RequestMethod.POST)
	public String sign(@ModelAttribute Member member, @RequestParam String rpw, Model model) throws Exception {
		log.info("sign() 실행");

		String pw = member.getPw();
		log.info("pw : " + pw);

		String encryptpw = encryption.encryptPw(pw);
		log.info("encryppw : " + encryptpw);
		
		// 메인게시글
		mainData(model);

		member.setPw(encryptpw);

		if (!pw.equals(rpw)) {
			throw new Exception("비밀번호와 확인비밀번호 불일치");
		} else if (pw.equals(rpw)) {
			boolean result = memberDao.sign(member);

			if (result) {
				log.info("잘 시작됨");
				model.addAttribute("err", new String("가입을 축하드립니다"));
				return "home";
			} else {
				throw new Exception("비정상적인 회원가입 발생");
			}
		}
		return null;

	}

	// 관리자 전용 멤버리스트
	@RequestMapping("/member")
	public String memberlist(HttpServletRequest request, HttpSession session,
			@RequestParam(value = "smode", required = false) String smode,
			@RequestParam(value = "key", required = false) String key,
			@RequestParam(value = "page", required = false) String page) throws Exception {

		Member member = (Member) session.getAttribute("member");

		String power = member.getPower();

		log.info(power);
		if (power.equals("관리자")) {
			int pageno;
			try {
				pageno = Integer.parseInt(page);
				if (pageno <= 0)
					throw new Exception();
			} catch (Exception e) {
				pageno = 1;
			}

			int membersize = 10;

			int membercount = memberDao.count(smode, key);

			int start = membersize * pageno - membersize + 1;
			int end = start + membersize - 1;
			if (end > membersize)
				end = membercount;

			List<Member> list = memberDao.memberlist(smode, key, start, end);

			int blockSize = 10;
			int blockTotal = (membercount + membersize - 1) / membersize;
			int startBlock = (pageno - 1) / blockSize * blockSize + 1;
			int endBlock = startBlock + blockSize - 1;
			if (endBlock > blockTotal)
				endBlock = blockTotal;

			String url = "member?";
			if (smode != null && key != null)
				url += "smode=" + smode + "&key=" + key;

			request.setAttribute("list", list);
			request.setAttribute("url", url);
			request.setAttribute("startBlock", startBlock);
			request.setAttribute("endBlock", endBlock);
			request.setAttribute("pageNo", pageno);
			request.setAttribute("blockTotal", blockTotal);
			request.setAttribute("key", key);
			request.setAttribute("type", smode);

			return "member/member";
		} else {
			throw new Exception("권한 없음");
		}
	}

	// 로그인 처리
	@RequestMapping(value = { "/login", "/movie/login", "/etc/login", "/free/login" }, method = RequestMethod.POST)
	public String login(HttpServletRequest request,
			@RequestParam(value = "remember", required = false, defaultValue = "off") String remember,
			HttpServletResponse response, @RequestParam String id, @RequestParam String pw, HttpSession session,
			Model model) throws NoSuchAlgorithmException {

		String encryptpw = encryption.encryptPw(pw);

		log.info("로그인 실행");
		Member member = memberDao.login(id, encryptpw);

		// 로그인 실패처리
		if (member.getId() == null) {
			String err = "아이디 혹은 비밀번호가 잘못되었습니다";
			request.setAttribute("err", err);
			mainData(model);
			return "home";
		}

		if (remember.equals("on")) {
			Cookie cookies = new Cookie("autologin", encryptpw + id);
			cookies.setMaxAge(60 * 60 * 24 * 7);
			response.addCookie(cookies);
		} else {

		}

		// 쿠키테이블 검사하여 있으면 생성
		cookie(id, response);

		session.setAttribute("member", member);

		return "redirect:/";
	}

	public void cookie(String id, HttpServletResponse response) {
		List<Cookies> cookie = memberDao.check_cookie(id);

		for (Cookies c : cookie) {
			Cookie cookies = new Cookie(c.getCookie_name(), c.getCookie_value());
			response.addCookie(cookies);
		}
	}

	// 로그아웃 처리
	@RequestMapping("/logout")
	public String logout(HttpSession session, HttpServletResponse response, HttpServletRequest request) {

		session.invalidate();

		Cookie c = new Cookie("autologin", null);
		c.setMaxAge(0);
		response.addCookie(c);

		check_cookie(request, response, "read_count");
		check_cookie(request, response, "good_count");
		check_cookie(request, response, "bad_count");

		return "redirect:/";
	}

	public void check_cookie(HttpServletRequest request, HttpServletResponse response, String cookie_name) {
		Cookie cookies[] = request.getCookies();

		// 저장된 쿠키 불러오기
		if (request.getCookies() != null) {
			for (int i = 0; i < cookies.length; i++) {
				Cookie obj = cookies[i];
				if (obj.getName().startsWith(cookie_name)) {
					obj.setMaxAge(0);
					response.addCookie(obj);
				}
			}
		}
	}

	// 아이디 찾기 뷰
	@RequestMapping("/forget")
	public String findidview() {

		return "member/forget";
	}

	// 아이디 찾기 처리
	@RequestMapping(value = "/forget", method = RequestMethod.POST)
	public String findid(@RequestParam String name, String email, HttpServletRequest request) throws Exception {

		String id = memberDao.findid(name, email);

		request.setAttribute("id", id);

		return "member/forget_suc";
	}

	// 비밀번호 찾기 뷰
	@RequestMapping("/forgetpw")
	public String findpw() {

		return "member/forgetpw";

	}

	// 비밀번호 변경페이지 전송
	@RequestMapping(value = "/forgetpw", method = RequestMethod.POST)
	public String sendrpw(@RequestParam String email, @RequestParam String name, @RequestParam String id,
			HttpSession session, Model model) {

		log.info("인증할 이메일 : {}", email);

		String token = generator.createString(50);
		memberDao.sendemail(name, id, email, token);
		session.setAttribute("token", token);
		session.setAttribute("email", email);
		session.setAttribute("id", id);
		model.addAttribute("email", email);

		return "member/result";

	}

	@RequestMapping(value = "/repwset", method = RequestMethod.GET)
	public String repwsetview(@RequestParam String token, HttpSession session, HttpServletResponse response)
			throws Exception {

		String sessionToken = (String) session.getAttribute("token");
		session.removeAttribute("token");

		if (!token.equals(sessionToken))
			throw new Exception("토큰이 일치하지 않습니다");

		return "member/repwset";
	}

	@RequestMapping(value = "/repwset", method = RequestMethod.POST)
	public String repwset(@RequestParam String pw, @RequestParam String rpw, HttpSession session) throws Exception {

		String sessionId = (String) session.getAttribute("id");
		String sessionEmail = (String) session.getAttribute("email");

		session.invalidate();

		String encryptpw = encryption.encryptPw(pw);

		if (pw.equals(rpw)) {

			boolean result = memberDao.repwset(sessionEmail, sessionId, encryptpw);

			if (result) {
				log.info("비밀번호 변경 완료");
				return "redirect:/";
			} else {

				throw new Exception("비정상적 비밀번호 변경 감지");

			}

		} else {
			throw new Exception("비밀번호 미일치");
		}
	}

	// 나의 정보수정 뷰
	@RequestMapping("/myedit")
	public String editview() {

		return "member/myedit";
	}

	// 나의 정보창에서 비밀번호를 변경
	@RequestMapping(value = "/myedit", method = RequestMethod.POST)
	public String myedit(@RequestParam String id, @RequestParam String pw, @RequestParam String rpw,
			@RequestParam String nickname, @RequestParam String phone, HttpSession session) throws Exception {

		Member member = (Member) session.getAttribute("member");
		if (pw.equals("")) {
			pw = member.getPw();
			rpw = member.getPw();
		} else {
			pw = encryption.encryptPw(pw);
			rpw = encryption.encryptPw(rpw);
		}
		log.info(pw);
		log.info(rpw);

		if (!pw.equals(rpw)) {
			throw new Exception("비밀번호 다름 발생");
		} else {
			member.setNickname(nickname);
			memberDao.infoedit(id, rpw, nickname, phone);

			log.info(member.getNickname());

			session.setAttribute("member", member);

			return "redirect:/";

		}
	}

	// 비밀번호 체크 뷰
	@RequestMapping("/check")
	public String checkview() {

		return "member/check";
	}

	// 비밀번호 체크
	@RequestMapping(value = "/check", method = RequestMethod.POST)
	public String check(@RequestParam String mode, @RequestParam String id, @RequestParam String pw,
			HttpSession session) throws Exception {

		String encryptpw = encryption.encryptPw(pw);

		boolean result = memberDao.check(id, encryptpw);

		if (result) {

			if (mode.equals("edit")) {
				return "redirect:myedit";
			} else if (mode.equals("unsign")) {
				memberDao.unsigned(id, encryptpw);
				session.invalidate();
				return "redirect:/";
			} else {
				throw new Exception("없는 모드");
			}

		} else {
			throw new Exception("없는 아이디나 비밀번호");
		}

	}

	// 아이디 중복확인
	@RequestMapping(value = "/idcheck", method = RequestMethod.POST)
	public String idcheck(@RequestParam String id) throws Exception {

		log.info(id);

		boolean result = memberDao.idcheck(id);

		if (result) {
			return "member/success";
		} else {
			throw new Exception("아이디가있음");
		}
	}

	// 닉네임 중복확인
	@RequestMapping(value = "/nickcheck", method = RequestMethod.POST)
	public String nickcheck(@RequestParam String nick) throws Exception {

		log.info(nick);

		boolean result = memberDao.nickcheck(nick);

		if (result) {
			return "member/success";
		} else {
			throw new Exception("아이디가있음");
		}
	}

	// 나의 정보 수정(닉네임체크)
	@RequestMapping(value = "/nickcheck2", method = RequestMethod.POST)
	public String nickcheck2(@RequestParam String nick, @RequestParam String id) throws Exception {

		boolean result = memberDao.nickcheck(id, nick);
		boolean result2 = memberDao.nickcheck(nick);

		System.out.println(result);
		System.out.println(result2);

		if (!result || result2) {
			return "member/success";
		} else {
			throw new Exception("아이디가있음");
		}
	}

	// 이메일
	@RequestMapping(value = "/emailcheck", method = RequestMethod.POST)
	public String emailcheck(@RequestParam String email) throws Exception {

		log.info(email);

		boolean result = memberDao.emailcheck(email);

		if (result) {
			return "member/success";
		} else {
			throw new Exception("아이디가있음");
		}
	}

	public void replaceDetail(Board board) {
		String detail = board.getDetail();

		detail = detail.replaceAll("<(/)?([a-zA-Z]*)(\\s[a-zA-Z]*=[^>]*)?(\\s)*(/)?>", " ").replaceAll("&nbsp;", " ");

		if (detail.length() >= 100) {
			detail = detail.substring(0, 100) + "...";
		}

		board.setDetail(detail);
	}

	// home 게시글 보이기
	public void mainData(Model model) {
		List<Board> home_notice = bookDao.home_notice(0);
		List<Board> home_book_inner = bookDao.home_book_inner(1);
		List<Board> home_book_outter = bookDao.home_book_outter(2);
		List<Board> home_movie_inner = bookDao.home_movie_inner(3);
		List<Board> home_movie_outter = bookDao.home_movie_outter(4);

		Map<Integer, String> nickname = new HashMap<>();
		Map<Integer, Book> book = null;
		Map<Integer, Movie> movie = null;
		for (Board b : home_notice) {
			book = bookDao.book_list(b.getSearch_no());
			movie = movieDao.movie_list(b.getSearch_no());
			b.setB_item_no(b.getItem_no());
			b.setB_head(b.getHead());
			replaceDetail(b);
			nickname.put(b.getNo(), bookDao.search_nickname(b.getWriter()));
		}
		for (Board b : home_book_inner) {
			book = bookDao.book_list(b.getSearch_no());
			movie = movieDao.movie_list(b.getSearch_no());
			b.setB_item_no(b.getItem_no());
			b.setB_head(b.getHead());
			replaceDetail(b);
			nickname.put(b.getNo(), bookDao.search_nickname(b.getWriter()));
		}
		for (Board b : home_book_outter) {
			book = bookDao.book_list(b.getSearch_no());
			movie = movieDao.movie_list(b.getSearch_no());
			b.setB_item_no(b.getItem_no());
			b.setB_head(b.getHead());
			replaceDetail(b);
			nickname.put(b.getNo(), bookDao.search_nickname(b.getWriter()));
		}
		for (Board b : home_movie_inner) {
			book = bookDao.book_list(b.getSearch_no());
			movie = movieDao.movie_list(b.getSearch_no());
			b.setB_item_no(b.getItem_no());
			b.setB_head(b.getHead());
			replaceDetail(b);
			nickname.put(b.getNo(), bookDao.search_nickname(b.getWriter()));
		}
		for (Board b : home_movie_outter) {
			book = bookDao.book_list(b.getSearch_no());
			movie = movieDao.movie_list(b.getSearch_no());
			b.setB_item_no(b.getItem_no());
			b.setB_head(b.getHead());
			replaceDetail(b);
			nickname.put(b.getNo(), bookDao.search_nickname(b.getWriter()));
		}

		// 테스트용
		// System.out.println("home_notice = " + home_notice.isEmpty());
		// System.out.println("home_notice = " + home_notice.toString());
		// System.out.println("home_book_inner = " + home_book_inner.isEmpty());
		// System.out.println("home_book_inner = " + home_book_inner.toString());
		// System.out.println("home_book_outter = " + home_book_outter.isEmpty());
		// System.out.println("home_book_outter = " + home_book_outter.toString());
		// System.out.println("home_movie_inner = " + home_movie_inner.isEmpty());
		// System.out.println("home_movie_inner = " + home_movie_inner.toString());
		// System.out.println("home_movie_outter = " + home_movie_outter.isEmpty());
		// System.out.println("home_movie_outter = " + home_movie_outter.toString());

		model.addAttribute("home_notice", home_notice);
		model.addAttribute("home_book_inner", home_book_inner);
		model.addAttribute("home_book_outter", home_book_outter);
		model.addAttribute("home_movie_inner", home_movie_inner);
		model.addAttribute("home_movie_outter", home_movie_outter);
	}

	// 자동로그인, 포인트 랭킹, 메인게시글
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String test(HttpServletRequest request, HttpSession session, HttpServletResponse response, Model model) {

		// 메인게시글
		mainData(model);

		List<Member> list = memberDao.memberRank();

		for (int i = 0; i < list.size(); i++) {
			list.get(i).setNo(i + 1);// 임시 리스트에 no를 번호 대신에 랭킹 순위로 넣음
		}

		List<Tags> taglist = memberDao.taglist();

		session.setAttribute("tags", taglist);
		session.setAttribute("rankList", list);

		Cookie[] cookies = request.getCookies();

		String cookieval = null;

		if (cookies != null) {

			for (Cookie c : cookies) {
				if (c.getName().equals("autologin")) {
					cookieval = c.getValue();
					break;
				}
			}
			if (cookieval != null) {
				String pw = cookieval.substring(0, 64);
				String id = cookieval.substring(64);

				log.info(pw);
				log.info(id);

				boolean result = memberDao.autologin(id, pw);

				if (result) {
					Member member = memberDao.login(id, pw);

					session.setAttribute("member", member);
				} else {
					Cookie c = new Cookie("autologin", null);
					c.setMaxAge(0);
					response.addCookie(c);
				}
			}
		}

		return "home";
	}

	// 내가 쓴 글
	@RequestMapping(value= {"/mycomment", "/movie/mycomment", "/etc/mycomment", "/free/mycomment"})
	public String mycomment(HttpSession session, HttpServletRequest request,
			@RequestParam(value = "mode", defaultValue = "new", required = false) String mode) {

		Member member = (Member) session.getAttribute("member");

		String id = member.getId();

		List<Reply> list = memberDao.mycomment(id, mode);

		request.setAttribute("m_co", list);

		return "member/mycomment";
	}

	@RequestMapping(value = {"/myboard", "/movie/myboard", "/etc/myboard", "/free/myboard"})
	public String myboard(HttpSession session, HttpServletRequest request) {

		Member member = (Member) session.getAttribute("member");
		String id = member.getId();

		List<Board> list = memberDao.mywrite(id);

		request.setAttribute("lists", list);

		return "member/myboard";
	}

	// 회원등급 변경
	@RequestMapping(value = "/chengepower", method = RequestMethod.POST)
	public String ChengePower(@RequestParam String[] userid, @RequestParam String power) throws Exception {

		switch (power) {

		case "normal":
			power = "일반";
			break;
		case "staff":
			power = "스탭";
			break;

		}

		for (int i = 0; i < userid.length; i++) {

			boolean result = memberDao.chengepower(power, userid[i]);

			if (!result) {
				throw new Exception("비정상적 권한 변경 발생");
			}
		}

		return "member/success";
	}

	// 강제 회원탈퇴
	@RequestMapping(value = "unsign", method = RequestMethod.POST)
	public String manageunsign(@RequestParam String[] userid) {

		for (int i = 0; i < userid.length; i++) {

			memberDao.manageunsign(userid[i]);

		}

		return "member/success";
	}

	// 내가 쓴글 삭제
	@RequestMapping(value = "mydelete", method = RequestMethod.POST)
	public String mydelete(@RequestParam String[] itemno, @RequestParam String[] writeno, HttpSession session) {

		Member member = (Member) session.getAttribute("member");
		String id = member.getId();

		for (int a = 0; a < itemno.length; a++) {

			String itemnum = itemno[a];

			for (int i = 0; i < writeno.length; i++) {

				memberDao.mydelete(itemnum, writeno[i], id);

			}

		}
		return "member/success";
	}

	// 내가 쓴댓글 삭제
	@RequestMapping(value = "mycodelete", method = RequestMethod.POST)
	public String mycodelete(@RequestParam String[] writeno, HttpSession session) {

		Member member = (Member) session.getAttribute("member");
		String id = member.getId();

		for (int i = 0; i < writeno.length; i++) {

			memberDao.mycodelete(writeno[i], id);
		}
		return "member/success";
	}

	@RequestMapping("/attend")
	public String Login_attendanceview(HttpServletRequest request, HttpSession session,
			@RequestParam(value = "page", required = false) String page) {

		if (session.getAttribute("member") != null) {
			Member member = (Member) session.getAttribute("member");

			String nickname = member.getNickname();

			member = memberDao.getmember(nickname);
			
			List<Member> list = memberDao.memberRank();

			for (int i = 0; i < list.size(); i++) {
				list.get(i).setNo(i + 1);// 임시 리스트에 no를 번호 대신에 랭킹 순위로 넣음
			}

			List<Tags> taglist = memberDao.taglist();
			
			
			session.setAttribute("rankList", list); // 실시간 상태 갱신
			session.setAttribute("member", member); // 실시간 상태 갱신
		}

		int pageno;
		try {
			pageno = Integer.parseInt(page);
			if (pageno <= 0)
				throw new Exception();
		} catch (Exception e) {
			pageno = 1;
		}

		int attendsize = 10;

		int attendcount = memberDao.attendrcount();

		int start = attendsize * pageno - attendsize + 1;
		int end = start + attendsize - 1;
		if (end > attendsize)
			end = attendcount;

		List<Attendance> list = memberDao.attendlist(start, end);

		int blockSize = 10;
		int blockTotal = (attendcount + attendsize - 1) / attendsize;
		int startBlock = (pageno - 1) / blockSize * blockSize + 1;
		int endBlock = startBlock + blockSize - 1;
		if (endBlock > blockTotal)
			endBlock = blockTotal;

		String url = "attend?";

		request.setAttribute("at_list", list);
		request.setAttribute("url", url);
		request.setAttribute("startBlock", startBlock);
		request.setAttribute("endBlock", endBlock);
		request.setAttribute("pageNo", pageno);
		request.setAttribute("blockTotal", blockTotal);

		return "member/attend";
	}

	@RequestMapping(value = "login_attendance", method = RequestMethod.POST)
	public String Login_attendance(HttpSession session, @RequestParam String point, @RequestParam String nick,
			@RequestParam String greetings, HttpServletRequest request) {

		int point2 = Integer.parseInt(point);

		boolean result = memberDao.insertattend(greetings, nick, point2);

		Member member = memberDao.getmember(nick);

		session.setAttribute("member", member); // 우측 상태창 실시간 포인트 갱신

		return "member/attend";
	}

	@RequestMapping("/myinfo")
	public String myinfo(HttpSession session) {

		if (session.getAttribute("member") == null) {
			try {
				throw new Exception("로그인하셈");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		} else {

			Member member = (Member) session.getAttribute("member");

			String nickname = member.getNickname();

			member = memberDao.getmember(nickname);

			session.setAttribute("member", member); // 실시간 갱신ㄴ

		}

		return "member/myinfo";
	}

	@RequestMapping("/userinfo")
	public String userinfo(@RequestParam String id, Model model) {

		log.info("id : " + id);

		List<Member> list = memberDao.userinfo(id);

		model.addAttribute("u_list", list);

		return "member/userinfo";

	}

}
