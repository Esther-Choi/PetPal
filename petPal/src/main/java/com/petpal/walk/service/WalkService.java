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
	
	public boolean insertLike(WalkLikeVO walkLikeVO) {
		
		if(walkDAO.insertLike(walkLikeVO) == 1) {
			return true;
		}
		
		return false;
	}
	
	public boolean updateLike(WalkLikeVO walkLikeVO) {
		
		if(walkDAO.updateLike(walkLikeVO) == 1) {
			return true;
		}
		
		return false;
	}
	
	public List<WalkVO> selectWalkList(){
		return walkDAO.selectWalkList();
	}
	
	public List<WalkVO> scrollDown(int num){
		return walkDAO.scrollDown(num);
	}
	public WalkVO getWalk(int num) {
		return walkDAO.getWalk(num);
	}
	
	public int searchWalkLike(WalkLikeVO vo) {
		return walkDAO.searchWalkLike(vo);
	}
	
	public int getWalkLike(HashMap<String, Object> map) {
		return walkDAO.getWalkLike(map);
	}
	
}
