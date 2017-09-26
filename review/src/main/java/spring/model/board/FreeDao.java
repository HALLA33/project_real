package spring.model.board;

import org.springframework.stereotype.Repository;

@Repository
public interface FreeDao {
	void update_board(Board board, int no, int item_no, String writer);
	void delete_board(int no, int item_no, String id);
	void delete_board(int no, int item_no);
}
