package spring.model.member;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Repository;

@Repository("memberDao")
public class MemberDaoImpl implements MemberDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	private Logger log = LoggerFactory.getLogger(getClass());

	private RowMapper<Member> mapper = (rs, index) -> {
		return new Member(rs);

	};

	@Autowired
	private JavaMailSenderImpl mailsender;

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

		String test = "test";
		String sql = "insert into p_member values(p_member_seq.nextval, ?, ?, ? , ?, ? , ? , ? , ? , ?, '일반', 0, sysdate, sysdate, 1, 0, 0, 'true')";

		Object[] args = new Object[] { member.getId(), member.getPw(), member.getNickname(), member.getEmail(),
				member.getName(), member.getGender(), member.getBirth(), member.getTelecom(), member.getPhone() };

		int result = jdbcTemplate.update(sql, args);

		return result > 0;
	}

	@Override
	public int membercount() {

		String sql = "select count(*) from p_member";
		int count = jdbcTemplate.queryForObject(sql, Integer.class);
		
		System.out.println(count);

		return count;
	}

	@Override
	public Member login(String id, String pw) {

		String sql = "select * from p_member where id = ? and pw = ?";

		List<Member> list = jdbcTemplate.query(sql, new Object[] { id, pw }, mapper);

		sql = "update p_member set lastvisit = sysdate where id = ?";

		jdbcTemplate.update(sql, new Object[] { id });

		Member member = list.get(0);

		return member;

	}

	@Override
	public String findid(String name, String email) throws Exception {

		String sql = "select * from p_member where name =? and email = ?";

		boolean result = jdbcTemplate.query(sql, new Object[] { name, email }, mapper).isEmpty();

		System.out.println(result);

		if (!result) {

			sql = "select * from p_member where name = ? and email = ?";

			String id = jdbcTemplate.query(sql, new Object[] { name, email }, mapper).get(0).getId();

			log.info(id);

			return id;
		} else {
			throw new Exception("해당하는 아이디 없음");
		}
	}

	@Override
	public void sendemail(String name, String id, String email, String token) {

		String sql = "select * from p_member where name = ? and id = ? and  email = ?";

		boolean result = jdbcTemplate.query(sql, new Object[] { name, id, email }, mapper).isEmpty();

		if (!result) {
			SimpleMailMessage mailMessage = new SimpleMailMessage();
			mailMessage.setTo(email);
			mailMessage.setSubject("비밀번호 변경 페이지 입니다");

			String text = "인증하시려면 아래의 링크를 누르세요\n" + "http://localhost:8080/review/repwset?token=" + token + ";";
			mailMessage.setText(text);
			mailsender.send(mailMessage);
			log.debug(email + " 로 인증 메일 발송 완료");
		}

	}

	@Override
	public boolean repwset(String email, String id, String pw) {

		String sql = "update p_member set pw = ? where email = ? and id = ? ";

		int result = jdbcTemplate.update(sql, new Object[] { pw, email, id });

		return result > 0;

	}

	@Override
	public boolean infoedit(String id, String pw, String nickname, String phone) {

		String sql = "update p_member set pw = ?, nickname = ?, phone = ? where id = ?";

		int result = jdbcTemplate.update(sql, new Object[] { pw, nickname, phone, id });

		return result > 0;
	}

	@Override
	public boolean check(String id, String pw) {

		String sql = "select * from p_member where id = ? and pw = ?";

		boolean result = jdbcTemplate.query(sql, new Object[] { id, pw }, mapper).isEmpty();

		return !result;
	}

	@Override
	public boolean idcheck(String id) {

		String sql = "select * from p_member where id = ?";

		boolean result = jdbcTemplate.query(sql, new Object[] { id }, mapper).isEmpty();

		return result;

	}

	@Override
	public boolean nickcheck(String nick) {

		String sql = "select * from p_member where nickname = ?";

		boolean result = jdbcTemplate.query(sql, new Object[] { nick }, mapper).isEmpty();

		return result;

	}

	@Override
	public boolean nickcheck(String id, String nick) {

		String sql = "select * from p_member where id =? and nickname = ?";

		boolean result = jdbcTemplate.query(sql, new Object[] { id, nick }, mapper).isEmpty();

		return result;
	}

	@Override
	public int count(String smode, String key) throws Exception{
		if(smode == null || key == null){
			return membercount();
		}
		
		// 0 : 제목+내용 , 1 : 제목만 , 2 : 작성자만
		switch(smode) {
		case "0":	
		case "1":
			return singleSearchCount(smode, key);
		}
		
		throw new Exception("처리 오류");
	}

	public int singleSearchCount(String smode, String key) throws Exception {
		switch (smode) {
		case "0":
			smode = "id";
			break;
		case "1":
			smode = "nickname";
			break;
		}

		String sql = "select count(*) from p_member where lower(" + smode + ") like ?";
		
		int count  = jdbcTemplate.queryForObject(sql, new Object[] {"%"+key.toLowerCase()+"%"}, Integer.class);
		
		System.out.println(count);
		
		return count;
	}

	@Override
	public List<Member> memberlist(int start, int end) {
		
		String sql = "select * from "
				+ "(select rownum rn, A.* from "
				+ "(select * from p_member order by no desc)A) "
				+ "where rn between ? and ?";
		
		List<Member> list = jdbcTemplate.query(sql, new Object[] {start, end}, mapper);	
		
		return list;
	}

	@Override
	public List<Member> memberlist(String smode, String key, int start, int end) throws Exception {

		if(smode == null || key == null){
			return memberlist(start, end);//목록
		}
		
		// 0 : 제목+내용 , 1 : 제목만 , 2 : 작성자만
		switch(smode) {
		case "0":	
		case "1":	
			return singleSearch(smode, key, start, end);
		}
		return null;
		
	}
	
	private List<Member> singleSearch(String smode, String key, int start, int end) throws Exception{
		switch(smode) {
		case "0": smode = "id"; break;
		case "1": smode = "nickname"; break;
		}
		
		String sql = "select * from "
							+ "(select rownum rn, TMP.* from "
										+ "(select * from p_member "
											+ "where lower("+smode+") like '%'||?||'%' "
											+ "order by no desc)TMP) "
							+ "where rn between ? and ?";

		List<Member> list = jdbcTemplate.query(sql, new Object[] {key.toLowerCase(), start, end}, mapper);
		
		return list;
	}

}
