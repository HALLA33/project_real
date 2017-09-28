package spring.model.shop;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.post;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
@Repository("shopDao")
public class ShopDaoImple implements ShopDao {
	
	@Autowired
	private JdbcTemplate jdbcTemplate;
	
	RowMapper<Shop> mapper = (rs, index)->{
		return new Shop(rs);
	};
	RowMapper<Mybuy> mapper2 = (rs, index)->{
		return new Mybuy(rs);
	};
	RowMapper<Userbuy> mapper3 = (rs, index)->{
		return new Userbuy(rs);
	};

	@Override
	public String insert(Shop shop) {
		
		String sql = "select p_pshop_seq.nextval from dual";
		int sequence = jdbcTemplate.queryForObject(sql, Integer.class);
//		String extension = shop.getType().substring("image/".length())
//				.replace("jpeg", "jpg");
		shop.setSavename(sequence+".png");
		
		sql = "insert into p_pshop values(?, ?, ? , ?, ?, sysdate, ?)";
		
		jdbcTemplate.update(sql, new Object[] {sequence, shop.getTitle(), shop.getSavename(), shop.getType(),
				shop.getLan(), shop.getPoint()});
		
		return shop.getSavename();
	}

	@Override
	public List<Shop> shoplist() {
		
		return jdbcTemplate.query("select * from p_pshop order by reg desc", mapper);
		
	}

	@Override
	public int count() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Shop getImage(int no) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public String buyitem(String itemname, String item_path, String id, int postnum, String address, String address2, int point) {
		
		String sql = "insert into mybuy values(p_buy_seq.nextval, ?, ?, ?, sysdate, 'false')";
		
		jdbcTemplate.update(sql, new Object[] {item_path, itemname, id});
			
		sql = "select max(no) from mybuy";
		
		int ordernum = jdbcTemplate.queryForObject(sql, Integer.class);
		
		System.out.println("ordernum : " + ordernum);
		
		sql = "insert into userbuy values(?, ?, ?, ?, ?, ?, ?, 'false')";
		
		jdbcTemplate.update(sql, new Object[] {ordernum, item_path, itemname, id, postnum, address, address2});
		
		sql = "update p_member set point = point - ? where id = ?";
		
		jdbcTemplate.update(sql, new Object[] {point, id});
		
		sql = "select nickname from p_member where id = ?";
		
		String nickname = jdbcTemplate.queryForObject(sql, new Object[] {id}, String.class);
		
		return nickname;
		
	}

	@Override
	public boolean checkparam(int itemno, String itemname, int point) {
		
		String sql = "select * from p_pshop where no = ? and title = ?  and point = ?";
		
		boolean result = jdbcTemplate.query(sql, new Object[] {itemno, itemname, point}, mapper).isEmpty();
		
		return result;
	}

	@Override
	public List<Mybuy> mybuylist(String id) {
		
		String sql = "select * from mybuy where id = ? order by no desc";
		
		List<Mybuy> list = jdbcTemplate.query(sql, new Object[] {id}, mapper2);
		
		return list;
	}

	@Override
	public List<Userbuy> userbuylist() {
		
		String sql = "select * from userbuy order by no desc";
		
		List<Userbuy> list = jdbcTemplate.query(sql, mapper3);
		
		return list;
	}

	@Override
	public void statusset(int itemno) {
		
		String sql = "update mybuy set status = 'true' where no = ?";		
		
		jdbcTemplate.update(sql, new Object[] {itemno});
		
		sql = "update userbuy set status = 'true' where no = ?";
		
		jdbcTemplate.update(sql, new Object[] {itemno});
		
	}
	

}
