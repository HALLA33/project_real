package spring.model.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository("boardDao")
public class BoardDaoImpl implements BoardDao{
	private Logger log = LoggerFactory.getLogger(getClass());
	private Map<Integer, Book> map = new HashMap<>();
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<Board> mapper = (rs, index)->{
		return new Board(rs);
	};
	
	private RowMapper<Book> bmapper = (rs, index)->{
		return new Book(rs);
	};
	
	@Override
	public List<Board> board_list(int start, int end, int item_no) {
		String sql = "select * from "
						+ "(select rownum rn, TMP.* from "
						+ "(select * from p_board where item_no=?) TMP) "
						+ "where rn between ? and ?";
		
		Object[] args = {start, end, item_no};
		
	   return jdbcTemplate.query(sql, args, mapper);
	}
	
	@Override
	public Map<Integer, Book> book_list(int no) {
		Object[] args = {no};
		List<Book> list = jdbcTemplate.query("select * from p_search where no=?", args, bmapper);
		
		Book book = list.get(0);
		map.put(no, book);

		return map;
	}

	public int search_no() {
		String sql = "select p_search_seq.nextval from dual";
		int no = jdbcTemplate.queryForObject(sql, Integer.class);
		
		return no;
	}
	
	@Override
	public int search_write(Book book) {
		int no = search_no();
		
		String sql = "insert into p_search values(?, ?, ?, ?, ?, ?)";
		Object[] args = {no, book.getTitle(), book.getImage(), book.getAuthor(), book.getPublisher(), book.getPubdate()};
		
		log.info("search_write실행", book.toString());
		jdbcTemplate.update(sql, args);
		
		return no;
	}
	
	public int seq_number(String seq) {
		seq += ".nextval";
		String sql = "select " + seq + " from dual";
		
		int no = jdbcTemplate.queryForObject(sql, Integer.class);
		
		return no;
	}
	
	@Override
	public void write(Board board, int no) {
		String sql = "insert into p_board values(?, ?, ?, ?, ?, ?, ?, sysdate, 0, 0, 0, 0, ?, ?)";
		
		String seq = null;
		switch(board.getItem_no()) {
		case 0 : seq = "p_board_notice_seq"; break;
		case 1 : seq = "p_board_kbook_seq"; break;
		case 2 : seq = "p_board_obook_seq"; break;
		case 3 : seq = "p_board_kmovie_seq"; break;
		case 4 : seq = "p_board_omovie_seq"; break;
		case 5 : seq = "p_board_con_seq"; break;
		case 6 : seq = "p_board_etc_seq"; break;
		case 7 : seq = "p_board_free_seq"; break;
		}
		
		int seq_number = seq_number(seq);
		
		Object[] args = {
				seq_number, board.getItem_no(), board.getHead(), board.getTag(), 
				board.getWriter(), board.getTitle(), board.getDetail(), board.getNotice(), no
				};
		
		jdbcTemplate.update(sql, args);
	}

	@Override
	public int count(int item) {		
		String sql = "select count(*) from p_board where item_no=?";
		Object[] args = {item};
		
		int count = jdbcTemplate.queryForObject(sql, args, Integer.class);
		return count;
	}

}
