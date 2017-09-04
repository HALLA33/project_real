package spring.model.board;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDaoImpl implements BoardDao{

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Override
	   public List<Board> list() {
	      RowMapper<Board> mapper = (rs, index)->{
	         Board board = new Board();
	         board.setNo(rs.getInt("no"));
	         board.setItem_no(rs.getInt("item_no"));
	         board.setHead(rs.getString("head"));
	         board.setWriter(rs.getString("writer"));
	         board.setTitle(rs.getString("title"));
	         board.setReg(rs.getString("reg"));
	         board.setRead(rs.getInt("read"));
	         return board;
	      };
	      return jdbcTemplate.query("select * from p_board order by no desc", mapper);
	   }

	@Override
	public void write(Board board) {
		String sql = "insert into p_board values(?, ?, ?, ?, ?, ?, ?, sysdate, 0, 0, 0, 0, ?)";
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
		
		Object[] args = {
				seq+".nextval", board.getItem_no(), board.getHead(), board.getTag(), 
				board.getWriter(), board.getTitle(), board.getDetail(), board.getNotice()
				};
		
		jdbcTemplate.update(sql, args);
	}

}
