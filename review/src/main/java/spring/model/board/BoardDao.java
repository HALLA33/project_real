package spring.model.board;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface BoardDao {
	List<Board> list();
	void write(Board board);
}
