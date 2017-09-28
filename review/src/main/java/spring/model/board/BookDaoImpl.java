
package spring.model.board;

import java.sql.ResultSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.ResultSetExtractor;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import spring.model.member.Tags;

@Repository("bookDao")
public class BookDaoImpl implements BookDao{
   private Logger log = LoggerFactory.getLogger(getClass());
   private Map<Integer, Book> map = new HashMap<>(); 
   
   @Autowired
   private JdbcTemplate jdbcTemplate;
   
   private RowMapper<Board> mapper = (rs, index)->{
      return new Board(rs);
   };
   
   private RowMapper<Tags> mapper2 = (rs, index) -> {
      return new Tags(rs);
   };
   
   private RowMapper<Book> bmapper = (rs, index)->{
      return new Book(rs);
   };
   
   private RowMapper<Image> imapper = (rs, index)->{
      return new Image(rs);
   };
   
   ResultSetExtractor<Board> extractor = (ResultSet arg0) -> {
      if(arg0.next())
         return new Board(arg0);
      else 
         return null;
   };
   
   @Override
   public List<Board> board_list(int start, int end, int item_no, int head, int align, String tag, String word) {
      
//      System.out.println("sql head="+head);
//      System.out.println("sql align="+align);
      tag = "#"+tag;
      String realtag = "";
      System.out.println("tag : "+ tag);
      String headPlus = "";
      if(head > 0) {headPlus = "and head=? ";}
      String boardAlign = "reg ";
      if(align!=0) {
         boardAlign = "read ";
      }
      
      String sql = "select * from (select rownum rn, TMP.* from "
                     + "(select * from p_board where item_no=? "
                     +headPlus+"order by "+boardAlign+"desc) TMP) "
                     + "where rn between ? and ?";
      
      if(item_no == 8 && head == 0) {
               sql = "select * from p_board where tag is not null";
               
               List<Board> list = jdbcTemplate.query(sql, mapper);

               for(int i = 0; i < list.size(); i++){                  
                   String[] tags = list.get(i).getTag().split("/");
                   System.out.println("length" + tags.length);
                   for(String s : tags){
                      if(s.equals(tag)) {
                         log.info(tag);
                         System.out.println("start : " + start);
                         System.out.println("end : " + end);
                           sql = "select * from (select rownum rn, TMP.* from "
                                 + "(select * from p_board where tag like '%'||?||'%' "
                                 +"order by "+boardAlign+"desc) TMP) "
                                 + "where rn between ? and ?";
                      }
                   }
               }
            }
         if(item_no == 9) {
            System.out.println("검색");
            Object[] args = {word, word, word, word};
            //sql = "select * from p_board where search_artist like '%'||?||'%' or search_title like '%'||?||'%' or detail like '%'||?||'%' order by reg desc";
            // 전체 검색에서 공지, 기타, 자유게시판 제외
            sql = "select * from "
                  + "( select item_no ino, TMP.* from "
                     + "( select * from p_board where search_artist like "
                     + "'%'||?||'%' or search_title like '%'||?||'%' or detail like '%'||?||'%' or title like '%'||?||'%' order by reg desc )TMP ) "
                  + "where ino not in(0, 5, 7)";
            System.out.println("item_no:9 = " + sql);
            System.out.println(jdbcTemplate.query(sql, args, mapper).isEmpty());
            return jdbcTemplate.query(sql, args, mapper);
         }
      
                  System.out.println("sql = "+sql);
                  System.out.println("item_no="+item_no+", boardAlign="+boardAlign);
                  System.out.println("s="+start+", e="+end);
      
                  if(head == -1) {
                     Object[] args = {item_no, start, end};
//                     System.out.println("args = "+Arrays.toString(args));
                     return jdbcTemplate.query(sql, args, mapper);
                  }else if(head == 0){
                     Object[] args = {tag, start, end};
                     return jdbcTemplate.query(sql, args, mapper);
                  }else {
                     Object[] args = {item_no, head,  start, end};
//                     System.out.println("args = "+Arrays.toString(args));
                     return jdbcTemplate.query(sql, args, mapper);
                  }

}
   @Override
   public Map<Integer, Book> book_list(int no) {
      Object[] args = {no};
      List<Book> list = jdbcTemplate.query("select * from p_search_book where no=?", args, bmapper);
      
      for(Book book: list) {
         map.put(no, book);
      }
      
      //Book book = list.get(0);
      
      return map;
   }

