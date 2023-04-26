package com.bbbox.qaboard.model.vo;

import java.sql.Date;

public class Question {
	private int qNo;   			//문의글 번호 
	private String qWriter; 	//문의글 작성자
	private String categoryName; //보드 타입 
	private String title; 		//문의글 제목 
	private String content ; 	//문의글 내용 
	private String answer; 		//문의글 답변 
	private Date date;			//문의글 작성 날짜 
	private String open; 		//문의글 공개 여부 
	private String admin; 		//관리자 권한 여부
	private String status; 
	
	
	public Question() {
		super();
	}

	public Question(int qNo, String qWriter, String categoryName, String title, String content, String answer,
			Date date, String open, String admin, String status) {
		super();
		this.qNo = qNo;
		this.qWriter = qWriter;
		this.categoryName = categoryName;
		this.title = title;
		this.content = content;
		this.answer = answer;
		this.date = date;
		this.open = open;
		this.admin = admin;
		this.status = status;
	}
	
	//문의글 목록 조회용 생성자  
	public Question(int qNo, String qWriter, String title, Date date, String open) {
		super();
		this.qNo = qNo;
		this.qWriter = qWriter;
		this.title = title;
		this.date = date;
		this.open = open;
	}

	//디테일뷰 조회용 생성자 
	public Question(int qNo, String qWriter, String title, String content, String answer, Date date, String open) {
		super();
		this.qNo = qNo;
		this.qWriter = qWriter;
		this.title = title;
		this.content = content;
		this.answer = answer;
		this.date = date;
		this.open = open;
	}

	//마이페이지에서 문의 조회시 보여질 생성자 
	
	public Question(int qNo, String title, String categoryName, Date date) {
		super();
		this.qNo = qNo;
		this.title = title;
		this.categoryName = categoryName;
		this.date = date;
	}

	public int getqNo() {
		return qNo;
	}


	public void setqNo(int qNo) {
		this.qNo = qNo;
	}

	public String getqWriter() {
		return qWriter;
	}

	public void setqWriter(String qWriter) {
		this.qWriter = qWriter;
	}
	
	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getAnswer() {
		return answer;
	}

	public void setAnswer(String answer) {
		this.answer = answer;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}

	public String getOpen() {
		return open;
	}

	public void setOpen(String open) {
		this.open = open;
	}

	public String getAdmin() {
		return admin;
	}

	public void setAdmin(String admin) {
		this.admin = admin;
	}
	
	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "Question [qNo=" + qNo + ", qWriter=" + qWriter + ", categoryName=" + categoryName + ", title=" + title
				+ ", content=" + content + ", answer=" + answer + ", date=" + date + ", open=" + open + ", admin="
				+ admin + ", status=" + status + "]";
	}


	
	
}
