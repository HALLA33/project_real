package spring.model.member;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface MemberDao {
	
	public boolean sign(Member member);
	public List<Member> memberlist();
	public Member login(String id, String pw);
	public String findid(String name, String email) throws Exception;
}
