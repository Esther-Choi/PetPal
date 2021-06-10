package com.petpal.walk.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

}
