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
	
	public boolean join(UserVO user, PetVO pet) throws Exception{
		
		if(userDAO.insertUser(user) == 1 && userDAO.insertPet(pet) == 1) {
			return true;
		}else {
			return false;
		}
	}

}
