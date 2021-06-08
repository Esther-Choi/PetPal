package com.petpal.user.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petpal.user.dao.UserDAO;
import com.petpal.user.vo.PetVO;
import com.petpal.user.vo.UserVO;

@Service
public class UserService {
	
	@Autowired
	private UserDAO userDAO;
	
	public boolean join(UserVO userVO, PetVO petVO) throws Exception{
		
		if(userDAO.insertUser(userVO) == 1 && userDAO.insertPet(petVO) == 1) {
			return true;
		}else {
			return false;
		}
	}

}
