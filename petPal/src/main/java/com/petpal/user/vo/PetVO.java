package com.petpal.user.vo;

public class PetVO {
	
	private String user_id;
	private String pet_photo;
	private String pet_photothumb;
	private String pet_name;
	private String pet_age;
	private String pet_gender;
	private String pet_breed;
	private String address;
	private String pet_weight;
	private String surgery;
	private String likes;
	private String dislikes;
	private String character1;
	private String character2;
	private String character3;
	private String tip;
	
	
	
	
	@Override
	public String toString() {
		return "PetVO [user_id=" + user_id + ", pet_photo=" + pet_photo + ", pet_photothumb=" + pet_photothumb
				+ ", pet_name=" + pet_name + ", pet_age=" + pet_age + ", pet_gender=" + pet_gender + ", pet_breed="
				+ pet_breed + ", address=" + address + ", pet_weight=" + pet_weight + ", surgery=" + surgery
				+ ", likes=" + likes + ", dislikes=" + dislikes + ", character1=" + character1 + ", character2="
				+ character2 + ", character3=" + character3 + ", tip=" + tip + "]";
	}
	
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getPet_photo() {
		return pet_photo;
	}
	public void setPet_photo(String pet_photo) {
		this.pet_photo = pet_photo;
	}
	
	public String getPet_photothumb() {
		return pet_photothumb;
	}

	public void setPet_photothumb(String pet_photothumb) {
		this.pet_photothumb = pet_photothumb;
	}

	public String getPet_name() {
		return pet_name;
	}
	public void setPet_name(String pet_name) {
		this.pet_name = pet_name;
	}
	public String getPet_age() {
		return pet_age;
	}
	public void setPet_age(String pet_age) {
		this.pet_age = pet_age;
	}
	public String getPet_gender() {
		return pet_gender;
	}
	public void setPet_gender(String pet_gender) {
		this.pet_gender = pet_gender;
	}
	public String getPet_breed() {
		return pet_breed;
	}
	public void setPet_breed(String pet_breed) {
		this.pet_breed = pet_breed;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPet_weight() {
		return pet_weight;
	}
	public void setPet_weight(String pet_weight) {
		this.pet_weight = pet_weight;
	}
	public String getSurgery() {
		return surgery;
	}
	public void setSurgery(String surgery) {
		this.surgery = surgery;
	}
	public String getLikes() {
		return likes;
	}
	public void setLikes(String likes) {
		this.likes = likes;
	}
	public String getDislikes() {
		return dislikes;
	}
	public void setDislikes(String dislikes) {
		this.dislikes = dislikes;
	}
	public String getCharacter1() {
		return character1;
	}
	public void setCharacter1(String character1) {
		this.character1 = character1;
	}
	public String getCharacter2() {
		return character2;
	}
	public void setCharacter2(String character2) {
		this.character2 = character2;
	}
	public String getCharacter3() {
		return character3;
	}
	public void setCharacter3(String character3) {
		this.character3 = character3;
	}
	public String getTip() {
		return tip;
	}
	public void setTip(String tip) {
		this.tip = tip;
	}
	
	

}
