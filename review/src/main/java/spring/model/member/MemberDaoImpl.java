package spring.model.member;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Repository;

import spring.model.board.Board;
import spring.model.board.Reply;

@Repository("memberDao")
public class MemberDaoImpl implements MemberDao {

	@Autowired
	private JdbcTemplate jdbcTemplate;
	private Logger log = LoggerFactory.getLogger(getClass());

	private RowMapper<Member> mapper = (rs, index) -> {
		return new Member(rs);
	};
	
	private RowMapper<Board> mapper2 = (rs, index) -> {
		return new Board(rs);
	};
	
	private RowMapper<Cookies> c_mapper = (rs, index) -> {
		return new Cookies(rs);

	};
	
	private RowMapper<Attendance> mapper3 = (rs, index) -> {
		return new Attendance(rs);
	};
	
	private RowMapper<Tags> mapper4 = (rs, index) -> {
		return new Tags(rs);
	};
	
	private RowMapper<Reply> mapper5 = (rs, index) -> {
		return new Reply(rs);
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
		String sql = "insert into p_member values(p_member_seq.nextval, ?, ?, ? , ?, ? , ? , ? , ? , ?, '일반', 0, 0, sysdate, sysdate, 0, 0, 0, 'true', 0, 0, 0, 0, 'true')";

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
		
		//아이디 비번에 맞는 항목이 있는지
		boolean result = jdbcTemplate.query(sql, new Object[] { id, pw }, mapper).isEmpty();
		
		//없으면 빈 멤버를 보냄
		if(result) return new Member();

		List<Member> list = jdbcTemplate.query(sql, new Object[] { id, pw }, mapper);

		Member member = list.get(0);
		
		int flag = member.getFlag();
		int point = 0;
		
		System.out.println("flag : " + flag);
		
		if(flag == 0) {
			sql = "update p_member set visitnumber = visitnumber +1, flag = 1, "
					+ "point = point+10, totalpoint = totalpoint + 10 where id = ?";
			jdbcTemplate.update(sql, new Object[] {id});
			sql = "select point from p_member where id = ?";
			point = jdbcTemplate.queryForObject(sql,new Object[] {id}, Integer.class);
			member.setPoint(point);
		}
		System.out.println("point : " + point);
		sql = "update p_member set lastvisit = sysdate where id = ?";

		jdbcTemplate.update(sql, new Object[] { id });


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
	public boolean emailcheck(String email) {

		String sql = "select * from p_member where email = ?";

		boolean result = jdbcTemplate.query(sql, new Object[] { email }, mapper).isEmpty();

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

	@Override
	public boolean autologin(String id, String pw) {

		String sql = "select * from p_member where id = ? and pw = ?";

		List<Member> list = jdbcTemplate.query(sql, new Object[] { id, pw }, mapper);
		
		boolean result = !list.isEmpty();
		
		return result;
	}
	
	@Override
	public List<Cookies> check_cookie(String writer) {
		String sql = "select * from cookie where writer=?";
		Object[] args = {writer};
		
		
		return jdbcTemplate.query(sql, args, c_mapper);

	}

	@Override
	public boolean chengepower(String power, String id) {

		String sql = "update p_member set power = ? where id = ?";
		
		int result = jdbcTemplate.update(sql, new Object[] {power, id});
		
		return result>0;
	}

	@Override
	public void manageunsign(String id) {

		String sql = "delete p_member where id = ?";
		
		jdbcTemplate.update(sql, new Object[] {id});
		
	}
	
	@Override
	public void unsigned(String id, String pw) {
		
		String sql = "delete p_member where id = ? and pw = ?";
		
		jdbcTemplate.update(sql, new Object[] {id, pw});
			
	}

	@Override
	public List<Board> mywrite(String id) {
		
		String sql = "select * from p_board where writer = ? order by reg desc";
		
		return jdbcTemplate.query(sql, new Object[] {id}, mapper2);
	}

	@Override
	public boolean mydelete(String itemno, String writeno, String id) {
		
		String sql = "select tag from p_board where item_no =? and no =? and writer = ?";
		
		String tag = jdbcTemplate.queryForObject(sql, new Object[] {itemno, writeno, id}, String.class);
		
		if(tag != null) {
			String[] tags = tag.replace("#", "").split("/");
			
			for(String s : tags) {
				
				sql = "delete tags where item_no = ? and write_no = ? and tag = ?";
				
				jdbcTemplate.update(sql, new Object[] {itemno, writeno, s});
				
			}
			
		}
		sql = "delete p_board where item_no = ? and no = ? and writer = ?";
		
		int result = jdbcTemplate.update(sql, new Object[] {itemno, writeno, id});
		
		
		return result > 0;
	}
	
	@Override
	public boolean mycodelete(String writeno, String id) {
		
		String sql = "delete p_reply where no =? and writer = ?";
		
		int result = jdbcTemplate.update(sql, new Object[] {writeno, id});
		
		return result > 0;
	}
	
	@Override
	 public List<Member> memberRank() {
		
	 int num = membercount();
	 
	 if(num > 5) num = 5;
	 
	 String sql = "select * from "
	 + "(select rownum rn, A.* from "
	 + "(select * from p_member where power!='관리자' and totalpoint != 0 "
	 + "order by totalpoint desc, reg)A) "
	 + "where rn between 1 and ?";		
	 List<Member> list = jdbcTemplate.query(sql, new Object[] {num},  mapper);	
	 
	 return list;
	}
	
	@Override
	public boolean insertattend(String greetings, String nick, int point) {
		
		String sql = "select count(*) from attendance";
		
		int rank = jdbcTemplate.queryForObject(sql, Integer.class)+1;
		
		sql = "select to_char(sysdate, 'HH24:MI:SS') from dual";
		
		String time = jdbcTemplate.queryForObject(sql, String.class);
		
		sql = "insert into attendance values(?, ?, ?, ?, 0, 0, 0)";
		
		Object[] args = new Object[] {rank, time, greetings, nick};
		
		int result = jdbcTemplate.update(sql, args);
		
		switch(rank) {
		case 1: sql = "update p_member set point = point + 40, opening = opening +1, "
				+ "totalpoint = totalpoint + 40, checkflag = 'false', totalcheck = totalcheck + 1 where nickname = ?"; 
		jdbcTemplate.update(sql, new Object[] {nick}); break;
		case 2: sql = "update p_member set point = point + 30, opening = opening +1, "
				+ "totalpoint = totalpoint + 30, checkflag = 'false', totalcheck = totalcheck + 1 where nickname = ?";
		jdbcTemplate.update(sql, new Object[] {nick}); break;
		case 3: sql = "update p_member set point = point + 20, opening = opening +1, "
				+ "totalpoint = totalpoint + 20, checkflag = 'false', totalcheck = totalcheck + 1 where nickname = ?";
		jdbcTemplate.update(sql, new Object[] {nick}); break;
		default : sql = "update p_member set point = point + 10, opening = opening +1, "
				+ "totalpoint = totalpoint + 10, checkflag = 'false', totalcheck = totalcheck + 1 where nickname = ?";
		jdbcTemplate.update(sql, new Object[] {nick}); break;
			}

		sql = "select opening from p_member where nickname = ?";
		
		int openning = jdbcTemplate.queryForObject(sql, new Object[] {nick}, Integer.class);
		
		int totalcheck = jdbcTemplate.queryForObject("select totalcheck from p_member where nickname = ?", new Object[] {nick}, Integer.class);
		
		point = getpoint(nick);

	     sql = "update attendance set opening = ?, point = ?, total_check = ? where nick = ?";
	     
	     jdbcTemplate.update(sql, new Object[] {openning, point, totalcheck, nick});
	      
	     return result > 0;
		
	}
	
	@Override
	public int getpoint(String nickname) {
		
		int point  = jdbcTemplate.queryForObject("select point from p_member where nickname = ?", 
				new Object[] {nickname}, Integer.class);
		
		return point;
	}
	 
	@Override
	public Member getmember(String nickname) {
		
		log.info(nickname);
		
		List<Member> list  = jdbcTemplate.query("select * from p_member where nickname = ?", 
				new Object[] {nickname}, mapper);
		
		Member member = list.get(0);
		
		return member;
	}

	@Override
	public int attendrcount() {
		String sql = "select count(*) from attendance";
		int count = jdbcTemplate.queryForObject(sql, Integer.class);
		
		System.out.println(count);

		return count;
	}

	@Override
	public List<Attendance> attendlist(int start, int end) {
		String sql = "select * from "
				+ "(select rownum rn, A.* from "
				+ "(select * from attendance order by rank desc)A) "
				+ "where rn between ? and ?";
		
		List<Attendance> list = jdbcTemplate.query(sql, new Object[] {start, end}, mapper3);	
		
		return list;
	}

	@Override
	public List<Tags> taglist() {
		String sql = "select * from (select rownum rn, A.* from (select distinct tag, min(no) from "
				+ "tags group by tag order by min(no) desc, tag)A) where rn between 1 and 10";
		
		List<Tags> list = jdbcTemplate.query(sql, mapper4);
		
		return list;
	}

	@Override
	public List<Member> userinfo(String id) {
		
		String sql = "select * from p_member where id = ?";
		
		List<Member> list = jdbcTemplate.query(sql, new Object[] {id},mapper);
		
		return list;
	}
	
	@Override
	public List<Reply> mycomment(String id, String mode) {
		
		String sql = null;
		
		if(mode.equals("new")) {
			sql = "select * from p_reply where writer = ? order by reg desc";		
		}else if(mode.equals("old")) {
			sql = "select * from p_reply where writer = ? order by reg";	
		}
		
		List<Reply> list = jdbcTemplate.query(sql, new Object[] {id}, mapper5);
		
		sql = "select title from p_board where no = ? and item_no = ?";
		
		return list;
	}

	
	
}
