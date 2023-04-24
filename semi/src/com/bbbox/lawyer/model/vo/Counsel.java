package com.bbbox.lawyer.model.vo;

import java.sql.Date;

//편의상 refLno, csWriter는 편의상 String으로
public class Counsel {
	
	private int csNo; //상담번호
	private String refLno; //참조변호사번호
	private String csWriter; //상담작성자번호
	private String csTitle; //상담제목
	private String csContent; //상담내용
	private Date createDate; //작성날짜
	private String csAnswer; //변호사답변
	private String accept; //수락여부('W'/'N'/'Y')
	private String status; //상태값
	
	
	public Counsel() {
		super();
	}
	
	//상담신청 수정하기 시 조회용
	public Counsel(int csNo, String refLno, String csTitle, String csContent) {
		super();
		this.csNo = csNo;
		this.refLno = refLno;
		this.csTitle = csTitle;
		this.csContent = csContent;
	}

	//마이페이지에서 보여줄 상담내역 조회 생성자 
	public Counsel(int csNo, String csTitle, Date createDate, String csAnswer, String accept) {
		super();
		this.csNo = csNo;
		this.csTitle = csTitle;
		this.createDate = createDate;
		this.csAnswer = csAnswer;
		this.accept = accept;
	}


	public Counsel(int csNo, String refLno, String csWriter, String csTitle, String csContent, Date createDate,
			String csAnswer, String accept, String status) {
		super();
		this.csNo = csNo;
		this.refLno = refLno;
		this.csWriter = csWriter;
		this.csTitle = csTitle;
		this.csContent = csContent;
		this.createDate = createDate;
		this.csAnswer = csAnswer;
		this.accept = accept;
		this.status = status;
	}
	
	public int getCsNo() {
		return csNo;
	}
	public void setCsNo(int csNo) {
		this.csNo = csNo;
	}
	public String getRefLno() {
		return refLno;
	}
	public void setRefLno(String refLno) {
		this.refLno = refLno;
	}
	public String getCsWriter() {
		return csWriter;
	}
	public void setCsWriter(String csWriter) {
		this.csWriter = csWriter;
	}
	public String getCsTitle() {
		return csTitle;
	}
	public void setCsTitle(String csTitle) {
		this.csTitle = csTitle;
	}
	public String getCsContent() {
		return csContent;
	}
	public void setCsContent(String csContent) {
		this.csContent = csContent;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getCsAnswer() {
		return csAnswer;
	}
	public void setCsAnswer(String csAnswer) {
		this.csAnswer = csAnswer;
	}
	public String getAccept() {
		return accept;
	}
	public void setAccept(String accept) {
		this.accept = accept;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	@Override
	public String toString() {
		return "Counsel [csNo=" + csNo + ", refLno=" + refLno + ", csWriter=" + csWriter + ", csTitle=" + csTitle
				+ ", csContent=" + csContent + ", createDate=" + createDate + ", csAnswer=" + csAnswer + ", accept="
				+ accept + ", status=" + status + "]";
	}
	
}