   public int search_no() {
      int no = 0;
      String sql = "select p_search_book_seq.nextval from dual";
      try {
         no = jdbcTemplate.queryForObject(sql, Integer.class);
      }catch(EmptyResultDataAccessException e) {
         no = 0;
      }
      
      
      return no;
   }
   
   @Override
   public int search_write(Book book) {
      int no = search_no();
      
      String sql = "insert into p_search_book values(?, ?, ?, ?, ?, ?)";
      Object[] args = {no, book.getTitle(), book.getImage(), book.getAuthor(), book.getPublisher(), book.getPubdate()};
      
      log.info("search_write실행", book.toString());
      jdbcTemplate.update(sql, args);
      
      return no;
   }
   
   public int seq_number(String seq) {
      seq += ".nextval";
      String sql = "select " + seq + " from dual";
      
      int no = 0;
      try {
         no = jdbcTemplate.queryForObject(sql, Integer.class);
      }catch(EmptyResultDataAccessException e) {
         no = 0;
      }
      
      return no;
   }
   
   @Override
   public int write(Board board, int no) {
      String sql = "insert into p_board values(?, ?, ?, ?, ?, ?, ?, sysdate, 0, 0, 0, 0, ?, ?, ?, ?, ?, ?)";
      String seq = null;
      switch(board.getItem_no()) {
      case 0 : seq = "p_board_notice_seq"; break;
      case 1 : seq = "p_board_kbook_seq"; break;
      case 2 : seq = "p_board_obook_seq"; break;
      case 3 : seq = "p_board_kmovie_seq"; break;
      case 4 : seq = "p_board_omovie_seq"; break;
      case 5 : seq = "p_board_con_seq"; break;
      case 6 : seq = "p_board_etc_seq"; break;
      case 7 : seq = "p_board_free_seq"; break;
      }
      
      int seq_number = seq_number(seq);
      String nickname = board.getWriter();
      if(board.getEmotion()==null) board.setEmotion("없음");
      if(board.getWeather()==null) board.setWeather("없음");
      
      Object[] args = {
            seq_number, board.getItem_no(), board.getHead(), board.getTag(), 
            board.getWriter(), board.getTitle(), board.getDetail(), board.getNotice(), no, 
            board.getEmotion(), board.getWeather(), board.getSearch_title(), board.getSearch_artist()
            };
      
      jdbcTemplate.update(sql, args);
      
      sql = "update p_member set writenumber = writenumber +1 where id = ?";
      
      jdbcTemplate.update(sql, new Object[] {nickname});
      
      if(board.getTag() != null) {
         
         String[] tags = board.getTag().replace("#", "").split("/");
         
         for(String s : tags) {
            
            sql = "insert into tags values(tags_seq.nextval, ?, ? ,?)";
            
            jdbcTemplate.update(sql, new Object[] {s, seq_number, board.getItem_no()});
            
         }
         
      }
      sql = "select todaywrite from p_member where id  = ?";
      
      
      
      int todaywrite = 0; 
      try {
         todaywrite = jdbcTemplate.queryForObject(sql, new Object[] {nickname}, Integer.class);
      }catch(EmptyResultDataAccessException e) {
         todaywrite = 3;
      }
      
      int tagpoint = 0;
      int emonwea = 0;
      
      if(board.getTag() != null) {
    	  tagpoint = 5;
      }
      
      if(board.getEmotion() != "없음" && board.getWeather() == "없음" ||
    		  board.getWeather() == "없음" && board.getWeather() != "없음") {
    	  emonwea = 5;
      }else if(board.getEmotion() != "없음" && board.getWeather() != "없음"){
    	  emonwea = 10;
      }
      
   
      if(todaywrite < 3) {
         sql = "update p_member set point = point +10 + ? + ?, todaywrite = todaywrite + 1, "
               + "totalpoint = totalpoint + 10 + ? + ? where id = ?";
         
         jdbcTemplate.update(sql, new Object[] {tagpoint, emonwea, nickname, tagpoint, emonwea});
      }
      
      return seq_number;
   }

