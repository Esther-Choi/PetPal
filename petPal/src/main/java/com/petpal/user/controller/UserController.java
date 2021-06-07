package com.petpal.user.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import com.petpal.user.service.UserService;
import com.petpal.user.vo.UserVO;

@Controller
@RequestMapping("/user/*")
public class UserController {

	private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService userService;
	
	@RequestMapping(value = "join01.do")
	public String step02 () throws Exception {
		
		LOGGER.info("join01");
		
		return "/user/join01";
	}
	
	@RequestMapping(value = "join02.do")
	public String step02 (
			@ModelAttribute UserVO userVO,
			Model model,
			HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		
		LOGGER.info(userVO.getUser_id());
		
		model.addAttribute("userVO", userVO);
		
		return "/user/join02";
	}
	
}
