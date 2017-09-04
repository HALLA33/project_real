package spring.model.member;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository("memberDao")
public class MemberDaoImpl implements MemberDao{
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	private Logger log = LoggerFactory.getLogger(getClass());
	
	private RowMapper<Member> mapper = (rs, index)->{
		return new Member(rs);
	};

	@Override
	public boolean sign(Member member) {
		log.info("실행됨");
		log.info(member.toString());
		
		log.info(member.getId());
		log.info(member.getPw());
		log.info(member.getNickname());
		log.info(member.getEmail());
		log.info(member.getName());
		log.info(member.getGender());
		log.info(member.getBirth());
		log.info(member.getTelecom());
		log.info(member.getPhone());
		
		String test ="test";
//		String sql = "insert into p_member values(p_member_seq.nextval ,'test', 'test', 'test' ,'test', 'test' , 'test' ,'test' ,'test','test', '일반', 0, sysdate, sysdate, 1, 0, 0, 'true')";
		String sql = "insert into p_member values(p_member_seq.nextval, ?, ?, ? , ?, ? , ? , ? , ? , ?, '일반', 0, sysdate, sysdate, 1, 0, 0, 'true')";
		
		
		Object[] args = new Object[]{member.getId(), member.getPw(), member.getNickname(), member.getEmail(),
			member.getName(), member.getGender(), member.getBirth(), member.getTelecom(), member.getPhone()	
		};
		
		int result = jdbcTemplate.update(sql, args);
		
		return result > 0;
	}
	
	@Override
	public List<Member> memberlist() {
		
		String sql = "select * from (select rownum rn, TMP.* from(select * from p_member order by no desc)TMP) where rn between 1 and 10";
		List<Member> list = jdbcTemplate.query(sql, mapper);

		return list;
	}
	
	@Override
	public Member login(String id, String pw) {

		String sql = "select * from p_member where id = ? and pw = ?";
		
		List<Member> list = jdbcTemplate.query(sql, new Object[] {id, pw}, mapper);
		
		Member member = list.get(0);
		
		return member;
		
	}
	
	@Override
	public String findid(String name, String email) throws Exception {
		
		String sql = "select * from p_member where name =? and email = ?";
		
		boolean result = jdbcTemplate.query(sql, new Object[] {name, email}, mapper).isEmpty();
		
		System.out.println(result);
		
		if(!result) {
			
			sql = "select * from p_member where name = ? and email = ?";
			
			String id = jdbcTemplate.query(sql, new Object[] {name, email}, mapper).get(0).getId();
			
			log.info(id);
			
			return id;
		}else {
			throw new Exception("해당하는 아이디 없음");
		}
	}

	
	
}
