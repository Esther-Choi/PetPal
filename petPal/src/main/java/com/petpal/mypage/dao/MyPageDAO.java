package com.petpal.mypage.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.petpal.user.vo.PetVO;
import com.petpal.user.vo.UserVO;

@Repository
public class MyPageDAO {
	
	@Autowired
	private SqlSessionTemplate sql;
	

}
