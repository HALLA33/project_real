package spring.model.board;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import spring.model.member.Tags;

@Repository
public interface BookDao {
	List<Board> board_list(int start, int end, int item_no, int head, int align, String tag, String word);
	Map<Integer, Book> book_list(int no);
	int write(Board board, int no);
	int search_write(Book book);
	String search_nickname(String id);
	List<Book> exist_book(Book book);
	int count(int item_no);
	int count2(String tag);
	Book detail_book(int no);
	Board detail_board(int no, int item_no, String writer);
	Board detail_board(int no, int item_no);
	void update_board(Board board, int no, int item_no, String writer, String tag);
	void delete_board(int no, int item_no, String id, String tag);
	void delete_board(int no, int item_no, String tag);
	void plus_minus_Count(int flag, int no, int item_no);
	void insert_cookie(int cookie_no, String cookie_name, String cookie_value, int board_no, int board_item_no, String writer);
	void delete_cookie(int cookie_no, String writer);
	void board_delete_cookie(int board_no, int board_item_no);
	int getpoint(String nickname);
	public List<Tags> taglist();
	void upload_image(int board_no, int board_item_no, String originFileName, String moveFileName);
	List<Image> delete_image(int board_no, int board_item_no);
	List<Image> detail_board_image(int board_no, int board_item_no);
	List<Board> recomTwo(String emo, String wea);
	List<Board> recomEmo(String emo, String wea);
	List<Board> recomWea(String emo, String wea);
	List<Board> home_notice(int item_no);
	List<Board> home_book_inner(int item_no);
	List<Board> home_book_outter(int item_no);
	List<Board> home_movie_inner(int item_no);
	List<Board> home_movie_outter(int item_no);	
}
