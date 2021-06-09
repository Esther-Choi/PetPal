package com.petpal.user.service;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petpal.user.dao.UserDAO;
import com.petpal.user.vo.PetVO;
import com.petpal.user.vo.UserVO;

@Service
public class UserService {
	
	@Autowired
	private UserDAO userDAO;
	
	//회원가입
	public boolean join(UserVO userVO, PetVO petVO) throws Exception{
		
		if(userDAO.insertUser(userVO) == 1 && userDAO.insertPet(petVO) == 1) {
			return true;
		}else {
			return false;
		}
	}
	
	public String checkId(String user_id) {
		
		if(userDAO.checkId(user_id) == 0) {
			return "yes";
		}
		
		return "no";
	}
	
	public String checkNickname(String user_name) {
			
		if(userDAO.checkNickname(user_name) == 0) {
			return "yes";
		}
		
		return "no";
	}
	
	public UserVO login(String user_id) {
		
		return userDAO.login(user_id);
	}

}
