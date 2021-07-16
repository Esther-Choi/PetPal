package com.petpal.walk.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.petpal.walk.vo.WalkLikeVO;
import com.petpal.walk.vo.WalkVO;

@Repository
public class WalkDAO {
	
	@Autowired
	private SqlSessionTemplate sql;
	
	private static final String namespace = "walk.dao.WalkDAO";
	
	public int insertWalk(WalkVO walkVO) {
		return sql.insert(namespace + ".insertWalk", walkVO);
	}
	
	public java.util.List<WalkVO> selectWalkList(){
		return sql.selectList(namespace + ".selectWalkList");
	}
	
	public List<WalkVO> scrollDown(int num){
		return sql.selectList(namespace + ".scrollDown", num);
	}
	
	public WalkVO getWalk(int num) {
		return sql.selectOne(namespace + ".getWalk", num);
	}
	
	public int insertLike(WalkLikeVO walkLikeVO) {
		return sql.insert(namespace + ".insertLike", walkLikeVO);
	}
	
	public int searchWalkLike(WalkLikeVO walkLikeVO) {
		return sql.selectOne(namespace + ".searchWalkLike", walkLikeVO);
	}
	
	public Integer getWalkLike(HashMap<String, Object> map) {
		return sql.selectOne(namespace + ".getWalkLike", map);
	}
	
	public int updateLike(WalkLikeVO walkLikeVO) {
		return sql.insert(namespace + ".updateLike", walkLikeVO);
	}

}
