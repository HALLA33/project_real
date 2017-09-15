package spring.model.member;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Cookies {
	private int no;
	private int cookie_no;
	private String cookie_name;
	private String cookie_value;
	private int board_no;
	private int board_item_no;
	private String writer;
	
	public Cookies() {
		super();
	}

	public Cookies(ResultSet rs) throws SQLException {
		setNo(rs.getInt("no"));
		setCookie_no(rs.getInt("cookie_no"));
		setCookie_name(rs.getString("cookie_name"));
		setCookie_value(rs.getString("cookie_value"));
		setBoard_no(rs.getInt("board_no"));
		setBoard_item_no(rs.getInt("board_item_no"));
		setWriter(rs.getString("writer"));
	}
	
	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public int getCookie_no() {
		return cookie_no;
	}

	public void setCookie_no(int cookie_no) {
		this.cookie_no = cookie_no;
	}

	public String getCookie_name() {
		return cookie_name;
	}

	public void setCookie_name(String cookie_name) {
		this.cookie_name = cookie_name;
	}

	public String getCookie_value() {
		return cookie_value;
	}

	public void setCookie_value(String cookie_value) {
		this.cookie_value = cookie_value;
	}

	public int getBoard_no() {
		return board_no;
	}

	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}

	public int getBoard_item_no() {
		return board_item_no;
	}

	public void setBoard_item_no(int board_item_no) {
		this.board_item_no = board_item_no;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	@Override
	public String toString() {
		return "Cookie [no=" + no + ", cookie_no=" + cookie_no + ", cookie_name=" + cookie_name + ", cookie_value="
				+ cookie_value + ", board_no=" + board_no + ", board_item_no=" + board_item_no + ", writer=" + writer
				+ "]";
	}
	
}
