package spring.model.board;

import java.sql.ResultSet;
import java.util.List;
import java.util.Map;

import javax.persistence.AttributeOverride;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;


@Repository("replyDao")
public class ReplyDaoImpl implements ReplyDao{
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@Autowired
	private JdbcTemplate jdbcTemplate;

	private RowMapper<Reply> mapper = (rs, index) -> {
		return new Reply(rs);
	};

	private RowMapper<ReplyResult> rmapper = (rs, index) -> {
		return new ReplyResult(rs);
	};
	
	private ResultSetExtractor<Reply> extractor = (rs) ->{
		if(rs.next())
			return new Reply(rs);
		else 
			return null;
	};

	@Override
	public Reply reply_insert(Reply reply) {
		int gno = reply.getGno();
		int gseq = reply.getGseq();
		int depth = reply.getDepth();
		String sql = null;
		
		if(gno == 0) {
			sql = "select max(gno) from p_reply where board_no=? and board_item_no=?";
			Object[] args1 = {reply.getBoard_no(), reply.getBoard_item_no()};

			String max_gno = jdbcTemplate.queryForObject(sql, args1, String.class);
			if(max_gno==null)
				max_gno = "0";
			
			gno = Integer.parseInt(max_gno) + 1;
			gseq = 0;
			depth = 0;
		}else {
			//gseq 계산
			sql = "select ("
								+ "select min(gseq) from p_reply where gno=? and gseq>? and depth<?  and board_no=? and board_item_no=?"
								+ ") first, ("
								+ "select min(gseq) from p_reply where gno=? and gseq>? and depth=?  and board_no=? and board_item_no=?"
								+ ") second, ("
								+ "select count(*) from p_reply where gno=? and board_no=? and board_item_no=?) last from dual";		
			Object[] args2 = {gno, gseq, depth, reply.getBoard_no(), reply.getBoard_item_no(), 
										gno, gseq, depth, reply.getBoard_no(), reply.getBoard_item_no(),
										gno, reply.getBoard_no(), reply.getBoard_item_no()};

			List<ReplyResult> result = jdbcTemplate.query(sql, args2, rmapper);
			log.info("결과 : " + result);
			
			int first = 0;
			int second = 0;
			int last = 0;
			
			for(ReplyResult r: result) {
				first = r.getfirst();
				second = r.getSecond();
				last = r.getLast();
			}
			
			log.info("first : " + first);
			log.info("second : " + second);
			log.info("last : " + last);

			//[1] first, second 둘다 0 => 그룹 마지막
			//[2] first, second 둘다 0이 아닌 경우 => 둘중 작은값
			//[3] first!=0, second==0  또는 first==0, second!=0 인 경우 => 둘중 큰값
			int location;
			if(first + second == 0) {
				location = last;
			}else if(first != 0 && second != 0) {
				location = Math.min(first, second);
			}else {
				location = Math.max(first, second);
			}
			
			//update 처리
			sql = "update p_reply set gseq=gseq+1 where gno=? and gseq>=? and board_no=? and board_item_no=?";
			Object[] args3 = {gno, location, reply.getBoard_no(), reply.getBoard_item_no()};
			jdbcTemplate.update(sql, args3);
			
			//gno는 그대로 사용
			gseq = location;
			depth++;
		}
		
		sql = "insert into p_reply values(p_reply_seq.nextval, ?, ?, sysdate, ?, ?, ?, ?, ?)";
		Object[] args4 = {reply.getWriter(), reply.getDetail(), reply.getBoard_no(), reply.getBoard_item_no(),
									gno, gseq, depth};
		
		jdbcTemplate.update(sql, args4);

		sql = "select * from p_reply where no=?";
		int no = reply_no();
		Object[] args5 = {no-1};
		
		return jdbcTemplate.query(sql,  args5, extractor);
	}

	@Override
	public List<Reply> reply_list(int board_no, int board_item_no) {
		String sql = "select * from p_reply where board_no=? and board_item_no=? order by gno asc, gseq asc";
		Object[] args = {board_no, board_item_no};
		
		List<Reply> list = jdbcTemplate.query(sql,  args, mapper);
		
		return list;
	}

	@Override
	public int reply_no() {
		String sql = "select p_reply_seq.nextval from dual";
		int no = jdbcTemplate.queryForObject(sql, Integer.class);
		
		return no;
	}

	@Override
	public Reply reply_detail(int no) {
		String sql = "select * from p_reply where no=?";
		Object[] args = {no};
		
		return jdbcTemplate.query(sql,  args, extractor);
	}

	@Override
	public void reply_delete(int no) {
		String sql = "delete from p_reply where no=?";
		Object[] args = {no};
		
		jdbcTemplate.update(sql, args);
	}

}
