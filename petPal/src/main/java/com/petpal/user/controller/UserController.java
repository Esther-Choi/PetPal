package com.petpal.user.controller;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import javax.annotation.Resource;
import javax.inject.Inject;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.petpal.community.service.CommunityService;
import com.petpal.community.vo.CommunityVO;
import com.petpal.user.service.UserService;
import com.petpal.user.vo.FollowVO;
import com.petpal.user.vo.PetVO;
import com.petpal.user.vo.UserVO;
import com.petpal.utils.UploadFileUtils;
import com.petpal.walk.service.WalkService;
import com.petpal.walk.vo.WalkVO;

@Controller
@RequestMapping("/user/*")
public class UserController {

	private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private WalkService walkService;
	
	@Autowired
	private CommunityService comService;
	
	@Inject
	BCryptPasswordEncoder pwdEncoder;
//	
//	@Resource(name="uploadPath")
//	private String uploadPath;
	
	@Resource(name = "uploadPath")
	private String uploadPath;
	
	//메인 페이지로 이동
	@RequestMapping(value = "main.do")
	public String main(Locale locale) throws Exception{
		LOGGER.info("Welcome home! The client locale is {}.", locale);
		return "main";
	}
	
	//로그인 페이지로 이동
	@RequestMapping(value = "login.do")
	public String login() throws Exception{
		
		LOGGER.info("login");
		return "/user/login";
	}
	
	// 회원가입 페이지로 이동(사용자 정보)
	@RequestMapping(value = "join01.do")
	public String step01 () throws Exception {
		
		LOGGER.info("join01");
		
		return "/user/join01";
	}
	
	//회원가입 페이지(강아지 정보)
	@RequestMapping(value = "join02.do", method = RequestMethod.POST)
	public String step02 (
			@ModelAttribute UserVO userVO,
			Model model,
			HttpServletRequest request,
			HttpServletResponse response,
			UserVO user,
			@RequestParam(value="walk_day") String[] days
			) throws Exception {
		
			LOGGER.info("step02");
			
			userVO.setWalk_day(Arrays.toString(days));
		
			model.addAttribute("userVO", userVO);
		
		return "/user/join02";
	}
	
	//회원가입 완료
	@RequestMapping(value="join.do", method = RequestMethod.POST)
	public String join (
			@ModelAttribute UserVO userVO,
			@ModelAttribute PetVO petVO, 
			MultipartFile file
			) throws Exception {
		
			LOGGER.info("join");
			
			String enPw = pwdEncoder.encode(userVO.getUser_pw());
			String imgUploadPath = uploadPath + File.separator + "imgUpload";
			String ymdPath = UploadFileUtils.calcPath(imgUploadPath);
			String fileName = null;
			
			if(file.getOriginalFilename() != null && file.getOriginalFilename() != "") {
				
				fileName = UploadFileUtils.fileUpload(imgUploadPath, file.getOriginalFilename(), file.getBytes(), ymdPath);
			}
//			else {
//				fileName = uploadPath + File.separator + "images" + File.separator + "none.png";
//			}
			
			petVO.setPet_photo(File.separator+"imgUpload" + ymdPath + File.separator + fileName);
			petVO.setPet_photothumb(File.separator + "imgUpload" + ymdPath + File.separator + "s" + File.separator + "s_" + fileName);
			
			userVO.setUser_pw(enPw);		
			petVO.setUser_id(userVO.getUser_id());
			Integer.parseInt(userVO.getWalk_hour());
			Integer.parseInt(userVO.getWalk_minute());
		
			try {
				
				if(userService.join(userVO, petVO)) {
					
					LOGGER.info(userVO.toString());
					LOGGER.info(petVO.toString());
					return "/user/login";
				}
				
			} catch (Exception e) {
				
				e.printStackTrace();
			}
			
			return "error";
	}
	
	@RequestMapping(value = "checkId.do", method = RequestMethod.POST)
	@ResponseBody
	public String checkId(@RequestParam("user_id") String user_id) {
		
		return userService.checkId(user_id);
	}
	
	@RequestMapping(value = "checkNickname.do", method = RequestMethod.POST)
	@ResponseBody
	public String checkNickname(@RequestParam("user_name") String user_name) {
		
		return userService.checkNickname(user_name);
	}
	
