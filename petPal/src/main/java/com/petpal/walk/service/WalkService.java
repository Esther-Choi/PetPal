package com.petpal.walk.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petpal.walk.dao.WalkDAO;
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
}
