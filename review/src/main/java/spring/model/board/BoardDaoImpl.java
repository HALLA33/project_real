package spring.model.board;

import java.sql.ResultSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
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
	
	ResultSetExtractor<Board> extractor = (ResultSet arg0) -> {
		if(arg0.next())
			return new Board(arg0);
		else 
			return null;
	};
	
	@Override
	public List<Board> board_list(int start, int end, int item_no) {
		String sql = "select * from "
						+ "(select rownum rn, TMP.* from "
						+ "(select * from p_board where item_no=?) TMP) "
						+ "where rn between ? and ?";
		
		Object[] args = {item_no, start, end};
		
	   return jdbcTemplate.query(sql, args, mapper);
	}
	
	@Override
	public Map<Integer, Book> book_list(int no) {
		Object[] args = {no};
		List<Book> list = jdbcTemplate.query("select * from p_search where no=?", args, bmapper);
		
		for(Book book: list) {
			map.put(no, book);
		}
		
		//Book book = list.get(0);
		
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
	public int write(Board board, int no) {
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
		
		return seq_number;
	}

	@Override
	public int count(int item_no) {		
		String sql = "select count(*) from p_board where item_no=?";
		
		Object[] args = {item_no};
		int count = jdbcTemplate.queryForObject(sql, args, Integer.class);
		return count;
	}

	@Override
	public String search_nickname(String id) {
		String sql = "select nickname from p_member where id=?";
		
		Object[] args = {id};
		return jdbcTemplate.queryForObject(sql, args, String.class );

	}

	@Override
	public List<Book> exist_book(Book book) {
		String sql = "select * from p_search where title=? and author=?";
		
		Object[] args = {book.getTitle(), book.getAuthor()};	
		return jdbcTemplate.query(sql, args, bmapper);

	}

	@Override
	public Book detail_book(int no) {
		String sql = "select * from p_search where no=?";
		
		Object[] args = {no};
		List<Book> list = jdbcTemplate.query(sql, args, bmapper);
		
		return list.get(0);
	}

	@Override
	public Board detail_board(int no, int item_no) {
		String sql = "select * from p_board where no=? and item_no=?";
		
		Object[] args = {no, item_no};
		return jdbcTemplate.query(sql, args, extractor);
	}
	
	@Override
	public Board detail_board(int no, int item_no, String writer) {
		String sql = "select * from p_board where no=? and item_no=? and writer=?";
		
		Object[] args = {no, item_no, writer};
		return jdbcTemplate.query(sql, args, extractor);
		
		
	}

	@Override
	public void update_board(Board board, Book book, int no, int item_no, String writer) {		
		String sql = "update p_board set item_no=?, head=?, tag=?, title=?, detail=?, reg=sysdate, search_no=? where no=? and item_no=? and writer=?";
		
		Object[] args = {board.getItem_no(), board.getHead(), board.getTag(), board.getTitle(), board.getDetail(),
							board.getSearch_no(), no, item_no, writer};
		
		jdbcTemplate.update(sql, args);
	}

	@Override
	public void delete_board(int no, int item_no, String id) {
		String sql = "delete from p_board where no=? and item_no=? and writer=?";
		
		Object[] args = {no, item_no, id};
		
		jdbcTemplate.update(sql, args);
	}

	


}
