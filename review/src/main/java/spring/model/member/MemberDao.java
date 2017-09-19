package spring.model.member;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Repository;

import spring.model.board.Board;

@Repository
public interface MemberDao {
	
	public boolean sign(Member member);
	public int membercount();
	public Member login(String id, String pw);
	public String findid(String name, String email) throws Exception;
	public void sendemail(String name, String id, String email, String token);
	public boolean repwset(String email, String id, String pw);
	public boolean infoedit(String id, String rpw, String nickname, String phone);
	public boolean check(String id, String pw);
	public boolean idcheck(String id);
	public boolean nickcheck(String nick);
	public boolean nickcheck(String id, String nick);
	public int count(String smode, String key) throws Exception;
	int singleSearchCount(String smode, String key) throws Exception;
	public List<Member> memberlist(int start, int end);
	public List<Member> memberlist(String smode, String key, int start, int end) throws Exception;
	public boolean autologin(String id, String pw);
	List<Cookies> check_cookie(String writer);
	public boolean chengepower(String power, String id);
	public void manageunsign(String id);
	public void unsigned(String id, String pw);
	List<Board> mywrite(String id);
	public boolean mydelete(String writeno, String id);
}
