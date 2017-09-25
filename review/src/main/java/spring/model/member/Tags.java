package spring.model.member;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Tags {
	
	private int no;
	private String tag;
	private int write_no;
	private int item_no;

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
	
	public int getWrite_no() {
		return write_no;
	}


	public void setWrite_no(int write_no) {
		this.write_no = write_no;
	}


	public int getItem_no() {
		return item_no;
	}


	public void setItem_no(int item_no) {
		this.item_no = item_no;
	}

	public Tags(ResultSet rs) throws SQLException {
	      this.setTag(rs.getString("tag"));
	   }

}
