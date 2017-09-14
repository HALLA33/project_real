package spring.model.board;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface BoardDao {
	List<Board> board_list(int start, int end, int item_no);
	Map<Integer, Book> book_list(int no);
	int write(Board board, int no);
	int search_write(Book book);
	String search_nickname(String id);
	List<Book> exist_book(Book book);
	int count(int item_no);
	Book detail_book(int no);
	Board detail_board(int no, int item_no, String writer);
	Board detail_board(int no, int item_no);
	void update_board(Board board, Book book, int no, int item_no, String writer);
	void delete_board(int no, int item_no, String id);
	void plus_minus_Count(int flag, int no, int item_no);
}
