package spring.model.member;
import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import org.springframework.stereotype.Component;

@Component
public class Generator {
	public String createString(int len) {
		List<String> list = new ArrayList<>();
		for(char v='a'; v<='z'; v++) list.add(String.valueOf(v));
		for(char v='A'; v<='Z'; v++) list.add(String.valueOf(v));
		for(char v='0'; v<='9'; v++) list.add(String.valueOf(v));
		Collections.shuffle(list);
		
		//중복 없는 문자열 추출
		StringBuffer buffer = new StringBuffer();
		for(int i=0; i<len; i++) {
			buffer.append(list.get(i));
		}
		
		return buffer.toString();
	}
}
