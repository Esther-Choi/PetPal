package com.petpal.community.vo;

public class CommentVO {
	
	
	private int num;
	private int board_num;
	private String user_id;
	private String content;
	private String date;
	private String address;
	
	
	
	@Override
	public String toString() {
		return "CommentVO [num=" + num + ", board_num=" + board_num + ", user_id=" + user_id + ", content=" + content
				+ ", date=" + date + ", address=" + address + "]";
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public int getBoard_num() {
		return board_num;
	}
	public void setBoard_num(int board_num) {
		this.board_num = board_num;
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
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	
	

}
