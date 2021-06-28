package com.petpal.community.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petpal.community.dao.CommunityDAO;
import com.petpal.community.vo.CommunityVO;
import com.petpal.walk.vo.WalkVO;

@Service
public class CommunityService {
	
	@Autowired
	private CommunityDAO comDAO;
	
	public boolean insertCommunity(CommunityVO comVO) {
		if(comDAO.insertCommunity(comVO) == 1) {
			return true;
		}
		
		return false;
	}
	
	public List<CommunityVO> selectComList(){
		return comDAO.selectComList();
	}
	
	public List<CommunityVO> scrollDown(int num){
		return comDAO.scrollDown(num);
	}
	
	public CommunityVO getCom(int num) {
		return comDAO.getCom(num);
	}

}
