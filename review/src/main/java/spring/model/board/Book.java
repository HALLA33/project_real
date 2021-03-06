package spring.model.board;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

public class Book {
	private int no;
	private String title;
    private String link;
    private String image;
    private String author;
    private String price;
    private String discount;
    private String publisher;
    private String pubdate;
    private String isbn;
    private String description;
    
    public Book() {}
    
    public Book(ResultSet rs) throws SQLException {
		setNo(rs.getInt("no"));
		setTitle(rs.getString("title"));
		setImage(rs.getString("image"));
		setAuthor(rs.getString("author"));
		setPublisher(rs.getString("publisher"));
		setPubdate(rs.getString("pubdate"));
	}
    public Book(HttpServletRequest request) {
    	setTitle(request.getParameter("title"));
    	setLink(request.getParameter("link"));
    	setImage(request.getParameter("image"));
    	setAuthor(request.getParameter("author"));
    	setPrice(request.getParameter("price"));
    	setDiscount(request.getParameter("discount"));
    	setPublisher(request.getParameter("publisher"));
    	setPubdate(request.getParameter("pubdate"));
    	setIsbn(request.getParameter("isbn"));
    	setDescription(request.getParameter("description"));
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
    public String getLink() {
        return link;
    }
    public void setLink(String link) {
        this.link = link;
    }
    public String getImage() {
        return image;
    }
    public void setImage(String image) {
        this.image = image;
    }
    public String getAuthor() {
        return author;
    }
    public void setAuthor(String author) {
        this.author = author;
    }
    public String getPrice() {
        return price;
    }
    public void setPrice(String price) {
        this.price = price;
    }
    public String getDiscount() {
        return discount;
    }
    public void setDiscount(String discount) {
        this.discount = discount;
    }
    public String getPublisher() {
        return publisher;
    }
    public void setPublisher(String publisher) {
        this.publisher = publisher;
    }
    public String getPubdate() {
        return pubdate;
    }
    public void setPubdate(String pubdate) {
        this.pubdate = pubdate;
    }
    public String getIsbn() {
        return isbn;
    }
    public void setIsbn(String isbn) {
        this.isbn = isbn;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    @Override
    public String toString() {
        return "Book [title=" + title + ", link=" + link + ", image=" + image + ", author=" + author + ", price=" + price
                + ", discount=" + discount + ", publisher=" + publisher + ", pubdate=" + pubdate + ", isbn=" + isbn
                + ", description=" + description + "]";
    }

}
