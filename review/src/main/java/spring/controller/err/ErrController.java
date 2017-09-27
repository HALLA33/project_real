package spring.controller.err;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ErrController {
	private Logger log = LoggerFactory.getLogger(getClass());
	
	@RequestMapping("/err404")
	public String err404() {
		return "err/err404";
	}
	
	@RequestMapping("/err500")
	public String err500() {
		return "err/err500";
	}
}
