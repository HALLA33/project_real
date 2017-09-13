package spring.controller.member;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.request;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.forwardedUrl;

import java.util.List;

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

import oracle.net.aso.s;
import spring.model.member.Generator;
import spring.model.member.Member;
import spring.model.member.MemberDao;

@Controller
public class MemberController {
	
	@Autowired
	private MemberDao memberDao;
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private Generator generator;
	
	//이용약관 뷰
	@RequestMapping("/tos")
	public String tosview(){
		System.out.println("실행됨");
		
		return "member/tos";				
	}
	
	//회원가입 뷰
	@RequestMapping("/sign")
	public String signview(HttpSession session) throws Exception {
		
		Member member = (Member)session.getAttribute("member");
		
		if(member != null) {
			throw new Exception("잘못된 접근");
		}
		
		return "member/sign";
	}
	
	//회원가입 처리
	@RequestMapping(value = "/sign", method = RequestMethod.POST)
	public String sign(
			@ModelAttribute Member member, @RequestParam String rpw) throws Exception {
		log.info("sign() 실행");
		
		if(!member.getPw().equals(rpw)) {
			throw new Exception("비밀번호와 확인비밀번호 불일치");
		}else if(member.getPw().equals(rpw)) {
			boolean result = memberDao.sign(member);
			
			if(result) {
				log.info("잘 시작됨");
				return "redirect:/";
			}else {
				throw new Exception("비정상적인 회원가입 발생");
			}
		}
		return null;
		
	}
	
	//관리자 전용 멤버리스트
	@RequestMapping("/member")
	public String memberlist(HttpServletRequest request, HttpSession session,
													@RequestParam(value="smode", required=false) String smode,
													@RequestParam(value="key", required=false) String key, 
													@RequestParam(value="page", required=false) String page) throws Exception {
		
		Member member = (Member)session.getAttribute("member");
		
		String power = member.getPower();
		
		log.info(power);
		if(power.equals("관리자")) {
			int pageno;
			try {
				pageno = Integer.parseInt(page);
				if(pageno <= 0) throw new Exception();				
			}catch(Exception e) {
				pageno = 1;
			}
			
			int membersize = 10;
			
			int membercount = memberDao.count(smode, key);
			
			int start = membersize * pageno - membersize + 1;
			int end = start + membersize - 1;
			if(end > membersize) end = membercount;
			
			List<Member> list = memberDao.memberlist(smode, key, start, end);
			
			int blockSize = 10;
		 	int blockTotal = (membercount + membersize - 1) / membersize;
		 	int startBlock = (pageno - 1) / blockSize * blockSize + 1;
		 	int endBlock = startBlock + blockSize - 1;
		 	if(endBlock > blockTotal) endBlock = blockTotal;
		 	
		 	String url = "member?";
		 	if(smode != null && key != null)
		 		url += "type="+smode+"&key="+key;
		 	
		 	request.setAttribute("list", list);
		 	request.setAttribute("url", url);
		 	request.setAttribute("startBlock", startBlock);
		 	request.setAttribute("endBlock", endBlock);
		 	request.setAttribute("pageNo", pageno);
		 	request.setAttribute("blockTotal", blockTotal);
		 	request.setAttribute("key", key);
		 	request.setAttribute("type", smode);
			
			return "member/member";
		}else {
			throw new  Exception("권한 없음");
		}
	}
	//로그인 처리
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public String login(HttpServletRequest request, 
			@RequestParam(value="remember", required=false, defaultValue = "off") String remember,
			HttpServletResponse response,@RequestParam String id,
			@RequestParam String pw, HttpSession session
			) {
		
		log.info("로그인 실행");
		Member member = memberDao.login(id, pw);
		
		if(remember.equals("on")) {
			Cookie cookies = new Cookie("autologin", member.getId());
			cookies.setMaxAge(60*60*24*7);
			response.addCookie(cookies);
		}else {
			
		}
		
		session.setAttribute("member", member);

		return "redirect:/";
	}
	//로그아웃 처리
	@RequestMapping("/logout")
	public String logout(HttpSession session, HttpServletResponse response) {
		
		session.invalidate();
		
		Cookie c = new Cookie("autologin", null);
		c.setMaxAge(0);
		response.addCookie(c);
		
		return "redirect:/";
	}
	//아이디 찾기 뷰
	@RequestMapping("/forget")
	public String findidview() {
		
		
		return "member/forget";
	}
	//아이디 찾기 처리
	@RequestMapping(value = "/forget", method = RequestMethod.POST)
	public String findid(@RequestParam String name, String email, HttpServletRequest request) throws Exception {
		
		String id = memberDao.findid(name, email);
		
		request.setAttribute("id",id);
		
		return "member/forget_suc";
	}
	
