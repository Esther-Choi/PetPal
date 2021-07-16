package com.petpal.community.vo;

public class CommunityVO {
	
	
	private int num;
	private String user_id;
	private String content;
	private int like_cnt;
	private String date;
	private String type;
	private String file;
	private String user_name;
	private Integer likecheck;
	
	@Override
	public String toString() {
		return "CommunityVO [num=" + num + ", user_id=" + user_id + ", content=" + content + ", like_cnt=" + like_cnt
				+ ", date=" + date + ", type=" + type + ", file=" + file + "]";
	}
	
	
	
	public Integer getLikecheck() {
		return likecheck;
	}



	public void setLikecheck(Integer likecheck) {
		this.likecheck = likecheck;
	}



	public String getUser_name() {
		return user_name;
	}



	public void setUser_name(String user_name) {
		this.user_name = user_name;
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
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public int getLike_cnt() {
		return like_cnt;
	}
	public void setLike_cnt(int like_cnt) {
		this.like_cnt = like_cnt;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getFile() {
		return file;
	}
	public void setFile(String file) {
		this.file = file;
	}
	
	

}
