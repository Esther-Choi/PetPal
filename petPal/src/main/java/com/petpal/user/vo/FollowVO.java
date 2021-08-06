package com.petpal.user.vo;

public class FollowVO {
	
	private int num;
	private String user_id;
	private String follow_id;
	
	
	@Override
	public String toString() {
		return "FollowVO [num=" + num + ", user_id=" + user_id + ", follow_id=" + follow_id + "]";
	}
	
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getFollow_id() {
		return follow_id;
	}
	public void setFollow_id(String follow_id) {
		this.follow_id = follow_id;
	}
	
	

}
