package com.petpal.community.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.petpal.community.service.CommunityService;
import com.petpal.community.vo.CommentVO;
import com.petpal.community.vo.CommunityVO;
import com.petpal.user.controller.UserController;
import com.petpal.user.service.UserService;
import com.petpal.user.vo.UserVO;

@Controller
@RequestMapping("/com/*")
public class CommunityController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private CommunityService comService;
	
	@Autowired
	private UserService userService;
	
	@RequestMapping(value = "insertCom.do", method = RequestMethod.POST)
	public String insertCommunity(
			@ModelAttribute CommunityVO comVO,
			HttpSession session
			) throws Exception{
		
		LOGGER.info("insertCommunity");
		
		try {
			String user_id = (String)session.getAttribute("user_id");
			comVO.setUser_id(user_id);
			System.out.println(userService.getUser(user_id).getUser_name());
			comVO.setUser_name(userService.getUser(user_id).getUser_name());
			
			if(comService.insertCommunity(comVO)) {
				return "redirect:/com/list.do";
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "error";
	}
	
	
	@RequestMapping(value = "form.do")
	public String form() throws Exception{
		
		LOGGER.info("community form");
		return "/community/form";
	}

	@RequestMapping(value = "list.do", method = RequestMethod.GET)
	public String selectWalkList(Model model, HttpSession session) throws Exception{
		
		String user_id = (String)session.getAttribute("user_id");
		Date date = new Date();
		List<CommunityVO> list = comService.selectComList();
		if(user_id == null) {
			LOGGER.info("no session");
			return "redirect:/user/main.do";
		}
		LOGGER.info("selectComList");
		
		model.addAttribute("list", comService.selectComList());
		model.addAttribute("now",date );

		
		return "/community/list";
	}
	
	@RequestMapping(value = "scrollDown.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CommunityVO> scrollDown(@RequestParam("num") int num){
		LOGGER.info("scrollDown");
		num--;
		return comService.scrollDown(num);
	}
	
	@RequestMapping(value="view.do", method = RequestMethod.GET)
	public String getCom(@RequestParam("num") int num, Model model) throws Exception {
		
		LOGGER.info("com view");
		CommunityVO comVO = comService.getCom(num);
		UserVO user = userService.getUser(comVO.getUser_id());
		model.addAttribute("comVO", comVO);
		model.addAttribute("userVO", user);
		model.addAttribute("address", userService.getPet(comVO.getUser_id()).getAddress());
		model.addAttribute("thumb", userService.getPet(comVO.getUser_id()).getPet_photothumb());
		
		return "/community/view";
	}
	
	//댓글 삽입
	@RequestMapping(value = "insertComment.do")
	@ResponseBody
	public String insertComment(
			@ModelAttribute CommentVO comVO,
			HttpSession session) throws Exception {
		
		String user_id = (String)session.getAttribute("user_id");
		String result = "";
		try {
			System.out.println(comVO.getContent());
			comVO.setUser_id(user_id);
			comVO.setAddress(userService.getPet(user_id).getGungu()+" "+userService.getPet(user_id).getDong());
			comService.insertComment(comVO);
			result = "success";
		} catch (Exception e) {
			e.printStackTrace();
			result= "fail";
		}
		
		return result;
	}
	
	//댓글 불러오기
	@RequestMapping(value = "getComments.do", produces = "application/json; charset=utf8")
	@ResponseBody
	public ArrayList<HashMap<String, String>> getComments(
			@RequestParam("num") int num,
			HttpSession session
			) {
		
		ArrayList<HashMap<String, String>> hmlist = new ArrayList<HashMap<String, String>>();
		
		List<CommentVO> comments = comService.getCommentList(num);
		
		if(comments.size() > 0) {
			for (int i = 0; i < comments.size(); i++) {
				HashMap<String, String> hm = new HashMap<>();
				hm.put("name", userService.getUser(comments.get(i).getUser_id()).getUser_name());
				hm.put("thumb", userService.getPet(comments.get(i).getUser_id()).getPet_photothumb());
				hm.put("address", comments.get(i).getAddress());
				hm.put("date", comments.get(i).getDate());
				hm.put("content", comments.get(i).getContent());
				
				hmlist.add(hm);
			}
		}
		return hmlist;
		
	}
	
}














