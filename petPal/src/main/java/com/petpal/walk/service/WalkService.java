package com.petpal.walk.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petpal.walk.dao.WalkDAO;
import com.petpal.walk.vo.WalkLikeVO;
import com.petpal.walk.vo.WalkVO;

@Service
public class WalkService {

	@Autowired
	private WalkDAO walkDAO;
	
	public boolean insertWalk(WalkVO walkVO) {
		
		if(walkDAO.insertWalk(walkVO) == 1) {
			return true;
		}
		
		return false;
	}
	
	public boolean editWalk(WalkVO walkVO) {
		
		if(walkDAO.editWalk(walkVO) == 1) {
			return true;
		}
		
		return false;
	}
	
	public boolean deleteWalk(int numO) {
		
		if(walkDAO.deleteWalk(numO) == 1) {
			return true;
		}
		
		return false;
	}
	
	public boolean insertLike(WalkLikeVO walkLikeVO) {
		
		if(walkDAO.insertLike(walkLikeVO) == 1) {
			return true;
		}
		
		return false;
	}
	
	public boolean deleteLike(WalkLikeVO walkLikeVO) {
		
		if(walkDAO.deleteLike(walkLikeVO) == 1) {
			return true;
		}
		
		return false;
	}
	
	public List<WalkVO> selectWalkList(){
		return walkDAO.selectWalkList();
	}
	
	public List<WalkVO> selectMyWalkList(String user_id){
		return walkDAO.selectMyWalkList(user_id);
	}
	
	public List<WalkVO> selectMyWalkScrap(String user_id){
		return walkDAO.selectMyWalkScrap(user_id);
	}
	
	public List<WalkVO> scrollDown(int num){
		return walkDAO.scrollDown(num);
	}
	
	public List<WalkVO> scrollDownMy(HashMap<String, Object> map){
		return walkDAO.scrollDownMy(map);
	}
	
	public List<WalkVO> scrollDownMyScrap(HashMap<String, Object> map){
		return walkDAO.scrollDownMyScrap(map);
	}
	
	public WalkVO getWalk(int num) {
		return walkDAO.getWalk(num);
	}
	
	public Integer getWalkLike(HashMap<String, Object> map) {
		return walkDAO.getWalkLike(map);
	}
	
}
