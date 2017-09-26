package spring.model.board;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;

public class Reply {
	private String title;
	private int no;
	private String writer;
	private String ninkname;
	private String detail;
	private String reg;
	private int board_no;
	private int board_item_no;
	private int gno;
	private int gseq;
	private int depth;
	
	public Reply() {
		super();
	}
	
	public Reply(HttpServletRequest request) {
		setTitle(request.getParameter("title"));
		setWriter(request.getParameter("writer"));
		setDetail(request.getParameter("detail"));
		setBoard_no(Integer.parseInt(request.getParameter("board_no")));
		setBoard_item_no(Integer.parseInt(request.getParameter("board_item_no")));
		setGno(Integer.parseInt(request.getParameter("gno")));
		setGseq(Integer.parseInt(request.getParameter("gseq")));
		setDepth(Integer.parseInt(request.getParameter("depth")));
	}
	
	public Reply(ResultSet rs) throws SQLException {
		setTitle(rs.getString("title"));
		setNo(rs.getInt("no"));
		setWriter(rs.getString("writer"));
		setDetail(rs.getString("detail"));
		setReg(rs.getString("reg"));
		setBoard_no(rs.getInt("board_no"));
		setBoard_item_no(rs.getInt("board_item_no"));
		setGno(rs.getInt("gno"));
		setGseq(rs.getInt("gseq"));
		setDepth(rs.getInt("depth"));
	}
	
	

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public int getNo() {
		return no;
	}

	public void setNo(int no) {
		this.no = no;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getNinkname() {
		return ninkname;
	}

	public void setNinkname(String ninkname) {
		this.ninkname = ninkname;
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

	public String getDate() {
		return reg.substring(0, 10);
	}
	
	public String getTime() {
		return reg.substring(11, 16);
	}
	
	public String getAuto() {
		String today = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
		if(today.equals(getDate())) 
			return getTime();
		else
			return getDate();
	}
	
	public int getBoard_no() {
		return board_no;
	}

	public void setBoard_no(int board_no) {
		this.board_no = board_no;
	}

	public int getBoard_item_no() {
		return board_item_no;
	}

	public void setBoard_item_no(int board_item_no) {
		this.board_item_no = board_item_no;
	}

	public int getGno() {
		return gno;
	}

	public void setGno(int gno) {
		this.gno = gno;
	}

	public int getGseq() {
		return gseq;
	}

	public void setGseq(int gseq) {
		this.gseq = gseq;
	}

	public int getDepth() {
		return depth;
	}

	public void setDepth(int depth) {
		this.depth = depth;
	}

	@Override
	public String toString() {
		return "Reply [no=" + no + ", writer=" + writer + ", detail=" + detail + ", reg=" + reg + ", board_no="
				+ board_no + ", board_item_no=" + board_item_no + ", gno=" + gno + ", gseq="
				+ gseq + ", depth=" + depth+ "]";
	}
	
}
