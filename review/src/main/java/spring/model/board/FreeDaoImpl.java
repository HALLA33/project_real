package spring.model.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository("freeDao")
public class FreeDaoImpl implements FreeDao{

	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	@Override
	public void update_board(Board board, int no, int item_no, String writer) {
		String sql = "update p_board set item_no=?, head=?, title=?, detail=?, reg=sysdate where no=? and item_no=? and writer=?";
		
		Object[] args = {board.getItem_no(), board.getHead(), board.getTitle(), board.getDetail(),
							no, item_no, writer};
		
		jdbcTemplate.update(sql, args);
		
	}

	@Override
	public void delete_board(int no, int item_no, String id) {
		String sql = "delete from p_board where no=? and item_no=? and writer=?";
		
		Object[] args = {no, item_no, id};
		
		jdbcTemplate.update(sql, args);
	}

	@Override
	public void delete_board(int no, int item_no) {
		String sql = "delete from p_board where no=? and item_no=?";
		
		Object[] args = {no, item_no};
		
		jdbcTemplate.update(sql, args);	
		
	}

}
