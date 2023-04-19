package com.bbbox.board.model.vo;

public class Reply {
	/*
	RP_NO	NUMBER
	REF_BNO	NUMBER
	RP_WRITER	NUMBER
	CONTENT	VARCHAR2(300 BYTE)
	CREATE_DATE	DATE
	STATUS	VARCHAR2(1 BYTE)
	 */
	private int rpNo;
	private int refBno;
	private String rpWriter;
	private String content;
	private String createDate;
	private String status;
	
	
	public Reply() {
		super();
	}
	
	//게시글 댓글 조회구문
	public Reply(int rpNo, String rpWriter, String content, String createDate) {
		super();
		this.rpNo = rpNo;
		this.rpWriter = rpWriter;
		this.content = content;
		this.createDate = createDate;
	}

	public Reply(int rpNo, int refBno, String rpWriter, String content, String createDate, String status) {
		super();
		this.rpNo = rpNo;
		this.refBno = refBno;
		this.rpWriter = rpWriter;
		this.content = content;
		this.createDate = createDate;
		this.status = status;
	}
	
	public int getRpNo() {
		return rpNo;
	}
	public void setRpNo(int rpNo) {
		this.rpNo = rpNo;
	}
	public int getRefBno() {
		return refBno;
	}
	public void setRefBno(int refBno) {
		this.refBno = refBno;
	}
	public String getRpWriter() {
		return rpWriter;
	}
	public void setRpWriter(String rpWriter) {
		this.rpWriter = rpWriter;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getCreateDate() {
		return createDate;
	}
	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	@Override
	public String toString() {
		return "Reply [rpNo=" + rpNo + ", refBno=" + refBno + ", rpWriter=" + rpWriter + ", content=" + content
				+ ", CreateDate=" + createDate + ", status=" + status + "]";
	}
}
