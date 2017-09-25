package spring.model.board;

import java.sql.ResultSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import spring.model.member.Tags;

@Repository("movieDao")
public class MovieDaoImpl implements MovieDao{
	private Logger log = LoggerFactory.getLogger(getClass());
	private Map<Integer, Movie> map = new HashMap<>(); 
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	private RowMapper<Movie> mapper = (rs, index)->{
		return new Movie(rs);
	};

	@Override
	public Map<Integer, Movie> movie_list(int no) {
		Object[] args = {no};
		List<Movie> list = jdbcTemplate.query("select * from p_search_movie where no=?", args, mapper);
		
		for(Movie movie: list) {
			map.put(no, movie);
		}
		
		//Book book = list.get(0);
		
		return map;
	}

	public int search_no() {
		String sql = "select p_search_movie_seq.nextval from dual";
		int no = jdbcTemplate.queryForObject(sql, Integer.class);
		
		return no;
	}
	
	@Override
	public int search_write(Movie movie) {
		int no = search_no();
		
		String sql = "insert into p_search_movie values(?, ?, ?, ?, ?, ?)";
		Object[] args = {no, movie.getTitle(), movie.getImage(), movie.getDirector(), movie.getPubDate(), movie.getActor()};
		
		log.info("search_write실행", movie.toString());
		jdbcTemplate.update(sql, args);
		
		return no;
	}
	
	public int seq_number(String seq) {
		seq += ".nextval";
		String sql = "select " + seq + " from dual";
		
		int no = jdbcTemplate.queryForObject(sql, Integer.class);
		
		return no;
	}

	@Override
	public List<Movie> exist_movie(Movie movie) {
		log.info(movie.toString());
		String sql = "select * from p_search_movie where title=? and director=?";
		
		Object[] args = {movie.getTitle(), movie.getDirector()};	
		return jdbcTemplate.query(sql, args, mapper);
	}

	@Override
	public Movie detail_movie(int no) {
		String sql = "select * from p_search_movie where no=?";
		
		Object[] args = {no};
		List<Movie> list = jdbcTemplate.query(sql, args, mapper);
		
		return list.get(0);
	}

}
