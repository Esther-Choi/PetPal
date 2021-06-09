package com.petpal.user.dao;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.petpal.user.vo.PetVO;
import com.petpal.user.vo.UserVO;

@Repository
public class UserDAO {
	
	@Autowired
	private SqlSessionTemplate sql;
	
	 private static final String namespace = "user.dao.UserDAO";
	
	public int insertUser(UserVO userVO) {
		return sql.insert(namespace + ".insertUser", userVO);
	}
	
	public int insertPet(PetVO petVO) {
		return sql.insert(namespace + ".insertPet", petVO);
	}
	
	public int checkId(String user_id) {
		return sql.selectOne(namespace + ".checkId", user_id);
	}
	
	public int checkNickname(String user_name) {
		return sql.selectOne(namespace + ".checkNickname", user_name);
	}
	
	public UserVO login(String user_id) {
		return sql.selectOne(namespace + ".login", user_id);
	}

}
