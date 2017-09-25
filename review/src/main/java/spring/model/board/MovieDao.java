package spring.model.board;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import spring.model.member.Tags;

@Repository
public interface MovieDao {
	Map<Integer, Movie> movie_list(int no);
	int search_write(Movie movie);
	List<Movie> exist_movie(Movie movie);
	Movie detail_movie(int no);
}
