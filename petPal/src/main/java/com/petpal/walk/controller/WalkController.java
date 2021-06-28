package com.petpal.walk.controller;

import java.util.Date;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.petpal.user.controller.UserController;
import com.petpal.user.service.UserService;
import com.petpal.user.vo.PetVO;
import com.petpal.user.vo.UserVO;
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
	
	@Resource(name = "uploadPath")
	private String uploadPath;

	
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
				return "redirect:/walk/list.do";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "error";
	}
	
	@RequestMapping(value = "list.do", method = RequestMethod.GET)
	public String selectWalkList(Model model, HttpSession session) throws Exception{
		
		String user_id = (String)session.getAttribute("user_id");
		Date date = new Date();
		List<WalkVO> list = walkService.selectWalkList();
		if(user_id == null) {
			LOGGER.info("no session");
			return "redirect:/user/main.do";
		}
		LOGGER.info("selectWalkList");
		
		model.addAttribute("list", walkService.selectWalkList());
		model.addAttribute("now",date );

		
		return "/walk/list";
	}
	
	@RequestMapping(value = "scrollDown.do", method = RequestMethod.POST)
	@ResponseBody
	public List<WalkVO> scrollDown(@RequestParam("num") int num){
		LOGGER.info("scrollDown");
		num--;
		return walkService.scrollDown(num);
	}
	
	@RequestMapping(value = "view.do", method = RequestMethod.GET)
	public String getWalk(@RequestParam("num") int num, Model model) throws Exception {
		LOGGER.info("getWalk");
		WalkVO walk = walkService.getWalk(num);
		UserVO user = userService.getUser(walk.getUser_id());
		
		model.addAttribute("walkVO", walk);
		model.addAttribute("userVO", user);
		model.addAttribute("address", userService.getPet(walk.getUser_id()).getAddress());
		
		return "/walk/view";
	}
	
}








