package com.petpal.community.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.petpal.community.vo.CommunityVO;
import com.petpal.walk.vo.WalkVO;

@Repository
public class CommunityDAO {
	
	@Autowired
	private SqlSessionTemplate sql;
	
	private static final String namespace = "community.dao.CommunityDAO";
	
	public int insertCommunity(CommunityVO comVO) {
		return sql.insert(namespace + ".insertCommunity", comVO);
	}
	
	public java.util.List<CommunityVO> selectComList(){
		return sql.selectList(namespace + ".selectComList");
	}
	
	public List<CommunityVO> scrollDown(int num){
		return sql.selectList(namespace + ".scrollDown", num);
	}
	
	public CommunityVO getCom(int num) {
		return sql.selectOne(namespace + ".getCom", num);
	}

}
