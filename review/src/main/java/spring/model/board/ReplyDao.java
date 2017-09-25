package spring.model.board;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface ReplyDao {
	Reply reply_insert(Reply reply);
	int reply_no();
	List<Reply> reply_list(int board_no, int board_item_no);
	Reply reply_detail(int no);
	void reply_delete(int no);
}