   @Override
   public int count(int item_no) {      
      String sql = "select count(*) from p_board where item_no=?";
      
      Object[] args = {item_no};
      int count = 0;
      try {
         count = jdbcTemplate.queryForObject(sql, args, Integer.class);
      }catch(EmptyResultDataAccessException e) {
         count = 0;
      }
      return count;
   }
   
   public int count2(String tag) {      
      String sql = "select count(*) from tags where tag=?";
      
      Object[] args = {tag};
      int count = 0;
      try {
         count = jdbcTemplate.queryForObject(sql, args, Integer.class);
      }catch(EmptyResultDataAccessException e) {
         count = 0;
      }
      return count;
   }

   @Override
   public String search_nickname(String id) {
      String sql = "select nickname from p_member where id=?";
      
      Object[] args = {id};
      try {
         return jdbcTemplate.queryForObject(sql, args, String.class );
      }catch(EmptyResultDataAccessException e) {
         return "탈퇴한 아이디입니다";
      }
      

   }

   @Override
   public List<Book> exist_book(Book book) {
      String sql = "select * from p_search_book where title=? and author=?";
      
      Object[] args = {book.getTitle(), book.getAuthor()};   
      return jdbcTemplate.query(sql, args, bmapper);

   }

   @Override
   public Book detail_book(int no) {
      String sql = "select * from p_search_book where no=?";
      
      Object[] args = {no};
      List<Book> list = jdbcTemplate.query(sql, args, bmapper);
      
      return list.get(0);
   }

   @Override
   public Board detail_board(int no, int item_no) {
      String sql = "select * from p_board where no=? and item_no=?";
      Object[] args = {no, item_no};
      return jdbcTemplate.query(sql, args, extractor);
   }
   
   @Override
   public Board detail_board(int no, int item_no, String writer) {
      String sql = "select * from p_board where no=? and item_no=? and writer=?";
      
      Object[] args = {no, item_no, writer};
      
      return jdbcTemplate.query(sql, args, extractor);
      
      
   }

   @Override
   public void update_board(Board board, int no, int item_no, String writer, String tag) {      
      String sql = "update p_board set item_no=?, head=?, tag=?, title=?, detail=?, reg=sysdate, search_no=?, emotion=?, weather=? where no=? and item_no=? and writer=?";
      
      Object[] args = {board.getItem_no(), board.getHead(), board.getTag(), board.getTitle(), board.getDetail(),
                     board.getSearch_no(), board.getEmotion(), board.getWeather(),no, item_no, writer};
      
      jdbcTemplate.update(sql, args);
      
      if(tag.equals("#")) tag = null;
      
      sql = "delete from tags where write_no = ? and item_no = ?";
      
      jdbcTemplate.update(sql, new Object[] {no, item_no});

      if(tag != null) {
         
         String[] tags = tag.replace("#", "").split("/");
         
         for(String s : tags) {
            sql = "insert into tags values(tags_seq.nextval, ?, ? ,?)";
            
            jdbcTemplate.update(sql, new Object[] {s, no, item_no});
         }
      }
   }

