package spring.scheduler.quartz;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;

public class Visit {
	@Autowired
	private JdbcTemplate jdbcTemplate;
	private Logger log = LoggerFactory.getLogger(getClass());
	
	public void Visitstatus() {
		
		log.info("true로 바꿈");
		
		String sql = "update p_member set visitflag = 'true'";
		
		
		jdbcTemplate.update(sql);
		
	}

}
