package spring.model.shop;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface ShopDao {
	
	public String insert(Shop shop);
	public List<Shop> shoplist();
	int count();
	Shop getImage(int no);
	public String buyitem(String itemname, String id, int postnum, String address, String address2, int point);

}
