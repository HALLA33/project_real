package spring.model.board;

import java.sql.ResultSet;
import java.sql.SQLException;

public class Board {
	private int no;
	private int item_no;
	private String b_item_no;
	private int head;
	private String b_head;
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
	private String emotion;
	private String weather;
	
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
		setEmotion(rs.getString("emotion"));
		setWeather(rs.getString("weather"));
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
	public String getB_item_no() {
		return b_item_no;
	}

	public void setB_item_no(int item_no) {
		switch(item_no) {
		case 0:
			b_item_no = "공지";
			break;
		case 1:
			b_item_no = "국내도서";
			break;
		case 2:
			b_item_no = "해외도서";
			break;
		case 3:
			b_item_no = "국내영화";
			break;
		case 4:
			b_item_no = "해외영화";
			break;
		case 5:
			b_item_no = "공연";
			break;
		case 6:
			b_item_no = "기타";
			break;
		}
	}
	public int getHead() {
		return head;
	}
	public void setHead(int head) {
		this.head = head;
	}
	public String getB_head() {
		return b_head;
	}

	public void setB_head(int head) {
		switch(head) {
		case 1:
			b_head = "SF/판타지/무협";
			break;
		case 2:
			b_head = "추리";
			break;
		case 3:
			b_head = "로맨스";
			break;
		case 4:
			b_head = "공포/스릴러";
			break;
		case 5:
			b_head = "역사";
			break;
		case 6:
			b_head = "시/에세이";
			break;
		case 7:
			b_head = "철학/종교";
			break;
		case 8:
			b_head = "과학";
			break;
		case 9: case 199: case 299:
			b_head = "기타";
			break;
		case 101:
			b_head = "SF/판타지";
			break;
		case 102:
			b_head = "드라마";
			break;
		case 103:
			b_head = "전쟁/모험";
			break;
		case 104:
			b_head = "미스터리/스릴러";
			break;
		case 105:
			b_head = "애니메이션";
			break;
		case 106:
			b_head = "코미디";
			break;
		case 107:
			b_head = "액션/느와르";
			break;
		case 201:
			b_head = "뮤지컬";
			break;
		case 202:
			b_head = "음악회";
			break;
		case 203:
			b_head = "축제";
			break;	
		}
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

	
	public String getEmotion() {
		return emotion;
	}

	public void setEmotion(String emotion) {
		this.emotion = emotion;
	}

	public String getWeather() {
		return weather;
	}

	public void setWeather(String weather) {
		this.weather = weather;
	}

	@Override
	public String toString() {
		return "Board [no=" + no + ", item_no=" + item_no + ", head=" + head + ", tag=" + tag + ", writer=" + writer
				+ ", title=" + title + ", detail=" + detail + ", reg=" + reg + ", read=" + read + ", reply=" + reply
				+ ", good=" + good + ", bad=" + bad + ", notice=" + notice + ", search_no=" + search_no + "]";
	}

	
}
