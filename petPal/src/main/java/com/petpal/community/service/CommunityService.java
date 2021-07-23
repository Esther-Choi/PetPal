package com.petpal.community.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.petpal.community.dao.CommunityDAO;
import com.petpal.community.vo.ComLikeVO;
import com.petpal.community.vo.ComScrapVO;
import com.petpal.community.vo.CommentVO;
import com.petpal.community.vo.CommunityVO;
import com.petpal.walk.vo.WalkLikeVO;

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
	
	public boolean editCom(CommunityVO comVO) {
		if(comDAO.editCom(comVO) == 1) {
			return true;
		}
		
		return false;
	}
	
	public boolean deleteCom(int num) {
		if(comDAO.deleteCom(num) == 1) {
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
	
	public List<CommentVO> getCommentList(int num) {
		return comDAO.getCommentList(num);
	}
	
	public boolean insertComment(CommentVO comment) {
		if(comDAO.insertComment(comment) == 1 ) {
			return true;
		}
		
		return false;
	}
	
	public boolean insertLike(ComLikeVO comLikeVO) {
		
		if(comDAO.insertLike(comLikeVO) == 1) {
			return true;
		}
		
		return false;
	}
	
	public boolean updateLike(ComLikeVO comLikeVO) {
		
		if(comDAO.updateLike(comLikeVO) == 1) {
			return true;
		}
		
		return false;
	}
	
	public int searchComLike(ComLikeVO comLikeVO) {
		return comDAO.searchComLike(comLikeVO);
	}
	
	public Integer getComLike(HashMap<String, Object> map) {
		return comDAO.getComLike(map);
	}
	
	
	public boolean insertScrap(ComScrapVO comScrapVO) {
		
		if(comDAO.insertScrap(comScrapVO) == 1) {
			return true;
		}
		
		return false;
	}
	
	public boolean updateScrap(ComScrapVO comScrapVO) {
		
		if(comDAO.updateScrap(comScrapVO) == 1) {
			return true;
		}
		
		return false;
	}
	
	public int searchComScrap(ComScrapVO comScrapVO) {
		return comDAO.searchComScrap(comScrapVO);
	}
	
	public Integer getComScrap(HashMap<String, Object> map) {
		return comDAO.getComScrap(map);
	}

}
