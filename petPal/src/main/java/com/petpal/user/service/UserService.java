package com.petpal.user.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petpal.user.dao.UserDAO;
import com.petpal.user.vo.FollowVO;
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
	
	public boolean editUser(UserVO userVO) {
		if(userDAO.editUser(userVO) == 1) {
			return true;
		}
		
		return false;
	}
	
	public boolean editPet(PetVO petVO) {
		if(userDAO.editPet(petVO) == 1) {
			return true;
		}
		
		return false;
	}
	
	public UserVO login(String user_id) {
		
		return userDAO.login(user_id);
	}
	
	public UserVO getUser(String user_id) {
		return userDAO.getUser(user_id);
	}
	
	public PetVO getPet(String user_id) {
		return userDAO.getPet(user_id);
	}
	
	public boolean insertFollow(FollowVO followVO) throws Exception{
		
		if(userDAO.insertFollow(followVO) == 1) {
			return true;
		}else {
			return false;
		}
	}
	
	public boolean deleteFollow(FollowVO followVO) throws Exception{
		
		if(userDAO.deleteFollow(followVO) == 1) {
			return true;
		}else {
			return false;
		}
	}
	
	public boolean checkFollow(FollowVO followVO) {
		if(userDAO.checkFollow(followVO) == 1) {
			return true;
		}
		
		return false;
	}
	
	public int selectFollowCnt(String user_id) {
		return userDAO.selectFollowCnt(user_id);
	}
	
	public List<String> selectFollowList(String user_id){
		return userDAO.selectFollowList(user_id);
	}

}
