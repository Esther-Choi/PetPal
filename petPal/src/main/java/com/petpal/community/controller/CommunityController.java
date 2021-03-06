package com.petpal.community.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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

import com.petpal.community.service.CommunityService;
import com.petpal.community.vo.ComLikeVO;
import com.petpal.community.vo.ComScrapVO;
import com.petpal.community.vo.CommentVO;
import com.petpal.community.vo.CommunityVO;
import com.petpal.user.controller.UserController;
import com.petpal.user.service.UserService;
import com.petpal.user.vo.UserVO;
import com.petpal.walk.vo.WalkVO;

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
		
		String user_id = (String)session.getAttribute("user_id");
		if(user_id == null) {
			LOGGER.info("no session");
			return "redirect:/user/main.do";
		}
		LOGGER.info("insertCommunity");
		
		try {
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
	
	@RequestMapping(value="editCom.do", method = RequestMethod.POST)
	public String editWalk(
			@ModelAttribute CommunityVO comVO,
			@RequestParam(defaultValue = "0") int num,
			HttpSession session
			) throws Exception{
		
		String user_id = (String)session.getAttribute("user_id");
		if(user_id == null) {
			LOGGER.info("no session");
			return "redirect:/user/main.do";
		}
		LOGGER.info("edittWalk");
		
		try {
			comVO.setNum(num);
			if(comService.editCom(comVO)) {
				
				return "redirect:/com/view.do?num="+comVO.getNum();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		
		}
		return "error";
	}
	
	@RequestMapping(value="delete.do", method = RequestMethod.GET)
	public String deleteWalk(
			@RequestParam("num") int num,
			@RequestParam("prev") String prev,
			HttpServletResponse response
			) throws Exception {
		
		LOGGER.info("deleteWalk");
		try {
			
			if(comService.deleteCom(num)) {
				if(prev.equals("my")) {
					
					return "redirect:/mypage/mycommunity.do";
				}else {
					
					return "redirect:/com/list.do";
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "error";
		
	}
	
	
	@RequestMapping(value = "form.do")
	public String form(
			@RequestParam(defaultValue = "0") int num,
			Model model
			) throws Exception{
		
		LOGGER.info("community form");
		
		if(num != 0) {
			
			CommunityVO comVO = comService.getCom(num);
			model.addAttribute("comVO", comVO);
		}
		
		return "/community/form";
	}

	@RequestMapping(value = "list.do", method = RequestMethod.GET)
	public String selectComList(Model model, HttpSession session) throws Exception{
		
		String user_id = (String)session.getAttribute("user_id");
		
		if(user_id == null) {
			LOGGER.info("no session");
			return "redirect:/user/main.do";
		}
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		List<CommunityVO> lists =  comService.selectComList();
		
		LOGGER.info("selectComList");
		
		try {
			
			if(lists.size() > 0 ) {
				
				for (int i = 0; i < lists.size(); i++) {
					
					HashMap<String, Object> map = new HashMap<String, Object>();
					
					map.put("user_id", user_id);
					map.put("board_num", lists.get(i).getNum());
					
					if(comService.getComLike(map) != null) {
						
						if(comService.getComLike(map) == 1) {
							lists.get(i).setLikecheck(1);
						}
					}
					
					Date startDate = new Date();
					Date endDate = sdf.parse(lists.get(i).getDate());
					
					long diffDay = (startDate.getTime() - endDate.getTime()) / (24*60*60*1000);
					if(diffDay > 0) {
						lists.get(i).setDate(diffDay+"??? ???");
					}else {
						endDate = sdf.parse(lists.get(i).getDate());
						diffDay = (startDate.getTime() - endDate.getTime()) / (60*1000);
						if(diffDay > 60) {
							lists.get(i).setDate((diffDay/60)+"?????? ???");
						}else if(diffDay == 0){
							lists.get(i).setDate("?????? ???");
						}else {
							lists.get(i).setDate((diffDay)+"??? ???");
						}
					}
					
				}
			}
			model.addAttribute("lists", lists);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return "/community/list";
	}
	
	@RequestMapping(value = "scrollDown.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CommunityVO> scrollDown(@RequestParam("num") int num, HttpSession session){
		LOGGER.info("scrollDown");
		num--;
		String user_id = (String)session.getAttribute("user_id");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		List<CommunityVO> lists =  comService.scrollDown(num);
		
		try {
			
			if(lists.size() > 0 ) {
				for (int i = 0; i < lists.size(); i++) {
					
					HashMap<String, Object> map = new HashMap<String, Object>();
					
					map.put("user_id", user_id);
					map.put("board_num", lists.get(i).getNum());
					
					if(comService.getComLike(map) != null) {
						
						if(comService.getComLike(map) == 1) {
							lists.get(i).setLikecheck(1);
						}
					}
					
					Date startDate = new Date();
					Date endDate = sdf.parse(lists.get(i).getDate());
					
					long diffDay = (startDate.getTime() - endDate.getTime()) / (24*60*60*1000);
					if(diffDay > 0) {
						lists.get(i).setDate(diffDay+"??? ???");
					}else {
						endDate = sdf.parse(lists.get(i).getDate());
						diffDay = (startDate.getTime() - endDate.getTime()) / (60*1000);
						if(diffDay > 60) {
							lists.get(i).setDate((diffDay/60)+"?????? ???");
						}else if(diffDay == 0){
							lists.get(i).setDate("?????? ???");
						}else {
							lists.get(i).setDate((diffDay)+"??? ???");
						}
					}
					
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return lists;
	}
	
	@RequestMapping(value="view.do", method = RequestMethod.GET)
	public String getCom(@RequestParam("num") int num, @RequestParam("prev") String prev, Model model, HttpSession session) throws Exception {
		
		String user_id = (String)session.getAttribute("user_id");
		if(user_id == null) {
			LOGGER.info("no session");
			return "redirect:/user/main.do";
		}
		LOGGER.info("com view");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		CommunityVO comVO = comService.getCom(num);
		UserVO user = userService.getUser(comVO.getUser_id());
		int check = 0;
		
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		map.put("user_id", user_id);
		map.put("board_num", num);
		
		if(comService.getComLike(map) != null) {
			
			if(comService.getComLike(map) == 1) {
				comVO.setLikecheck(1);
			}
		}
		
		if(comService.getComScrap(map) != null) {
			if(comService.getComScrap(map) == 1) {
				model.addAttribute("check2", comService.getComScrap(map));
			}
		}
		
		try {
			
			Date startDate = new Date();
			Date endDate = sdf.parse(comVO.getDate());
			long diffDay = (startDate.getTime() - endDate.getTime()) / (24*60*60*1000);
			
			if(diffDay > 0) {
				comVO.setDate(diffDay+"??? ???");
			}else {
				endDate = sdf.parse(comVO.getDate());
				diffDay = (startDate.getTime() - endDate.getTime()) / (60*1000);
				if(diffDay > 60) {
					comVO.setDate((diffDay/60)+"?????? ???");
				}else if(diffDay == 0){
					comVO.setDate("?????? ???");
				}else {
					comVO.setDate((diffDay)+"??? ???");
				}
			}
				
	} catch (Exception e) {
		e.printStackTrace();
	}
		
		model.addAttribute("comVO", comVO);
		model.addAttribute("userVO", user);
		model.addAttribute("address", userService.getPet(comVO.getUser_id()).getAddress());
		model.addAttribute("thumb", userService.getPet(comVO.getUser_id()).getPet_photothumb());
		model.addAttribute("user_id", user_id);
		model.addAttribute("prev", prev);
		
		return "/community/view";
	}
	
	//?????? ??????
	@RequestMapping(value = "insertComment.do")
	@ResponseBody
	public String insertComment(
			@ModelAttribute CommentVO comVO,
			HttpSession session) throws Exception {
		
		String user_id = (String)session.getAttribute("user_id");
		if(user_id == null) {
			LOGGER.info("no session");
			return "redirect:/user/main.do";
		}
		String result = "";
		try {
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
	
	//?????? ?????????
	@RequestMapping(value = "getCommentList.do", produces="application/json; charset=utf8")
	@ResponseBody
	public ArrayList<HashMap> getCommentList(
			int boardNo
			){
		System.out.println(boardNo);
		ArrayList<HashMap> hmlist = new ArrayList<HashMap>();
		
		List<CommentVO> comments = comService.getCommentList(boardNo);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		
		try {
			
			if(comments.size() > 0 ) {
				for (int i = 0; i < comments.size(); i++) {
					HashMap<String, Object> hm = new HashMap<String, Object>();
					Date startDate = new Date();
					Date endDate = sdf.parse(comments.get(i).getDate());
					
					long diffDay = (startDate.getTime() - endDate.getTime()) / (24*60*60*1000);
					if(diffDay > 0) {
						hm.put("date", diffDay+"??? ???");
					}else {
						endDate = sdf.parse(comments.get(i).getDate());
						diffDay = (startDate.getTime() - endDate.getTime()) / (60*1000);
						if(diffDay > 60) {
							hm.put("date", (diffDay/60)+"?????? ???");
						}else if(diffDay == 0){
							hm.put("date", "?????? ???");
						}else {
							hm.put("date", (diffDay)+"??? ???");
						}
					}
					hm.put("user_name", userService.getUser(comments.get(i).getUser_id()).getUser_name());
					hm.put("address", comments.get(i).getAddress());
					hm.put("content", comments.get(i).getContent());
					hm.put("photo", userService.getPet(comments.get(i).getUser_id()).getPet_photothumb());
					
					hmlist.add(hm);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return hmlist;
		
	}
	
	//?????? ????????????
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
	
	@RequestMapping(value = "likeCom.do", method = RequestMethod.GET)
	@ResponseBody
	public String likeCom(
			@ModelAttribute ComLikeVO comLikeVO,
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
			comLikeVO.setUser_id(user_id);
			comLikeVO.setBoard_num(num);
			comLikeVO.setLikecheck(check);
			if(check == 1) {
				comService.insertLike(comLikeVO);
			}else {
				comService.deleteLike(comLikeVO);
			}
			result = "success";
		} catch (Exception e) {
			e.printStackTrace();
			result = "fali";
		}
		
		return result;
	}
	
	@RequestMapping(value = "scrapCom.do", method = RequestMethod.GET)
	@ResponseBody
	public String scrapCom(
			@ModelAttribute ComScrapVO comScrapVO,
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
			comScrapVO.setUser_id(user_id);
			comScrapVO.setBoard_num(num);
			comScrapVO.setLikecheck(check);
			if(check == 1) {
				comService.insertScrap(comScrapVO);
			}else {
				comService.deleteScrap(comScrapVO);
			}
			result = "success";
		} catch (Exception e) {
			e.printStackTrace();
			result = "fali";
		}
		
		return result;
	}
	
}














