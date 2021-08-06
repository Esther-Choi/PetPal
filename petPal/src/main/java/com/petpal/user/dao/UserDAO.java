package com.petpal.user.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.petpal.user.vo.FollowVO;
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
	
	public UserVO getUser(String user_id) {
		return sql.selectOne(namespace + ".getUser", user_id);
	}
	
	public PetVO getPet(String user_id) {
		return sql.selectOne(namespace + ".getPet", user_id);
	}
	
	public int editUser(UserVO userVO) {
		return sql.update(namespace + ".editUser", userVO);
	}
	
	public int editPet(PetVO petVO) {
		return sql.update(namespace + ".editPet", petVO);
	}
	
	public int insertFollow(FollowVO followVO) {
		return sql.insert(namespace + ".insertFollow", followVO);
	}
	
	public int deleteFollow(FollowVO followVO) {
		return sql.delete(namespace + ".deleteFollow", followVO);
	}
	
	public int checkFollow(FollowVO followVO) {
		return sql.selectOne(namespace + ".checkFollow", followVO);
	}

	public int selectFollowCnt(String user_id) {
		return sql.selectOne(namespace + ".selectFollowCnt", user_id);
	}
	
	public List<String> selectFollowList(String user_id){
		return sql.selectList(namespace + ".selectFollowList", user_id);
	}

}