   @Override
   public void delete_board(int no, int item_no, String id, String tag) {
      String sql = "delete from p_board where no=? and item_no=? and writer=?";
      
      Object[] args = {no, item_no, id};
      
      jdbcTemplate.update(sql, args);
      
      log.info("딜리트 id : " + id);
      
      sql = "update p_member set writenumber = writenumber -1 where id = ?";
            
      jdbcTemplate.update(sql, new Object[] {id});   
      
      if(tag != null) {
         
         String[] tags = tag.replace("#", "").split("/");
         
         for(String s : tags) {
            sql = "delete from tags where write_no = ? and item_no = ? and tag = ? ";
            
            jdbcTemplate.update(sql, new Object[] {no, item_no, s});
         }
         
      }
      
   }

   @Override
   public void plus_minus_Count(int flag, int no, int item_no) {
      String sql = null;
      
      switch(flag) {
      case 0:
         sql = "update p_board set read=read+1 where no=? and item_no=?";   //조회수 증가
         break;
      case 1:
         sql = "update p_board set good=good+1 where no=? and item_no=?";   //좋아요 증가
         break;
      case 2:
         boolean check = zero_check(2, no, item_no);
         if(check)
            sql = "update p_board set good=good-1 where no=? and item_no=?";   //좋아요 감소
         else
            sql = "update p_board set good=0 where no=? and item_no=?";
         break;
      case 3:
         sql = "update p_board set bad=bad+1 where no=? and item_no=?";      //싫어요 증가
         break;
      case 4:
         check = zero_check(4, no, item_no);
         if(check)
            sql = "update p_board set bad=bad-1 where no=? and item_no=?";      //싫어요 감소
         else
            sql = "update p_board set bad=0 where no=? and item_no=?";
         break;
      } 
      
      Object[] args = {no, item_no};
      
      jdbcTemplate.update(sql, args);
   }

   public boolean zero_check(int flag, int no, int item_no) {
      String sql = null;
      int number = 0;
      
      if(flag==2) {
         sql = "select good from p_board where no=? and item_no=?";
         Object[] args = {no, item_no};
         try {
            number = jdbcTemplate.queryForObject(sql, args, Integer.class);
         }catch(EmptyResultDataAccessException e) {
            number = 0;
         }
      }
      else {
         sql = "select bad from p_board where no=? and item_no=?";
         Object[] args = {no, item_no};
         
         try {
            number = jdbcTemplate.queryForObject(sql, args, Integer.class);
         }catch(EmptyResultDataAccessException e) {
            number = 0;
         }
         
      }
      
      if(number<=0)
         return false;
      else
         return true;
   }

   @Override
   public void insert_cookie(int cookie_no, String cookie_name, String cookie_value, int board_no, int board_item_no, String writer) {
      String sql = "insert into cookie values (cookie_seq.nextval, ?, ?, ?, ?, ?, ?)";
      Object[] args = {cookie_no, cookie_name, cookie_value, board_no, board_item_no, writer};
      
      jdbcTemplate.update(sql, args);
   }
   
   @Override
   public void delete_cookie(int cookie_no, String writer) {
      String sql = "delete from cookie where cookie_no=? and writer=?";
      Object[] args = {cookie_no, writer};
      
      jdbcTemplate.update(sql, args);
   }

   @Override
   public void board_delete_cookie(int board_no, int board_item_no) {
      String sql = "delete from cookie where board_no=? and board_item_no=?";
      Object[] args = {board_no, board_item_no};
      
      jdbcTemplate.update(sql, args);
   }
   @Override
   public int getpoint(String nickname) {
      int point = 0;
      log.info(nickname);
      
      String sql = "select point from p_member where nickname = ?";
      try {
         point  = jdbcTemplate.queryForObject(sql, new Object[] {nickname}, Integer.class);
      }catch(EmptyResultDataAccessException e) {
         point  = 0;
      }
      
      System.out.println("point : " + point);
      
      return point;
   }

