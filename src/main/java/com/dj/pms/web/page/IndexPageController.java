package com.dj.pms.web.page;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
/**
 * @ProjectName: pms
 * @Package: com.dj.pms.web.page
 * @ClassName: IndexPageController
 * @Author: Liuwf
 * @Description:
 * @Date: 2020/1/29 21:57
 * @Version: 1.0
 */
@RequestMapping("/index/")
@Controller
public class IndexPageController {
	@RequestMapping("toIndex")
	public String toIndex() {
		return "index/index";
	}
	@RequestMapping("toLeft")
	public String toLeft() {
		return "index/left";
	}
	@RequestMapping("toRight")
	public String toRight() {
		return "index/right";
	}
	@RequestMapping("toTop")
	public String toTop() {
		return "index/top";
	}

}
