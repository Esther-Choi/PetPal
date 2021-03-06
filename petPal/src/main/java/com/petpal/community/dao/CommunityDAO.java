package com.petpal.community.dao;

import java.util.HashMap;
import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.petpal.community.vo.ComLikeVO;
import com.petpal.community.vo.ComScrapVO;
import com.petpal.community.vo.CommentVO;
import com.petpal.community.vo.CommunityVO;
import com.petpal.walk.vo.WalkLikeVO;
import com.petpal.walk.vo.WalkVO;

@Repository
public class CommunityDAO {
	
	@Autowired
	private SqlSessionTemplate sql;
	
	private static final String namespace = "community.dao.CommunityDAO";
	
	public int insertCommunity(CommunityVO comVO) {
		return sql.insert(namespace + ".insertCommunity", comVO);
	}
	
	public int editCom(CommunityVO comVO) {
		return sql.update(namespace + ".editCom", comVO);
	}
	
	public int deleteCom(int num) {
		return sql.delete(namespace + ".deleteCom", num);
	}
	
	public java.util.List<CommunityVO> selectComList(){
		return sql.selectList(namespace + ".selectComList");
	}
	
	public java.util.List<CommunityVO> selectMyComList(String user_id){
		return sql.selectList(namespace + ".selectMyComList", user_id);
	}
	
	public java.util.List<CommunityVO> selectMyComScrap(String user_id){
		return sql.selectList(namespace + ".selectMyComScrap", user_id);
	}
	
	public List<CommunityVO> scrollDown(int num){
		return sql.selectList(namespace + ".scrollDown", num);
	}
	
	public List<CommunityVO> scrollDownMy(HashMap<String, Object> map){
		return sql.selectList(namespace + ".scrollDownMy", map);
	}
	
	public List<CommunityVO> scrollDownMyScrap(HashMap<String, Object> map){
		return sql.selectList(namespace + ".scrollDownMyScrap", map);
	}
	
	public CommunityVO getCom(int num) {
		return sql.selectOne(namespace + ".getCom", num);
	}
	
	public List<CommentVO> getCommentList(int num) {
		return sql.selectList(namespace + ".getCommentList", num);
	}
	
	public int insertComment(CommentVO commentVO) {
		return sql.insert(namespace + ".insertComment", commentVO);
	}
	
	//게시글 좋아요 최초 삽입
	public int insertLike(ComLikeVO comLikeVO) {
		return sql.insert(namespace + ".insertLike", comLikeVO);
	}
	
	
	//좋아요 여부 가져오기
	public Integer getComLike(HashMap<String, Object> map) {
		return sql.selectOne(namespace + ".getComLike", map);
	}
	
	//좋아요 업데이트
	public int deleteLike(ComLikeVO comLikeVO) {
		return sql.delete(namespace + ".deleteLike", comLikeVO);
	}
	
	
	//게시글 스크랩 최초 삽입
	public int insertScrap(ComScrapVO comScrapVO) {
		return sql.insert(namespace + ".insertScrap", comScrapVO);
	}
	
	//스크랩 여부 가져오기
	public Integer getComScrap(HashMap<String, Object> map) {
		return sql.selectOne(namespace + ".getComScrap", map);
	}
	
	//스크랩 업데이트
	public int deleteScrap(ComScrapVO comScrapVO) {
		return sql.delete(namespace + ".deleteScrap", comScrapVO);
	}
	

}