   @Override
   public void delete_board(int no, int item_no, String tag) {
      String sql = "delete from p_board where no=? and item_no=?";
      
      Object[] args = {no, item_no};
      
      jdbcTemplate.update(sql, args);   
      
      if(tag != null) {
         
         String[] tags = tag.replace("#", "").split("/");
         
         for(String s : tags) {
            sql = "delete from tags where write_no = ? and item_no = ? and tag = ? ";
            
            jdbcTemplate.update(sql, new Object[] {no, item_no, s});
         }
         
      }
      
   }
   @Override
   public List<Tags> taglist() {
      String sql = "select * from (select rownum rn, A.* from (select distinct tag, min(no) from "
            + "tags group by tag order by min(no) desc, tag)A) where rn between 1 and 10";
      
      List<Tags> list = jdbcTemplate.query(sql, mapper2);
      
      return list;
   }
   
   @Override
   public void upload_image(int board_no, int board_item_no, String originFileName, String moveFileName) {
      String sql = "insert into uploadImage values (uploadImage_seq.nextval, ?, ?, ?, ?)";
      
      Object[] args = {board_no, board_item_no, originFileName, moveFileName};
      
      jdbcTemplate.update(sql, args);
   }

   @Override
   public List<Image> delete_image(int board_no, int board_item_no) {
      List<Image> image_name = detail_board_image(board_no, board_item_no);
      
      String sql = "delete from uploadImage where board_no=? and board_item_no=?";
      Object[] arg = {board_no, board_item_no};
      
      jdbcTemplate.update(sql, arg);
      
      return image_name;
   }

   @Override
   public List<Image> detail_board_image(int board_no, int board_item_no) {
      String sql = "select * from uploadImage where board_no=? and board_item_no=?";
      Object[] args = {board_no, board_item_no};
      
      List<Image> image_name = jdbcTemplate.query(sql, args, imapper);
      
      return image_name;
   }
   @Override
   public List<Board> recomTwo(String emo, String wea) {
      String sql = "select * from p_board where emotion=? and weather=? order by read desc";
      Object[] args = {emo, wea};
      return jdbcTemplate.query(sql, args, mapper);
   }
   @Override
   public List<Board> recomEmo(String emo, String wea) {
      String sql = "select * from p_board where emotion=? and weather!=? order by read desc";
      Object[] args = {emo, wea};
      return jdbcTemplate.query(sql, args, mapper);
   }
   @Override
   public List<Board> recomWea(String emo, String wea) {
      String sql = "select * from p_board where emotion!=? and weather=? order by read desc";
      Object[] args = {emo, wea};
      return jdbcTemplate.query(sql, args, mapper);
   }
   
   @Override
   public List<Board> home_notice(int item_no) {
      String sql = "select * from ( select rownum rn, TMP.* from ( select * from p_board where item_no=? order by no desc )TMP ) where rn between 1 and 3";
      Object[] arg = {item_no};
      return jdbcTemplate.query(sql, arg, mapper);
   }
   @Override
   public List<Board> home_book_inner(int item_no) {
      String sql = "select * from ( select rownum rn, TMP.* from ( select * from p_board where item_no=? order by no desc )TMP ) where rn between 1 and 3";
      Object[] arg = {item_no};
      return jdbcTemplate.query(sql, arg, mapper);
   }
   @Override
   public List<Board> home_book_outter(int item_no) {
      String sql = "select * from ( select rownum rn, TMP.* from ( select * from p_board where item_no=? order by no desc )TMP ) where rn between 1 and 3";
      Object[] arg = {item_no};
      return jdbcTemplate.query(sql, arg, mapper);
   }
   @Override
   public List<Board> home_movie_inner(int item_no) {
      String sql = "select * from ( select rownum rn, TMP.* from ( select * from p_board where item_no=? order by no desc )TMP ) where rn between 1 and 3";
      Object[] arg = {item_no};
      return jdbcTemplate.query(sql, arg, mapper);
   }
   @Override
   public List<Board> home_movie_outter(int item_no) {
      String sql = "select * from ( select rownum rn, TMP.* from ( select * from p_board where item_no=? order by no desc )TMP ) where rn between 1 and 3";
      Object[] arg = {item_no};
      return jdbcTemplate.query(sql, arg, mapper);
   }
   
}