	//비밀번호 찾기 뷰
	@RequestMapping("/forgetpw")
	public String findpw() {
		
		return "member/forgetpw";
		
	}
	//비밀번호 변경페이지 전송
	@RequestMapping(value = "/forgetpw", method = RequestMethod.POST)
	public String sendrpw(@RequestParam String email, @RequestParam String name,
			@RequestParam String id, HttpSession session,
			Model model) {
		
		log.info("인증할 이메일 : {}", email);
		
		String token = generator.createString(50);
		memberDao.sendemail(name,id, email, token);
		session.setAttribute("token", token);
		session.setAttribute("email", email);
		session.setAttribute("id",id);
		model.addAttribute("email", email);
		
		return "member/result";

	}
	
	@RequestMapping(value="/repwset", method=RequestMethod.GET)
	public String repwsetview(@RequestParam String token,
			HttpSession session, HttpServletResponse response
			) throws Exception {
		
		String sessionToken = (String)session.getAttribute("token");
		session.removeAttribute("token");
		
		if(!token.equals(sessionToken))
			throw new Exception("토큰이 일치하지 않습니다");

		
		return "member/repwset";
	}
	
	@RequestMapping(value = "/repwset", method = RequestMethod.POST)
	public String repwset(@RequestParam String pw, @RequestParam String rpw, HttpSession session) throws Exception {
		
		String sessionId = (String)session.getAttribute("id");
		String sessionEmail = (String)session.getAttribute("email");
		
		session.invalidate();
		
		if(pw.equals(rpw)) {
			
			boolean result = memberDao.repwset(sessionEmail, sessionId, pw);
			
			if(result) {
				log.info("비밀번호 변경 완료");
				return "redirect:/";
			}else {
				
				throw new Exception("비정상적 비밀번호 변경 감지");
				
			}
			
		}else {
			throw new Exception("비밀번호 미일치");
		}
	}
	
	//나의 정보수정 뷰
	@RequestMapping("/myedit")
	public String editview() {

		return "member/myedit";
	}
	
	//나의 정보창에서 비밀번호를 변경
	@RequestMapping(value = "/myedit", method = RequestMethod.POST)
	public String myedit(@RequestParam String id,
			@RequestParam String pw, @RequestParam String rpw, 
			@RequestParam String nickname, @RequestParam String phone, HttpSession session
			) throws Exception {
			
			Member member = (Member)session.getAttribute("member");
			if(pw.equals("")) {
				pw =  member.getPw();
				rpw = member.getPw();
			}
		log.info(pw);
		log.info(rpw);
		if(!pw.equals(rpw)) {
			throw new Exception("비밀번호 다름 발생");
		}else {
			member.setNickname(nickname);
			memberDao.infoedit(id, pw, nickname, phone);
			
			log.info(member.getNickname());
			
			session.setAttribute("member", member);
	
			return "redirect:/";
			
		}
	}
	
	//비밀번호 체크 뷰
	@RequestMapping("/check")
	public String checkview() {

		return "member/check";
	}
	
	//비밀번호 체크
	@RequestMapping(value = "/check", method = RequestMethod.POST)
	public String check(@RequestParam String mode, @RequestParam String id,@RequestParam String pw) throws Exception {
	
		
		boolean result = memberDao.check(id, pw);
		
		if(result) {
			
			if(mode.equals("edit")) {
				return "redirect:myedit";
			}else {
				throw new Exception("없는 모드");
			}
			
		}else {
			throw new Exception("없는 아이디나 비밀번호");
		}

	}
	
	//아이디 중복확인
	@RequestMapping(value = "/idcheck", method = RequestMethod.POST)
	public String idcheck(@RequestParam String id) throws Exception {
		
		log.info(id);
		
		boolean result = memberDao.idcheck(id);
		
		if(result) {
			return "member/success";
		}else {
			throw new Exception("아이디가있음");
		}		
	}
	//닉네임 중복확인
	@RequestMapping(value = "/nickcheck", method = RequestMethod.POST)
	public String nickcheck(@RequestParam String nick) throws Exception {
		
		log.info(nick);
		
		boolean result = memberDao.nickcheck(nick);
		
		if(result) {
			return "member/success";
		}else {
			throw new Exception("아이디가있음");
		}		
	}
	
	@RequestMapping(value = "/nickcheck2", method = RequestMethod.POST)
	public String nickcheck2(@RequestParam String nick, @RequestParam String id) throws Exception {
		
		
		boolean result = memberDao.nickcheck(id, nick);
		boolean result2 = memberDao.nickcheck(nick);
		
		System.out.println(result);
		System.out.println(result2);
		
		if(!result || result2) {
			return "member/success";
		}else {
			throw new Exception("아이디가있음");
		}		
	}
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String test(HttpServletRequest requset, HttpSession session) {

		
		Cookie[] cookies = requset.getCookies();
		
		String id =  null;
		
		if(cookies != null) {
			
			for(Cookie c : cookies) {
				if(c.getName().equals("autologin")) {
					id = c.getValue();
					break;
				}
			}
			
			if(id != null) {
				
				String pw = memberDao.iterpw(id);
				
				Member member = memberDao.login(id, pw);
				
				session.setAttribute("member", member);
			}
			
		}

		return "home";
	}
	

}
