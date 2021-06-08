package com.petpal.user.dao;

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

}
