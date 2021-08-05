package com.petpal.mypage.controller;


import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
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
import org.springframework.web.multipart.MultipartFile;

import com.petpal.community.service.CommunityService;
import com.petpal.community.vo.CommunityVO;
import com.petpal.mypage.service.MyPageService;
import com.petpal.user.controller.UserController;
import com.petpal.user.service.UserService;
import com.petpal.user.vo.PetVO;
import com.petpal.user.vo.UserVO;
import com.petpal.utils.UploadFileUtils;
import com.petpal.walk.service.WalkService;
import com.petpal.walk.vo.WalkVO;

@Controller
@RequestMapping("/mypage/*")
public class MyPageController {
	
	private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);

	@Autowired
	UserService userService;
	
	@Autowired
	MyPageService mypageService;
	
	@Autowired
	WalkService walkService;
	
	@Autowired
	CommunityService comService;
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	@RequestMapping(value = "main.do")
	public String main(Model model, HttpSession session) throws Exception{
		
		LOGGER.info("mypage");
		
		String user_id = (String)session.getAttribute("user_id");
		String name = userService.getUser(user_id).getUser_name();
		String thumb = userService.getPet(user_id).getPet_photothumb();
		
		model.addAttribute("name", name);
		model.addAttribute("thumb", thumb);
		
		return "/mypage/main";
	}
	

	@RequestMapping(value="profile/view.do")
	public String myprofile(HttpSession session, Model model) throws Exception{
		
		LOGGER.info("myprofile");
		String user_id = (String)session.getAttribute("user_id");
		
		UserVO user = userService.getUser(user_id);
		PetVO pet = userService.getPet(user_id);
		int birthYear = Integer.parseInt(user.getUser_birth().substring(0, 4));
		
		Calendar current = Calendar.getInstance();
		int year = current.get(Calendar.YEAR);
		
		int age = year - birthYear;
		
		user.setUser_birth(age+"");
		user.setWalk_day(user.getWalk_day().replaceFirst("\\[", ""));
		user.setWalk_day(user.getWalk_day().replaceFirst("\\]", ""));
		
		model.addAttribute("userVO", user);
		model.addAttribute("petVO", pet);
		
		return "/mypage/profile/view";
	}
	
	@RequestMapping(value="profile/form.do")
	public String formMyProfile(HttpSession session, Model model) throws Exception {
		
		
		LOGGER.info("form myProfile");
		
		String user_id = (String)session.getAttribute("user_id");
		
		UserVO user = userService.getUser(user_id);
		PetVO pet = userService.getPet(user_id);
		
		model.addAttribute("userVO", user);
		model.addAttribute("petVO", pet);
		
		return "/mypage/profile/form";
	}
	
	@RequestMapping(value="profile/edit.do")
	public String editMyProfile(
			HttpSession session,
			@ModelAttribute UserVO userVO,
			@ModelAttribute PetVO petVO,
			@RequestParam(value="walk_day") String[] days,
			MultipartFile file
			) throws Exception {
		
		
		LOGGER.info("edit myProfile");
		
		String user_id = (String)session.getAttribute("user_id");
		
		String imgUploadPath = uploadPath + File.separator + "imgUpload";
		String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
		String fileName = null;
		
		if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
			
			fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			
			petVO.setPet_photo(File.separator+"imgUpload" + ymdPath + File.separator + fileName);
			petVO.setPet_photothumb(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
		}
//		else {
//			fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
//		}
		
		
		userVO.setUser_id(user_id);
		petVO.setUser_id(user_id);
		userVO.setWalk_day(Arrays.toString(days));
		Integer.parseInt(userVO.getWalk_hour());
		Integer.parseInt(userVO.getWalk_minute());
	
		try {
			
			if(userService.editUser(userVO) && userService.editPet(petVO)) {
				
				LOGGER.info(userVO.toString());
				LOGGER.info(petVO.toString());
				return "redirect:/mypage/profile/view.do";
			}
			
		} catch (Exception e) {
			
			e.printStackTrace();
		}
		
		return "error";
		
	}
	
	@RequestMapping(value="/walk/list.do")
	public String myWlalkList(
			HttpSession session, 
			Model model
			) {
		LOGGER.info("myWalkList");
		
		String user_id = (String)session.getAttribute("user_id");
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		List<WalkVO> lists = walkService.selectMyWalkList(user_id);
		if(user_id == null) {
			LOGGER.info("no session");
			return "redirect:/user/main.do";
		}
		LOGGER.info("selectMyWalkList");
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
		
		
		return "/mypage/walk/list";
	}
	
	@RequestMapping(value="/scrap/walk/list.do")
	public String myWlalkScrap(
			HttpSession session, 
			Model model
			) {
		LOGGER.info("myWalkScrapList");
		
		String user_id = (String)session.getAttribute("user_id");
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		List<WalkVO> lists = walkService.selectMyWalkScrap(user_id);
		if(user_id == null) {
			LOGGER.info("no session");
			return "redirect:/user/main.do";
		}
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
		
		
		return "/mypage/scrap/walk/list";
	}
	
	@RequestMapping(value="/community/list.do")
	public String myComList(
			HttpSession session, 
			Model model
			) {
		LOGGER.info("myWalkList");
		
		String user_id = (String)session.getAttribute("user_id");
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		List<CommunityVO> lists = comService.selectMyComList(user_id);
		if(user_id == null) {
			LOGGER.info("no session");
			return "redirect:/user/main.do";
		}
		LOGGER.info("selectMyComList");
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
		
		
		return "/mypage/community/list";
	}
	
	@RequestMapping(value="/scrap/community/list.do")
	public String myComScrap(
			HttpSession session, 
			Model model
			) {
		
		String user_id = (String)session.getAttribute("user_id");
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		List<CommunityVO> lists = comService.selectMyComScrap(user_id);
		if(user_id == null) {
			LOGGER.info("no session");
			return "redirect:/user/main.do";
		}
		LOGGER.info("selectMyComScrap");
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
		
		
		return "/mypage/scrap/community/list";
	}
	
	@RequestMapping(value = "/community/scrollDownMyCom.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CommunityVO> scrollDownMy(@RequestParam("num") int num, HttpSession session){
		LOGGER.info("scrollDownMy");
		num--;
		String user_id = (String)session.getAttribute("user_id");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		HashMap<String, Object> maps = new HashMap<String, Object>();
		maps.put("user_id", user_id);
		maps.put("num", num);
		List<CommunityVO> lists =  comService.scrollDownMy(maps);
		
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
						lists.get(i).setDate(diffDay+"일 전");
					}else {
						endDate = sdf.parse(lists.get(i).getDate());
						diffDay = (startDate.getTime() - endDate.getTime()) / (60*1000);
						if(diffDay > 60) {
							lists.get(i).setDate((diffDay/60)+"시간 전");
						}else if(diffDay == 0){
							lists.get(i).setDate("방금 전");
						}else {
							lists.get(i).setDate((diffDay)+"분 전");
						}
					}
					
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return lists;
	}
	
	@RequestMapping(value = "/walk/scrollDownMyWalk.do", method = RequestMethod.POST)
	@ResponseBody
	public List<WalkVO> scrollDown(@RequestParam("num") int num, HttpSession session){
		LOGGER.info("scrollDown");
		
		num--;
		String user_id = (String)session.getAttribute("user_id");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		HashMap<String, Object> maps = new HashMap<String, Object>();
		maps.put("user_id", user_id);
		maps.put("num", num);
		List<WalkVO> lists = walkService.scrollDownMy(maps);
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
	
	@RequestMapping(value = "/community/scrollDownMyScrap.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CommunityVO> scrollDownMyComScrap(@RequestParam("num") int num, HttpSession session){
		LOGGER.info("scrollDownMy");
		num--;
		String user_id = (String)session.getAttribute("user_id");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		HashMap<String, Object> maps = new HashMap<String, Object>();
		maps.put("user_id", user_id);
		maps.put("num", num);
		List<CommunityVO> lists =  comService.scrollDownMyScrap(maps);
		
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
						lists.get(i).setDate(diffDay+"일 전");
					}else {
						endDate = sdf.parse(lists.get(i).getDate());
						diffDay = (startDate.getTime() - endDate.getTime()) / (60*1000);
						if(diffDay > 60) {
							lists.get(i).setDate((diffDay/60)+"시간 전");
						}else if(diffDay == 0){
							lists.get(i).setDate("방금 전");
						}else {
							lists.get(i).setDate((diffDay)+"분 전");
						}
					}
					
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return lists;
	}
	
	@RequestMapping(value = "/walk/scrollDownMyScrap.do", method = RequestMethod.POST)
	@ResponseBody
	public List<WalkVO> scrollDownMyWalkScrap(@RequestParam("num") int num, HttpSession session){
		LOGGER.info("scrollDown");
		
		num--;
		String user_id = (String)session.getAttribute("user_id");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		HashMap<String, Object> maps = new HashMap<String, Object>();
		maps.put("user_id", user_id);
		maps.put("num", num);
		List<WalkVO> lists = walkService.scrollDownMyScrap(maps);
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
}

