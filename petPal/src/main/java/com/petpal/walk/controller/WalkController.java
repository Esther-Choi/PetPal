package com.petpal.walk.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
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
import com.petpal.walk.vo.WalkLikeVO;
import com.petpal.walk.vo.WalkVO;

@Controller
@RequestMapping(value = "/walk/*")
public class WalkController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private WalkService walkService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private WalkService likeService;
	
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
		
		String user_id = (String)session.getAttribute("user_id");
		if(user_id == null) {
			LOGGER.info("no session");
			return "redirect:/user/main.do";
		}
		LOGGER.info("insertWalk");
		
		try {
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
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		List<WalkVO> lists = walkService.selectWalkList();
		if(user_id == null) {
			LOGGER.info("no session");
			return "redirect:/user/main.do";
		}
		LOGGER.info("selectWalkList");
		try {
			
			if(lists.size() > 0 ) {
				for (int i = 0; i < lists.size(); i++) {
					Date startDate = new Date();
					Date endDate = sdf.parse(lists.get(i).getDate());
					long diffDay = (endDate.getTime() - startDate.getTime()) / (24*60*60*1000);
					if(diffDay == 0) {
						if(endDate.getDay() != startDate.getDay()) {
							lists.get(i).setDate("내일");
						}else {
							lists.get(i).setDate("오늘");
						}
					}else if(diffDay == 1){
						lists.get(i).setDate("내일");
					}else {
						SimpleDateFormat sdf2 = new SimpleDateFormat("MM월 dd일");
						lists.get(i).setDate(sdf2.format(endDate));
					}
					
				}
			}
			model.addAttribute("list", lists);
		} catch (Exception e) {
			e.printStackTrace();
		}
		

		
		return "/walk/list";
	}
	
	@RequestMapping(value = "scrollDown.do", method = RequestMethod.POST)
	@ResponseBody
	public List<WalkVO> scrollDown(@RequestParam("num") int num){
		LOGGER.info("scrollDown");
		
		num--;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		List<WalkVO> lists = walkService.scrollDown(num);
		try {
			
			if(lists.size() > 0 ) {
				for (int i = 0; i < lists.size(); i++) {
					Date startDate = new Date();
					Date endDate = sdf.parse(lists.get(i).getDate());
					long diffDay = (endDate.getTime() - startDate.getTime()) / (24*60*60*1000);
					if(diffDay == 0) {
						if(endDate.getDay() != startDate.getDay()) {
							lists.get(i).setDate("내일");
						}else {
							lists.get(i).setDate("오늘");
						}
					}else if(diffDay == 1){
						lists.get(i).setDate("내일");
					}else {
						SimpleDateFormat sdf2 = new SimpleDateFormat("MM월 dd일");
						lists.get(i).setDate(sdf2.format(endDate));
					}
					
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return lists;
	}
	
	@RequestMapping(value = "view.do", method = RequestMethod.GET)
	public String getWalk(@RequestParam("num") int num, Model model, HttpSession session) throws Exception {
		LOGGER.info("getWalk");
		
		String user_id = (String)session.getAttribute("user_id");
		if(user_id == null) {
			LOGGER.info("no session");
			return "redirect:/user/main.do";
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		WalkVO walk = walkService.getWalk(num);
		UserVO user = userService.getUser(walk.getUser_id());
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		int check = 0;
		
		map.put("user_id", user_id);
		map.put("board_num", num);
		System.out.println(likeService.getWalkLike(map) );
		if(likeService.getWalkLike(map) != null) {
			model.addAttribute("check", likeService.getWalkLike(map));
		}
		
		try {
			
				Date startDate = new Date();
				Date endDate = sdf.parse(walk.getDate());
				long diffDay = (endDate.getTime() - startDate.getTime()) / (24*60*60*1000);
				if(diffDay == 0) {
					if(endDate.getDay() != startDate.getDay()) {
						walk.setDate("내일");
					}else {
						walk.setDate("오늘");
					}
				}else if(diffDay == 1){
					walk.setDate("내일");
				}else {
					SimpleDateFormat sdf2 = new SimpleDateFormat("MM월 dd일");
					walk.setDate(sdf2.format(endDate));
				}
					
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("walkVO", walk);
		model.addAttribute("userVO", user);
		model.addAttribute("address", userService.getPet(walk.getUser_id()).getAddress());
		
		
		return "/walk/view";
	}
	
	@RequestMapping(value = "likeWalk.do", method = RequestMethod.GET)
	@ResponseBody
	public String likeWalk(
			@ModelAttribute WalkLikeVO walkLikeVO,
			@RequestParam("num") int num,
			@RequestParam("check") int check,
			HttpSession session
			)  throws Exception{
		String user_id = (String)session.getAttribute("user_id");
		if(user_id == null) {
			LOGGER.info("no session");
			return "redirect:/user/main.do";
		}
		String result = "";
		try {
			walkLikeVO.setUser_id(user_id);
			walkLikeVO.setBoard_num(num);
			walkLikeVO.setLikecheck(check);
			if(likeService.searchWalkLike(walkLikeVO) == 1) {
				likeService.updateLike(walkLikeVO);
			}else {				
				likeService.insertLike(walkLikeVO);
			}
			result = "success";
		} catch (Exception e) {
			e.printStackTrace();
			result = "fali";
		}
		
		return result;
	}
	
}








