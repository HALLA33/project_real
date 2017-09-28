package spring.controller.shop;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import net.sf.jmimemagic.Magic;
import net.sf.jmimemagic.MagicException;
import net.sf.jmimemagic.MagicMatchNotFoundException;
import net.sf.jmimemagic.MagicParseException;
import spring.model.member.Member;
import spring.model.member.MemberDao;
import spring.model.shop.Mybuy;
import spring.model.shop.Shop;
import spring.model.shop.ShopDao;
import spring.model.shop.Userbuy;

@Controller
public class ShopController {
	
	private Logger log = LoggerFactory.getLogger(getClass());

	@Autowired
	private ShopDao shopDao;
	
	@Autowired
	private MemberDao memberDao;
	
	
	@RequestMapping("/shop")
	public String shopview(Model model, HttpServletRequest request) {
		
		String savePath = request.getServletContext().getRealPath("/resources/img2");
		log.info(savePath);
		File targetPath = new File(savePath);
		File copyPath = new File("D:\\sw2\\image");
		
		File path = new File(savePath, "");

		if(!path.exists()) {
			log.info("실제경로가 존재하지 않습니다");
			
			//서버를 clean하면 업로드한 사진들은 없어지기 때문에 copyPath에 있는 사진들을 다시 다운
			copy(copyPath, targetPath);
		}
		
		List<Shop> list = shopDao.shoplist();
		
		model.addAttribute("slist", list);
		
		return "member/pointshop";
	}
	
	@RequestMapping("/shopinput")
	public String shopinputview(HttpSession session) {
		
		Member member = (Member)session.getAttribute("member");
		
		String power = member.getPower();
		
		if(!power.equals("관리자")) {
			try {
				throw new Exception("권한 없음");
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		
		return "member/inputshop";
	}
	
	@RequestMapping("/buyitem")
	public String buyitemview(String itemno, String item, HttpServletRequest request, String point,
			String itemno2) throws Exception {
		
		log.info(item);
		log.info(point);
		log.info(itemno2);
		
		request.setAttribute("item", item);
		request.setAttribute("point", point);
		request.setAttribute("item_no", itemno2);
		
		int point2 = Integer.parseInt(point);
		int itemno3 = Integer.parseInt(itemno);
		
		boolean result = shopDao.checkparam(itemno3, item, point2);
		
		if(result) {
			throw new Exception("아이템이 일치하지않음");
		}else {
			return "member/insertaddress";
		}
		
	}
	
	@RequestMapping("/mybuylist")
	public String mybuylistview(Model model, HttpSession session) {
		
		Member member = (Member)session.getAttribute("member");
		
		String id = member.getId();
		
		List<Mybuy> list = shopDao.mybuylist(id);
		
		model.addAttribute("buylist", list);
		
		return "member/mybuylist";
		
	}
	
	@RequestMapping("/userbuylist")
	public String userbuylistview(Model model, HttpSession session) {
		
		Member member = (Member)session.getAttribute("member");
		
		log.info(member.getPower());
		
		if(!member.getPower().equals("관리자")) {
			log.info("에러 발생!!!!");
			return "err/custom_err";
		}
		
		List<Userbuy> list = shopDao.userbuylist();
		
		model.addAttribute("ubuy", list);
		
		return "member/userbuylist";
		
	}
	
	@RequestMapping("/delivery")
	public String delivery(Model model, String item_no) {
		
		int itemno = Integer.parseInt(item_no);
		
		shopDao.statusset(itemno);
		
		List<Userbuy> list = shopDao.userbuylist();
		
		model.addAttribute("ubuy", list);
		
		return "member/userbuylist";
		
	}
	
//	private String[] typeFilter = new String[] {
//			"image/png", "image/jpeg", "image/gif"
//	};
	
	@RequestMapping(value ="/shopinput", method = RequestMethod.POST)
	public String shopinput(MultipartHttpServletRequest mRequest) throws Exception {
		
		log.info("상점 실행");
		
		String title = mRequest.getParameter("title");
		MultipartFile file = mRequest.getFile("file");
		int point = Integer.parseInt(mRequest.getParameter("point"));
		
//		String mime = Magic.getMagicMatch(file.getBytes()).getMimeType();
		
//		log.debug("mime = "+mime);
//		if(Arrays.binarySearch(typeFilter, mime) < 0) {
//			throw new MagicMatchNotFoundException("GIF, JPG, PNG만 업로드가 가능합니다");
//		}
		
		String savePath = mRequest.getServletContext().getRealPath("/resources/img2");
		
		log.info("업로드 : " + savePath);
		
		Shop shop = new Shop();
		shop.setLan(file.getSize());
		shop.setTitle(title);
		shop.setType("png");
		shop.setPoint(point);
		
		String filename = shopDao.insert(shop);
		
		File target = new File(savePath, filename);
		file.transferTo(target);	
		File targetPath = new File(savePath);
		File copyPath = new File("D:\\SW2\\image");		
		copy(targetPath, copyPath);
		
		return "redirect:/shop";
		
	}
	
	@RequestMapping(value = "/buyitem", method = RequestMethod.POST)
	public String buyitem(@RequestParam String itemname, @RequestParam String postnum,
			@RequestParam String address, @RequestParam String address2, HttpSession session,
			@RequestParam String point, @RequestParam String item_no) {

		log.info("아이템 구입");
		log.info(item_no);
		
		Member member = (Member)session.getAttribute("member");
		
		String id = member.getId();
		int points  =Integer.parseInt(point);
		int pnum = Integer.parseInt(postnum);
		
		String nickname = shopDao.buyitem(itemname,item_no, id, pnum, address, address2, points);
		
		member = memberDao.getmember(nickname);
		
		session.setAttribute("member", member);
		
		return "redirect:/shop";
		
	}
	
	@RequestMapping(value = "/deliverycencle", method = RequestMethod.POST)
	public String deliverycencel(String no, String savename, HttpSession session) {
		
		Member member = (Member)session.getAttribute("member");
		
		String id = member.getId();
		
		int num = Integer.parseInt(no);
		
		String nickname = shopDao.deliverycencel(num, savename, id);
		
		member = memberDao.getmember(nickname);
		
		session.setAttribute("member", member);
		
		return "redirect:/mybuylist";
		
	};
	
	@RequestMapping(value = "/deleteitem", method = RequestMethod.POST)
	public String deleteitem(String[] item_no) {
		
		for(String itemno : item_no) {
			
			int num = Integer.parseInt(itemno);
			
			shopDao.deleteitem(num);
		}
		
		return "member/success";
	}
	
public void copy(File origin, File target){
		
		if(origin.isFile()){
			try(
				FileInputStream in = new FileInputStream(origin);
				FileOutputStream out = new FileOutputStream(target);
			){
				//if(!target.exists()) target.createNewFile();
				byte[] buffer = new byte[1024];
				while(true){
					int size = in.read(buffer);
					if(size==-1) break;
					out.write(buffer, 0, size);
				}

			} catch(IOException e){
				System.out.println("에러 : " + e.getMessage());
			}

		}
		else if(origin.isDirectory()){
			//[1] target 생성
			target.mkdirs();
			
			//[2] origin의 구성요소 추출
			File[] list = origin.listFiles();	
			if(list==null) return;
			
			//[3] 하나씩 복사
			for(File file : list){
				File newTarget = new File(target, file.getName());
				copy(file, newTarget);							
			}
		
		}
	}
	
}
