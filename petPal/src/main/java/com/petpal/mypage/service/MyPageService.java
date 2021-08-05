package com.petpal.mypage.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petpal.mypage.dao.MyPageDAO;
import com.petpal.user.vo.PetVO;
import com.petpal.user.vo.UserVO;

@Service
public class MyPageService {
	
	@Autowired
	private MyPageDAO mypageDAO;
	
}
