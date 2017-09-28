package spring.model.shop;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Mybuy {

	private int no;
	private String item_path;
	private String itemname;
	private String id;
	private String reg;
	private String status;
	
	public String getItem_path() {
		return item_path;
	}
	public void setItem_path(String item_path) {
		this.item_path = item_path;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getItemname() {
		return itemname;
	}
	public void setItemname(String itemname) {
		this.itemname = itemname;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getReg() {
		return reg;
	}
	public void setReg(String rag) {
		this.reg = rag;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Mybuy() {
		super();
	}
	
	public Mybuy(ResultSet rs) throws SQLException {
		this.setId(rs.getString("id"));
		this.setItem_path(rs.getString("item_path"));
		this.setItemname(rs.getString("itemname"));
		this.setNo(rs.getInt("no"));
		this.setReg(rs.getString("reg"));
		this.setStatus(rs.getString("status"));
	}

	
}