	@RequestMapping(value = "loginOk.do", method = RequestMethod.POST)
	public String login(@RequestParam("user_id") String user_id, 
			@RequestParam("user_pw") String user_pw, Model model, HttpSession session) throws Exception{
		
		LOGGER.info("loginOk");
		
		UserVO user = userService.login(user_id);
		
		try {
			if(user != null && pwdEncoder.matches(user_pw, user.getUser_pw()) == true) {
				
				session.setAttribute("user_id", user_id);
				return "redirect:/walk/list.do";
				
			}else {
				model.addAttribute("msg", "일치하는 정보가 없습니다.");
				model.addAttribute("url", "/user/login.do");
				return "/user/login";
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "error";
	}
	
	@RequestMapping(value = "/profile/main.do")
	public String main(Model model, @RequestParam("user_id") String user_id, HttpSession session) throws Exception{
		
		LOGGER.info("profile page");
		
		String id = (String)session.getAttribute("user_id");
		String name = userService.getUser(user_id).getUser_name();
		String thumb = userService.getPet(user_id).getPet_photothumb();
		
		FollowVO followVO = new FollowVO();
		followVO.setFollow_id(user_id);
		followVO.setUser_id(id);
		
		boolean check = userService.checkFollow(followVO);
		
		model.addAttribute("name", name);
		model.addAttribute("thumb", thumb);
		model.addAttribute("user_id", user_id);
		model.addAttribute("check", check);
		
		
		return "/user/profile/main";
	}
	
	@RequestMapping(value = "/profile/view.do", method = RequestMethod.GET)
	public String profile(@RequestParam("user_id") String user_id, Model model) throws Exception {
		
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
		
		return "/user/profile/view";
	}
	
	@RequestMapping(value="/walk/list.do")
	public String myWlalkList(
			HttpSession session, 
			@RequestParam(required = false) String user_id,
			Model model
			) {
		LOGGER.info("myWalkList");
		
		String url = "/user/profile/walk/list";
		String name = "";
		
		if(user_id == null) {
			
			user_id = (String)session.getAttribute("user_id");
			url = "/mypage/walk/list";
		}else {
			
			name = userService.getUser(user_id).getUser_name();
		}
		
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
			model.addAttribute("name", name);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return url;
	}
	
	@RequestMapping(value="/community/list.do")
	public String myComList(
			HttpSession session, 
			@RequestParam(required = false) String user_id,
			Model model
			) {
		LOGGER.info("myWalkList");
		
		String url = "/user/profile/community/list";
		String name ="";
		
		if(user_id == null) {
			
			user_id = (String)session.getAttribute("user_id");
			url = "/mypage/community/list";
		}else {
			
			name = userService.getUser(user_id).getUser_name();
		}
		
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
			model.addAttribute("name", name);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		return url;
	}
	
	@RequestMapping(value = "/community/scrollDownMyCom.do", method = RequestMethod.POST)
	@ResponseBody
	public List<CommunityVO> scrollDownMy(@RequestParam("num") int num, @RequestParam(required = false) String user_id, HttpSession session){
		LOGGER.info("scrollDownMy");
		num--;
		
		if(user_id == null) {
			
			user_id = (String)session.getAttribute("user_id");
		}
		
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
	public List<WalkVO> scrollDown(@RequestParam("num") int num, @RequestParam(required = false) String user_id, HttpSession session){
		LOGGER.info("scrollDown");
		
		num--;
		if(user_id == null) {
			
			user_id = (String)session.getAttribute("user_id");
		}
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
	
	@RequestMapping(value="follow.do")
	@ResponseBody
	public String insertFollow(@RequestParam("follow_id") String follow_id, @RequestParam("check") int check, HttpSession session) {
		
		LOGGER.info("insert follow");
		String user_id = (String)session.getAttribute("user_id");
		String result = "";
		try {
			FollowVO followVO = new FollowVO();
			followVO.setFollow_id(follow_id);
			followVO.setUser_id(user_id);
			
			if(check == 1) {
				if(userService.insertFollow(followVO)) {
					result = "success";
				}else {
					result = "fail";
				}
			}else {
				if(userService.deleteFollow(followVO)) {
					result = "success";
				}else {
					result = "fail";
				}
			}
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return result;
	}
	
}
