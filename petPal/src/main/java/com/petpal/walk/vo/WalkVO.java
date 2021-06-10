package com.petpal.walk.vo;


public class WalkVO {
	
	private int num;
	private String user_id;
	private String title;
	private String location;
	private String date;
	private String walk_time;
	private String walk_hour;
	private String walk_minute;
	private String content;
	private String reg_date;
	private String thumb;
	private String age;
	private String breed;
	
	@Override
	public String toString() {
		return "WalkVO [num=" + num + ", user_id=" + user_id + ", title=" + title + ", location=" + location + ", date="
				+ date + ", walk_day=" + walk_time + ", walk_hour=" + walk_hour + ", walk_minute=" + walk_minute
				+ ", content=" + content + "]";
	}
	
	
	
	public String getAge() {
		return age;
	}



	public void setAge(String age) {
		this.age = age;
	}



	public String getBreed() {
		return breed;
	}



	public void setBreed(String breed) {
		this.breed = breed;
	}



	public String getThumb() {
		return thumb;
	}



	public void setThumb(String thumb) {
		this.thumb = thumb;
	}



	public String getReg_date() {
		return reg_date;
	}


	public void setReg_date(String reg_date) {
		this.reg_date = reg_date;
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
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getLocation() {
		return location;
	}
	public void setLocation(String location) {
		this.location = location;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}
	public String getWalk_time() {
		return walk_time;
	}
	public void setWalk_time(String walk_time) {
		this.walk_time = walk_time;
	}
	public String getWalk_hour() {
		return walk_hour;
	}
	public void setWalk_hour(String walk_hour) {
		this.walk_hour = walk_hour;
	}
	public String getWalk_minute() {
		return walk_minute;
	}
	public void setWalk_minute(String walk_minute) {
		this.walk_minute = walk_minute;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	

}
