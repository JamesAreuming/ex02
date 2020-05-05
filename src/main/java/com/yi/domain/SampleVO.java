package com.yi.domain;

public class SampleVO {
	private int no;
	private String firstName;
	private String lastName;
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	
	@Override
	public String toString() {
		return "SampleVO [no=" + no + ", firstName=" + firstName + ", lastName=" + lastName + "]";
	}
	
	
	
}
