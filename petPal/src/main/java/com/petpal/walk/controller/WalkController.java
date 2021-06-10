package com.petpal.walk.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.petpal.user.controller.UserController;
import com.petpal.user.service.UserService;
import com.petpal.user.vo.PetVO;
import com.petpal.walk.service.WalkService;
import com.petpal.walk.vo.WalkVO;

@Controller
@RequestMapping(value = "/walk/*")
public class WalkController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private WalkService walkService;
	
	@Autowired
	private UserService userService;

	
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
			String user_id = (String)session.getAttribute("user_id");
			PetVO pet = userService.getPet(user_id);
			walkVO.setUser_id(user_id);			
			walkVO.setThumb(pet.getPet_photothumb());
			walkVO.setAge(pet.getPet_age());
			walkVO.setBreed(pet.getPet_breed());
			Integer.parseInt(walkVO.getAge());
			Integer.parseInt(walkVO.getWalk_hour());
			Integer.parseInt(walkVO.getWalk_minute());
			if(walkService.insertWalk(walkVO)) {
				return "/walk/list.do";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "error";
	}
	
	@RequestMapping(value = "list.do", method = RequestMethod.GET)
	public String selectWalkList(Model model) throws Exception{
		LOGGER.info("selectWalkList");

		model.addAttribute("list", walkService.selectWalkList());

		
		return "/walk/list";
	}

}








