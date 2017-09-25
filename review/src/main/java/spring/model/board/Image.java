package spring.model.board;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Image {
	private int no;
	private String originFileName;
	private String moveFileName;
	
	public Image() {
		super();
	}
	
	public Image(ResultSet rs) throws SQLException {
		setNo(rs.getInt("no"));
		setOriginFileName(rs.getString("origin_filename"));
		setMoveFileName(rs.getString("move_filename"));
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getOriginFileName() {
		return originFileName;
	}

	public void setOriginFileName(String originFileName) {
		this.originFileName = originFileName;
	}

	public String getMoveFileName() {
		return moveFileName;
	}

	public void setMoveFileName(String moveFileName) {
		this.moveFileName = moveFileName;
	}

	@Override
	public String toString() {
		return "Image [no=" + no + ", originFileName=" + originFileName + ", moveFileName=" + moveFileName + "]";
	}
	
}
