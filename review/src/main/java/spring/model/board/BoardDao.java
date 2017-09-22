package spring.model.board;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

@Repository
public interface BoardDao {
	List<Board> board_list(int start, int end, int item_no, int head, int align);
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
	void insert_cookie(int cookie_no, String cookie_name, String cookie_value, int board_no, int board_item_no, String writer);
	void delete_cookie(int cookie_no, String writer);
	void board_delete_cookie(int board_no, int board_item_no);
	int getpoint(String nickname);
}