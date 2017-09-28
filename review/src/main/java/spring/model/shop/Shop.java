package spring.model.shop;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Shop {
	
	private int no;
	private String title;
	private String savename;
	private String type;
	private long lan;
	private String reg;
	private int point;
	
	
	
	public Shop() {
		super();
	}
	
	public Shop(ResultSet rs) throws SQLException {
		this.setNo(rs.getInt("no"));
		this.setTitle(rs.getString("title"));
		this.setSavename(rs.getString("savename"));
		this.setType(rs.getString("type"));
		this.setLan(rs.getLong("lan"));
		this.setReg(rs.getString("reg"));
		this.setPoint(rs.getInt("point"));
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
	public String getSavename() {
		return savename;
	}
	public void setSavename(String savename) {
		this.savename = savename;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public long getLan() {
		return lan;
	}
	public void setLan(long lan) {
		this.lan = lan;
	}
	public String getReg() {
		return reg;
	}
	public void setReg(String reg) {
		this.reg = reg;
	}
	public int getPoint() {
		return point;
	}
	public void setPoint(int point) {
		this.point = point;
	}
	
	

}
