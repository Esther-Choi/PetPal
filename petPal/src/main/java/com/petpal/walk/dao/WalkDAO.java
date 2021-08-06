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
	
	public int editWalk(WalkVO walkVO) {
		return sql.update(namespace + ".editWalk", walkVO);
	}
	
	public int deleteWalk(int num) {
		return sql.delete(namespace + ".deleteWalk", num);
	}
	
	public java.util.List<WalkVO> selectWalkList(){
		return sql.selectList(namespace + ".selectWalkList");
	}
	
	public java.util.List<WalkVO> selectMyWalkList(String user_id){
		return sql.selectList(namespace + ".selectMyWalkList", user_id);
	}
	
	public java.util.List<WalkVO> selectMyWalkScrap(String user_id){
		return sql.selectList(namespace + ".selectMyWalkScrap", user_id);
	}
	
	public List<WalkVO> scrollDown(int num){
		return sql.selectList(namespace + ".scrollDown", num);
	}
	
	public List<WalkVO> scrollDownMy(HashMap<String, Object> map){
		return sql.selectList(namespace + ".scrollDownMy", map);
	}
	
	public List<WalkVO> scrollDownMyScrap(HashMap<String, Object> map){
		return sql.selectList(namespace + ".scrollDownMyScrap", map);
	}
	
	public WalkVO getWalk(int num) {
		return sql.selectOne(namespace + ".getWalk", num);
	}
	
	public int insertLike(WalkLikeVO walkLikeVO) {
		return sql.insert(namespace + ".insertLike", walkLikeVO);
	}
	
	public Integer getWalkLike(HashMap<String, Object> map) {
		return sql.selectOne(namespace + ".getWalkLike", map);
	}
	
	public int deleteLike(WalkLikeVO walkLikeVO) {
		return sql.delete(namespace + ".deleteLike", walkLikeVO);
	}

}
