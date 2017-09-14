package spring.model.member;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

import org.springframework.stereotype.Component;

@Component
public class Encryption {
	
	public String encryptPw(String pw) throws NoSuchAlgorithmException {
		
		String encryptpw = "";
		
		MessageDigest sh = MessageDigest.getInstance("SHA-256");
		sh.update(pw.getBytes());
		byte byteData[] = sh.digest();
		StringBuffer sb = new StringBuffer();
		for(int i = 0; i <byteData.length; i++) {
			sb.append(Integer.toString((byteData[i]&0xff) + 0x100, 16).substring(1));
		}
		encryptpw = sb.toString();
		
		return encryptpw;
		
	}
	

}
