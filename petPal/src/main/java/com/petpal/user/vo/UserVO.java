package com.petpal.user.vo;

import lombok.Data;
import lombok.ToString;

@Data
public class UserVO extends PetVO{
	
	private String user_id;
	private String user_pw;
	private String user_name;
	private String user_gender;
	private String user_birth;
	private String walk_day;
	private String walk_time;
	private String walk_hour;
	private String walk_minute;
	private String walk_place1;
	private String walk_place2;
	private String walk_style;
	
	
	@Override
	public String toString() {
		return "UserVO [user_id=" + user_id + ", user_pw=" + user_pw + ", user_name=" + user_name + ", user_gender="
				+ user_gender + ", user_birth=" + user_birth + ", walk_day=" + walk_day + ", walk_time=" + walk_time
				+ ", walk_hour=" + walk_hour + ", walk_minute=" + walk_minute + ", walk_place1=" + walk_place1
				+ ", walk_place2=" + walk_place2 + ", walk_style=" + walk_style + "]";
	}
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getUser_pw() {
		return user_pw;
	}
	public void setUser_pw(String user_pw) {
		this.user_pw = user_pw;
	}
	public String getUser_name() {
		return user_name;
	}
	public void setUser_name(String user_name) {
		this.user_name = user_name;
	}
	public String getUser_gender() {
		return user_gender;
	}
	public void setUser_gender(String user_gender) {
		this.user_gender = user_gender;
	}
	public String getUser_birth() {
		return user_birth;
	}
	public void setUser_birth(String user_birth) {
		this.user_birth = user_birth;
	}
	public String getWalk_day() {
		return walk_day;
	}
	public void setWalk_day(String walk_day) {
		this.walk_day = walk_day;
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
	public String getWalk_place1() {
		return walk_place1;
	}
	public void setWalk_place1(String walk_place1) {
		this.walk_place1 = walk_place1;
	}
	public String getWalk_place2() {
		return walk_place2;
	}
	public void setWalk_place2(String walk_place2) {
		this.walk_place2 = walk_place2;
	}
	public String getWalk_style() {
		return walk_style;
	}
	public void setWalk_style(String walk_style) {
		this.walk_style = walk_style;
	}
	
	
}
