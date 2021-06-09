package com.petpal.walk.controller;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.petpal.user.controller.UserController;
import com.petpal.walk.service.WalkService;
import com.petpal.walk.vo.WalkVO;

@Controller
@RequestMapping(value = "/walk/*")
public class WalkController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private WalkService walkService;
	
	@RequestMapping(value = "form.do")
	public String form() throws Exception{
		
		LOGGER.info("form");
		return "/walk/form";
	}
	
	@RequestMapping(value = "insertWalk.do", method = RequestMethod.POST)
	public String insertWalk(
			@ModelAttribute WalkVO walkVO,
			HttpSession session
			) throws Exception{
		
		LOGGER.info("insertWalk");
		
		try {
			
			walkVO.setUser_id((String)session.getAttribute("user_id"));
			Integer.parseInt(walkVO.getWalk_hour());
			Integer.parseInt(walkVO.getWalk_minute());
			if(walkService.insertWalk(walkVO)) {
				return "/walk/list";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "error";
	}

}








