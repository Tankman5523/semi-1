package com.bbbox.member.model.vo;

import java.sql.Date;

public class Member {
	private int userNo;			//USER_NO	NUMBER
	private String userId; 		//USER_ID	VARCHAR2(30 BYTE)
	private String userPwd;		//USER_PWD	VARCHAR2(100 BYTE)
	private String userName; 	//USER_NAME	VARCHAR2(15 BYTE)
	private String phone;		//PHONE	VARCHAR2(13 BYTE)
	private String email;		//EMAIL	VARCHAR2(100 BYTE)
	private String address;		//ADDRESS	VARCHAR2(100 BYTE)
	private Date enrollDate;	//ENROLL_DATE	DATE
	private String status;		//STATUS	VARCHAR2(1 BYTE) -- Y/N
	private String admin;		//ADMIN	VARCHAR2(1 BYTE)-- Y/N
	private String lawyer; 		//LAWYER	VARCHAR2(1 BYTE) --Y/N
	
	// 관리자 사용 필드 
	private int lawNo; // 변호사 번호  
	private int boardCount; // 게시글 수 
	private int replyCount; // 댓글 수 
	
	
	public Member() {
		super();
	}

	
	//회원정보수정 생성자 
	public Member(int userNo, String userId, String userPwd, String userName, String phone, String email,
			String address, Date enrollDate, String status, String admin, String lawyer) {
		super();
		this.userNo = userNo;
		this.userId = userId;
		this.userPwd = userPwd;
		this.userName = userName;
		this.phone = phone;
		this.email = email;
		this.address = address;
		this.enrollDate = enrollDate;
		this.status = status;
		this.admin = admin;
		this.lawyer = lawyer;
	}

	//회원가입시 사용할 매개변수 생성자
	public Member(String userId, String userPwd, String userName, String phone, String email, String address) {
		super();
		this.userId = userId;
		this.userPwd = userPwd;
		this.userName = userName;
		this.phone = phone;
		this.email = email;
		this.address = address;
	}
	
	//아이디 비밀번호 찾기,이메일 중복시 사용할 매개변수 생성자 
	public Member(String userId, String userPwd) {
		super();
		this.userId = userId;
		this.userPwd = userPwd;
	}

	//찜한 변호사 이름, 번호 조회해오기 위한 생성자 
	public Member(int userNo, String userName) {
		super();
		this.userNo = userNo;
		this.userName = userName;
	}
	
	//관리자_변호사회원 신청 조회 생성자 
	public Member(int lawNo, int userNo, String userName, String userId,  Date enrollDate, String lawyer) {
		super();
		this.lawNo = lawNo;
		this.userNo = userNo;
		this.userName = userName;
		this.userId = userId;
		this.enrollDate = enrollDate;
		this.lawyer = lawyer;
	}
	
	//관리자 _ 변호사 회원 신청 내용 조회 생성자
	
	public Member(int userNo, String userId, String userName, String phone, String email, String address) {
		super();
		this.userNo = userNo;
		this.userId = userId;
		this.userName = userName;
		this.phone = phone;
		this.email = email;
		this.address = address;
	}

	//관리자_ 전체 회원 조회 생성자 
	
	
	
	public int getUserNo() {
		return userNo;
	}

	public Member(int userNo, String userId, String userName, String lawyer, Date enrollDate, String status, 
			 int boardCount, int replyCount) {
		super();
		this.userNo = userNo;
		this.userId = userId;
		this.userName = userName;
		this.lawyer = lawyer;
		this.enrollDate = enrollDate;
		this.status = status;
		this.boardCount = boardCount;
		this.replyCount = replyCount;
	}


	public int getBoardCount() {
		return boardCount;
	}


	public void setBoardCount(int boardCount) {
		this.boardCount = boardCount;
	}


	public int getReplyCount() {
		return replyCount;
	}


	public void setReplyCount(int replyCount) {
		this.replyCount = replyCount;
	}


	public void setUserNo(int userNo) {
		this.userNo = userNo;
	}


	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public String getUserPwd() {
		return userPwd;
	}


	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}


	public String getUserName() {
		return userName;
	}


	public void setUserName(String userName) {
		this.userName = userName;
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getAddress() {
		return address;
	}


	public void setAddress(String address) {
		this.address = address;
	}


	public Date getEnrollDate() {
		return enrollDate;
	}


	public void setEnrollDate(Date enrollDate) {
		this.enrollDate = enrollDate;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getAdmin() {
		return admin;
	}


	public void setAdmin(String admin) {
		this.admin = admin;
	}


	public String getLawyer() {
		return lawyer;
	}


	public void setLawyer(String lawyer) {
		this.lawyer = lawyer;
	}


	@Override
	public String toString() {
		return "Member : userNo=" + userNo + ", userId=" + userId + ", userPwd=" + userPwd + ", userName=" + userName
				+ ", phone=" + phone + ", email=" + email + ", address=" + address + ", enrollDate=" + enrollDate
				+ ", status=" + status + ", admin=" + admin + ", lawyer=" + lawyer;
	}
	
	
	
}
