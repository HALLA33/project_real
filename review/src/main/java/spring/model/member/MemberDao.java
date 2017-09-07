package spring.model.member;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface MemberDao {
	
	public boolean sign(Member member);
	public List<Member> memberlist();
	public Member login(String id, String pw);
	public String findid(String name, String email) throws Exception;
	public void sendemail(String name, String id, String email, String token);
	public boolean repwset(String email, String id, String pw);
	public boolean infoedit(String id, String rpw, String nickname, String phone);
	public boolean check(String id, String pw);
	public boolean idcheck(String id);
	public boolean nickcheck(String nick);
}
