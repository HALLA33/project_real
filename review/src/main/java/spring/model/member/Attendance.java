package spring.model.member;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.stereotype.Component;

import java.sql.Date;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Date;

public class Attendance {
   private int rank;
   private String reg_check;
   private String greetings;
   private String nick;
   private int point;
   private int opening;
   private int total_check;
   
   public Attendance() {
      super();
   }

   public Attendance(ResultSet rs) throws SQLException {
      this.setRank(rs.getInt("rank"));
      this.setReg_check(rs.getString("reg_check"));
      this.setGreetings(rs.getString("greetings"));
      this.setNick(rs.getString("nick"));
      this.setPoint(rs.getInt("point"));
      this.setOpening(rs.getInt("opening"));
      this.setTotal_check(rs.getInt("total_check"));
   }
   
   public int getRank() {
      return rank;
   }
   public void setRank(int rank) {
      this.rank = rank;
   }
   public String getReg_check() {
      return reg_check;
   }
   public void setReg_check(String reg_check) {
      this.reg_check = reg_check;
   }
   public String getGreetings() {
      return greetings;
   }
   public void setGreetings(String greetings) {
      this.greetings = greetings;
   }
   public String getNick() {
      return nick;
   }
   public void setNick(String nick) {
      this.nick = nick;
   }
   public int getPoint() {
      return point;
   }
   public void setPoint(int point) {
      this.point = point;
   }
   public int getOpening() {
      return opening;
   }
   public void setOpening(int opening) {
      this.opening = opening;
   }
   public int getTotal_check() {
      return total_check;
   }
   public void setTotal_check(int total_check) {
      this.total_check = total_check;
   }
   
}