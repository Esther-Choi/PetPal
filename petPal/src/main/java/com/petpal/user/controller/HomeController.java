package com.petpal.user.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/*")
public class HomeController {

	private static final Logger LOGGER = LoggerFactory.getLogger(UserController.class);
	
	@RequestMapping(value = "/")
	public String home(Locale locale) throws Exception{
		LOGGER.info("Welcome home! The client locale is {}.", locale);
		
		return "redirect:/walk/list.do";
	}

}