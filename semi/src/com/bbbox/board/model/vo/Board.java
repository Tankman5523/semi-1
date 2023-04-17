package com.bbbox.board.model.vo;

import java.sql.Date;

public class Board {
	/* 필드
	BOARD_NO	NUMBER
	BOARD_WRITER	NUMBER
	CATEGORY_NO	NUMBER
	TITLE	VARCHAR2(100 BYTE)
	CONTENT	VARCHAR2(4000 BYTE)
	COUNT	NUMBER
	CREATE_DATE	DATE
	LIKED	NUMBER
	REPORT_COUNT	NUMBER
	NOTICE	VARCHAR2(1 BYTE)
	RP_COUNT	NUMBER
	STATUS	VARCHAR2(1 BYTE)
	*/
	private int boardNo;
	private String boardWriter;
	private int categoryNo;
	private String title;
	private String content;
	private int count;
	private Date createDate;
	private int liked;
	private int reportCount;
	private String notice;
	private int rpCount;
	private String status;
	
	
	//생성자
	public Board() {
		super();
	}
	
	public Board(int boardNo, String boardWriter, int categoryNo, String title, String content, int count, Date createDate,
			int liked, int reportCount, String notice, int rpCount, String status) {
		super();
		this.boardNo = boardNo;
		this.boardWriter = boardWriter;
		this.categoryNo = categoryNo;
		this.title = title;
		this.content = content;
		this.count = count;
		this.createDate = createDate;
		this.liked = liked;
		this.reportCount = reportCount;
		this.notice = notice;
		this.rpCount = rpCount;
		this.status = status;
	}
	
	
	//게시판리스트관련 생성자
	public Board(int boardNo, String boardWriter, String title, int count, Date createDate) {
		super();
		this.boardNo = boardNo;
		this.boardWriter = boardWriter;
		this.title = title;
		this.count = count;
		this.createDate = createDate;
	}

	//게터세터
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getBoardWriter() {
		return boardWriter;
	}
	public void setBoardWriter(String boardWriter) {
		this.boardWriter = boardWriter;
	}
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
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
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public Date getCreateDate() {
		return createDate;
	}
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public int getLiked() {
		return liked;
	}
	public void setLiked(int liked) {
		this.liked = liked;
	}
	public int getReportCount() {
		return reportCount;
	}
	public void setReportCount(int reportCount) {
		this.reportCount = reportCount;
	}
	public String getNotice() {
		return notice;
	}
	public void setNotice(String notice) {
		this.notice = notice;
	}
	public int getRpCount() {
		return rpCount;
	}
	public void setRpCount(int rpCount) {
		this.rpCount = rpCount;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	
	
	@Override
	public String toString() {
		return "Board [boardNo=" + boardNo + ", boardWriter=" + boardWriter + ", categoryNo=" + categoryNo + ", title="
				+ title + ", content=" + content + ", count=" + count + ", createDate=" + createDate + ", liked="
				+ liked + ", reportCount=" + reportCount + ", notice=" + notice + ", rpCount=" + rpCount + ", status="
				+ status + "]";
	}
	
}
