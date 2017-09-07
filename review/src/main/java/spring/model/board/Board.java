package spring.model.board;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Board {
	private int no;
	private int item_no;
	private int head;
	private String tag;
	private String writer;
	private String title;
	private String detail;
	private String reg;
	private int read;
	private int reply;
	private int good;
	private int bad;
	private String notice;
	private int search_no;
	
	public Board() {}
	
	public Board(ResultSet rs) throws SQLException {
		setNo(rs.getInt("no"));
		setItem_no(rs.getInt("item_no"));
		setHead(rs.getInt("head"));
		setTag(rs.getString("tag"));
		setWriter(rs.getString("writer"));
		setTitle(rs.getString("title"));
		setDetail(rs.getString("detail"));
		setReg(rs.getString("reg"));
		setRead(rs.getInt("read"));
		setReply(rs.getInt("reply"));
		setGood(rs.getInt("good"));
		setBad(rs.getInt("bad"));
		setNotice(rs.getString("notice"));
		setSearch_no(rs.getInt("search_no"));
	}
	
	
	public int getSearch_no() {
		return search_no;
	}

	public void setSearch_no(int search_no) {
		this.search_no = search_no;
	}

	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public int getItem_no() {
		return item_no;
	}
	public void setItem_no(int item_no) {
		this.item_no = item_no;
	}
	public int getHead() {
		return head;
	}
	public void setHead(int head) {
		this.head = head;
	}
	public String getTag() {
		return tag;
	}
	public void setTag(String tag) {
		this.tag = tag;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getDetail() {
		return detail;
	}
	public void setDetail(String detail) {
		this.detail = detail;
	}
	public String getReg() {
		return reg;
	}
	public void setReg(String reg) {
		this.reg = reg;
	}
	public int getRead() {
		return read;
	}
	public void setRead(int read) {
		this.read = read;
	}
	public int getReply() {
		return reply;
	}
	public void setReply(int reply) {
		this.reply = reply;
	}
	public int getGood() {
		return good;
	}
	public void setGood(int good) {
		this.good = good;
	}
	public int getBad() {
		return bad;
	}
	public void setBad(int bad) {
		this.bad = bad;
	}
	public String getNotice() {
		return notice;
	}
	public void setNotice(String notice) {
		this.notice = notice;
	}

	@Override
	public String toString() {
		return "Board [no=" + no + ", item_no=" + item_no + ", head=" + head + ", tag=" + tag + ", writer=" + writer
				+ ", title=" + title + ", detail=" + detail + ", reg=" + reg + ", read=" + read + ", reply=" + reply
				+ ", good=" + good + ", bad=" + bad + ", notice=" + notice + ", search_no=" + search_no + "]";
	}

	
}
