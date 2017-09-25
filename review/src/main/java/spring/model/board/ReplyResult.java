package spring.model.board;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ReplyResult {
	private int first;
	private int second;
	private int last;
	
	public ReplyResult() {
		super();
	}
	
	public ReplyResult(ResultSet rs) throws SQLException {
		setFirst(rs.getInt("first"));
		setSecond(rs.getInt("second"));
		setLast(rs.getInt("last"));
	}
	
	public int getfirst() {
		return first;
	}

	public void setFirst(int first) {
		this.first = first;
	}

	public int getSecond() {
		return second;
	}

	public void setSecond(int second) {
		this.second = second;
	}

	public int getLast() {
		return last;
	}

	public void setLast(int last) {
		this.last = last;
	}

	@Override
	public String toString() {
		return "ReplyResult [first=" + first + ", second=" + second + ", last=" + last + "]";
	}
	
	
}
