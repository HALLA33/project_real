package spring.model.member;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Tags {
	
	private int no;
	private String tag;
	
	 public Tags() {
	      super();
	   }
	 

	   public int getNo() {
		return no;
	}


	public void setNo(int no) {
		this.no = no;
	}


	public String getTag() {
		return tag;
	}


	public void setTag(String tag) {
		this.tag = tag;
	}


	public Tags(ResultSet rs) throws SQLException {
	      this.setNo(rs.getInt("no"));
	      this.setTag(rs.getString("tag"));
	   }

}
