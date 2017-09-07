package spring.controller.member;

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
	

	//뷰 페이지
	
	//이용약관 뷰
	@RequestMapping("/tos")
	public String tosview(){
		System.out.println("실행됨");
		
		return "member/tos";				
	}
	
	//회원가입 뷰
	@RequestMapping("/sign")
	public String signview() {
		
		
		return "member/sign";
	}
	
	//나의 정보 뷰
	@RequestMapping
	public String infoview() {
	
		return "member/myinfo";
	}
	//나의 정보수정 뷰
	@RequestMapping("/myedit")
	public String editview() {
		
		
		return "member/myedit";
	}
	
	//비밀번호 찾기 뷰
	@RequestMapping("/forgetpw")
	public String findpw() {
		
		return "member/forgetpw";		
	}
	
	//관리자 전용 멤버리스트 뷰
	@RequestMapping("/member")
	public String memberlist(HttpServletRequest request, HttpServletRequest respons) {
		
		List<Member> list = memberDao.memberlist();
		
		request.setAttribute("list", list);
		
		return "member/member";
	}
	
	//아이디 찾기 뷰
	@RequestMapping("/forget")
	public String findidview() {
		
		
		return "member/forget";
	}
	
	//===================================================
	
	//처리 페이지
	
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
	
	//로그인 처리
	@RequestMapping(value = "login", method = RequestMethod.POST)
	public String login(
			@RequestParam String id,@RequestParam String pw, HttpSession session
			) {
		
		log.info("로그인 실행");
		
		Member member = memberDao.login(id, pw);
		
		log.info(member.getName());
		
		session.setAttribute("member", member);

		return "redirect:/";
	}
	//로그아웃 처리
	@RequestMapping("logout")
	public String logout(HttpSession session) {
		
		session.invalidate();
		
		return "redirect:/";
	}
	//아이디 찾기 처리
	@RequestMapping(value = "/forget", method = RequestMethod.POST)
	public String findid(@RequestParam String name, String email, HttpServletRequest request) throws Exception {
		
		String id = memberDao.findid(name, email);
		
		request.setAttribute("id",id);
		
		return "member/forget_suc";
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
	//비밀번호 찾기페이지에서 비밀번호 변경
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
	
	//나의 정보창에서 비밀번호를 변경
	@RequestMapping(value = "/myedit", method = RequestMethod.POST)
	public String myedit(
			@RequestParam String pw, @RequestParam String rpw, 
			@RequestParam String nickname, @RequestParam String phone, HttpSession session
			) throws Exception {
		
		if(!pw.equals(rpw)) {
			throw new Exception("비밀번호 다름 발생");
		}else {
			
			memberDao.infoedit(pw, nickname, phone);
			
			session.invalidate();
			
			return "redirect:/";
			
		}
	}
	
	
	
	

}
