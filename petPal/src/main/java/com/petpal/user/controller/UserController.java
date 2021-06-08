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
import org.springframework.web.bind.annotation.RequestMethod;

import com.petpal.user.service.UserService;
import com.petpal.user.vo.PetVO;
import com.petpal.user.vo.UserVO;

@Controller
@RequestMapping("/user/*")
public class UserController {

	private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService userService;
	
	@RequestMapping(value = "join01.do")
	public String step01 () throws Exception {
		
		LOGGER.info("join01");
		
		return "/user/join01";
	}
	
	@RequestMapping(value = "join02.do", method = RequestMethod.POST)
	public String step02 (
			@ModelAttribute UserVO userVO,
			Model model,
			HttpServletRequest request,
			HttpServletResponse response,
			UserVO user
			) throws Exception {
		
			LOGGER.info(user.getUser_gender());
			LOGGER.info(user.getUser_id());
			LOGGER.info(user.getUser_pw());
			LOGGER.info(user.getUser_name());
			LOGGER.info(user.getWalk_day());
			LOGGER.info(user.getWalk_time());
			LOGGER.info(user.getWalk_hour());
			LOGGER.info(user.getWalk_minute());
			LOGGER.info(user.getWalk_place1());
			LOGGER.info(user.getWalk_style());
		
			model.addAttribute("userVO", userVO);
		
		return "/user/join02";
	}
	
	@RequestMapping(value="join.do", method = RequestMethod.POST)
	public String join(
			@ModelAttribute UserVO userVO,
			@ModelAttribute PetVO petVO,
			HttpServletRequest request,
			HttpServletResponse response,
			PetVO pet
			) {
		
			petVO.setUser_id(userVO.getUser_id());
			Integer.parseInt(userVO.getWalk_hour());
			Integer.parseInt(userVO.getWalk_minute());
			Integer.parseInt(petVO.getPet_age());
			Integer.parseInt(petVO.getPet_weight());
		
			try {
				
				if(userService.join(userVO, petVO)) {
					
					return "/user/login";
				}
				
			} catch (Exception e) {
				
				e.printStackTrace();
			}
			
			return "error";
	}
	
}
