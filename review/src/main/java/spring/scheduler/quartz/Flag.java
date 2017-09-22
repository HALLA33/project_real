package spring.scheduler.quartz;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import spring.model.member.Attendance;

public class Flag {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private Logger log = LoggerFactory.getLogger(getClass());
	
	public void status() {
		
		log.info("true로 바꿈");
		
		String sql = "update p_member set flag = 0, todaywrite = 0, checkflag = 'true'";
		
		jdbcTemplate.update(sql);
		
		sql = "truncate table attendance";
		
		jdbcTemplate.update(sql);
		
	}
	
	public void reset() {
		
		log.info("리셋함");
		
		String sql = "select nick from attendance";
		List<Attendance> list = jdbcTemplate.query(sql, new RowMapper<Attendance>() {
			@Override
			public Attendance mapRow(ResultSet arg0, int arg1) throws SQLException {
				Attendance attendance = new Attendance();
				attendance.setNick(arg0.getString("nick"));
				return attendance;
			}
		});
		
		for(int i =0; i < list.size(); i++) {
			
			sql = "update attendance set opening = 0 where "
					+ "(SELECT TO_DATE(TO_CHAR(SYSDATE, 'YY/MM/DD')) "
					+ "- TO_DATE((select reg_check from attendance where nick = ?))  FROM DUAL) > 1";
			int result = jdbcTemplate.update(sql, new Object[] {list.get(i).getNick()});
			
			boolean result2 = result > 0;
			
			if(result2) {
				sql = "update p_member set opening = 0 where nickname = ?";
				
				jdbcTemplate.update(sql, new Object[] {list.get(i).getNick()});
			
				log.info(list.get(i).getNick() + "초기화 됨");
			}
		}
		
	}

}
