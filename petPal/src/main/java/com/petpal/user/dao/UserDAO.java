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
	
	public int insertUser(UserVO user) {
		return sql.insert("insertUser", user);
	}
	
	public int insertPet(PetVO pet) {
		return sql.insert("insertPet", pet);
	}

}
