package com.petpal.user.controller;

import java.io.File;
import java.util.Arrays;
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
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.petpal.user.service.UserService;
import com.petpal.user.vo.PetVO;
import com.petpal.user.vo.UserVO;
import com.petpal.utils.UploadFileUtils;

@Controller
@RequestMapping("/user/*")
public class UserController {

	private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);
	
	@Autowired
	private UserService userService;
	
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
	
}
