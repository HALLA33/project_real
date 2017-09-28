package spring.model.shop;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Userbuy {
	
	private int no;
	private String item_path;
	private String itemname;
	private String client;
	private int postnum;
	private String address;
	private String address2;
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
	public String getClient() {
		return client;
	}
	public void setClient(String client) {
		this.client = client;
	}
	public int getPostnum() {
		return postnum;
	}
	public void setPostnum(int postnum) {
		this.postnum = postnum;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getAddress2() {
		return address2;
	}
	public void setAddress2(String address2) {
		this.address2 = address2;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public Userbuy() {
		super();
	}
	
	public Userbuy(ResultSet rs) throws SQLException {
		this.setAddress(rs.getString("address"));
		this.setAddress2(rs.getString("address2"));
		this.setClient(rs.getString("client"));
		this.setItemname(rs.getString("itemname"));
		this.setNo(rs.getInt("no"));
		this.setPostnum(rs.getInt("postnum"));
		this.setStatus(rs.getString("status"));
		this.setItem_path(rs.getString("item_path"));
	}

}
