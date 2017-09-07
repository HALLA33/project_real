package spring.model.board;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface BoardDao {
	List<Board> board_list(int start, int end, int item_no);
	Map<Integer, Book> book_list(int no);
	void write(Board board, int no);
	int search_write(Book book);
	int count(int item);
}
