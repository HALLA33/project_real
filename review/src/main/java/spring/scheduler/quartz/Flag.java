package spring.scheduler.quartz;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

public class Flag {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	private Logger log = LoggerFactory.getLogger(getClass());
	
	public void status() {
		
		log.info("true로 바꿈");
		
		String sql = "update p_member set flag = 0, todaywrite = 0";
		
		jdbcTemplate.update(sql);
		
	}

}
