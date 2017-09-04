package spring.model.member;

import java.sql.Date;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Member {
	
	private int no;
	private String id;
	private String pw;
	private String nickname;
	private String email;
	private String name;
	private String gender;
	private String birth;
	private String telecom;
	private String phone;
	private String power;
	private int point;
	private Date reg;
	private Date lastvisit;
	private int visitnumber;
	private int writenumber;
	private int replynumber;
	private String enabled;
	
public Member() {
		super();
	}



	public int getNo() {
	return no;
}



public void setNo(int no) {
	this.no = no;
}



public String getId() {
	return id;
}



public void setId(String id) {
	this.id = id;
}



public String getPw() {
	return pw;
}



public void setPw(String pw) {
	this.pw = pw;
}



public String getNickname() {
	return nickname;
}



public void setNickname(String nickname) {
	this.nickname = nickname;
}



public String getEmail() {
	return email;
}



public void setEmail(String email) {
	this.email = email;
}



public String getName() {
	return name;
}



public void setName(String name) {
	this.name = name;
}



public String getGender() {
	return gender;
}



public void setGender(String gender) {
	this.gender = gender;
}



public String getBirth() {
	return birth;
}



public void setBirth(String birth) {
	this.birth = birth;
}



public String getTelecom() {
	return telecom;
}



public void setTelecom(String telecom) {
	this.telecom = telecom;
}



public String getPhone() {
	return phone;
}



public void setPhone(String phone) {
	this.phone = phone;
}



public String getPower() {
	return power;
}



public void setPower(String power) {
	this.power = power;
}



public int getPoint() {
	return point;
}



public void setPoint(int point) {
	this.point = point;
}



public Date getReg() {
	return reg;
}



public void setReg(Date reg) {
	this.reg = reg;
}



public Date getLastvisit() {
	return lastvisit;
}



public void setLastvisit(Date lastvisit) {
	this.lastvisit = lastvisit;
}



public int getVisitnumber() {
	return visitnumber;
}



public void setVisitnumber(int visitnumber) {
	this.visitnumber = visitnumber;
}



public int getWritenumber() {
	return writenumber;
}



public void setWritenumber(int writenumber) {
	this.writenumber = writenumber;
}



public int getReplynumber() {
	return replynumber;
}



public void setReplynumber(int replynumber) {
	this.replynumber = replynumber;
}



public String getEnabled() {
	return enabled;
}



public void setEnabled(String enabled) {
	this.enabled = enabled;
}

	public Member(ResultSet rs) throws SQLException {
		this.setNo(rs.getInt("no"));
		this.setId(rs.getString("id"));
		this.setPw(rs.getString("pw"));
		this.setNickname(rs.getString("nickname"));
		this.setEmail(rs.getString("email"));
		this.setName(rs.getString("name"));
		this.setGender(rs.getString("gender"));
		this.setBirth(rs.getString("birth"));
		this.setPower(rs.getString("power"));
		this.setTelecom(rs.getString("telecom"));
		this.setPhone(rs.getString("phone"));
		this.setPoint(rs.getInt("point"));
		this.setReg(rs.getDate("reg"));
		this.setLastvisit(rs.getDate("lastvisit"));
		this.setVisitnumber(rs.getInt("visitnumber"));
		this.setWritenumber(rs.getInt("writenumber"));
		this.setReplynumber(rs.getInt("replynumber"));
		this.setEnabled(rs.getString("enabled"));
	}
	@Override
	public String toString() {
		return "Member [no=" + no + ", id=" + id + ", pw=" + pw + ", nickname=" + nickname + ", email=" + email
				+ ", name=" + name + ", gender=" + gender + ", birth=" + birth + ", telecom=" + telecom + ", phone="
				+ phone + ", power=" + power + ", point=" + point + ", reg=" + reg + ", lastvisit=" + lastvisit
				+ ", visitnumber=" + visitnumber + ", writenumber=" + writenumber + ", replynumber=" + replynumber
				+ ", enabled=" + enabled + "]";
	}
	

}
