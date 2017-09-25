package spring.model.board;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Movie {
	private int no;
	private String title;
	private String link;
	private String image;
	private String subtitle;
	private String pubDate;
	private String director;
	private String actor;
	private String userRating;
	
	public Movie() {
		super();
	}

	public Movie(ResultSet rs) throws SQLException {
		setNo(rs.getInt("no"));
		setTitle(rs.getString("title"));
		setImage(rs.getString("image"));
		setPubDate(rs.getString("pubDate"));
		setDirector(rs.getString("director"));
		setActor(rs.getString("actor"));
	}
	
	public int getNo() {
		return no;
	}
	
	public void setNo(int no) {
		this.no = no;
	}
	
	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getLink() {
		return link;
	}

	public void setLink(String link) {
		this.link = link;
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public String getSubtitle() {
		return subtitle;
	}

	public void setSubtitle(String subtitle) {
		this.subtitle = subtitle;
	}

	public String getPubDate() {
		return pubDate;
	}

	public void setPubDate(String pubDate) {
		this.pubDate = pubDate;
	}

	public String getDirector() {
		return director;
	}

	public void setDirector(String director) {
		this.director = director;
	}

	public String getActor() {
		return actor;
	}

	public void setActor(String actor) {
		this.actor = actor;
	}

	public String getUserRating() {
		return userRating;
	}

	public void setUserRating(String userRating) {
		this.userRating = userRating;
	}

	@Override
	public String toString() {
		return "Movie [no=" + no + "title=" + title + ", link=" + link + ", image=" + image + ", subtitle=" + subtitle + ", pubDate="
				+ pubDate + ", director=" + director + ", actor=" + actor + ", userRating=" + userRating + "]";
	}
	
}
