package spring.model.shop;

import java.util.List;

import org.springframework.stereotype.Repository;

@Repository
public interface ShopDao {
	
	public String insert(Shop shop);
	public List<Shop> shoplist();
	public List<Mybuy> mybuylist(String id);
	public List<Userbuy> userbuylist();
	int count();
	Shop getImage(int no);
	public boolean checkparam(int itemno, String itemname, int point);
	public String buyitem(String itemname, String item_path, String id, int postnum, String address, String address2, int point);
	public void statusset(int itemno);
	public String deliverycencel(int no, String savename, String id);
	public void deleteitem(int itemno);

}
