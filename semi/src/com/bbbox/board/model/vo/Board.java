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
	
	//사건정보와 묶어서 가져갈 필드(필터검색용)
	private int ref_pno; //사건종류 번호
	private String insuranceType; //보험유형
	private String region; //지역
	
	//썸네일용 파일경로 가져가기
	private String filePath;
	private String changeName;

	//마이페이지로 가져갈 categoryName 
	private String categoryName;
	private int accNo;

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
	public Board(int boardNo, String boardWriter, int categoryNo, String title, int count, Date createDate, int liked, int rpCount) {
		super();
		this.boardNo = boardNo;
		this.boardWriter = boardWriter;
		this.categoryNo = categoryNo;
		this.title = title;
		this.count = count;
		this.createDate = createDate;
		this.liked = liked;
		this.rpCount = rpCount;
	}
	
	//특정 게시글 하나 조회하는데 관련된 생성자
	public Board(int boardNo, String boardWriter, int categoryNo, String title, String content, int count, Date createDate, int liked,
			int rpCount) {
		super();
		this.boardNo = boardNo;
		this.boardWriter = boardWriter;
		this.categoryNo = categoryNo;
		this.title = title;
		this.content = content;
		this.count = count;
		this.createDate = createDate;
		this.liked = liked;
		this.rpCount = rpCount;
	}
	

	//사건영상게시판 리스트 생성자
	public Board(int boardNo, String boardWriter, String title, int count, Date createDate, int ref_pno,
			String insuranceType, String region, String filePath, String changeName) {
		super();
		this.boardNo = boardNo;
		this.boardWriter = boardWriter;
		this.title = title;
		this.count = count;
		this.createDate = createDate;
		this.ref_pno = ref_pno;
		this.insuranceType = insuranceType;
		this.region = region;
		this.filePath = filePath;
		this.changeName = changeName;
	}
	
	//검색을 위한 리스트 생성자
	public Board(int boardNo, String boardWriter, String title, int count, Date createDate, int ref_pno,
			String insuranceType, String region, String filePath, String changeName,int categoryNo) {
		super();
		this.boardNo = boardNo;
		this.boardWriter = boardWriter;
		this.title = title;
		this.count = count;
		this.createDate = createDate;
		this.ref_pno = ref_pno;
		this.insuranceType = insuranceType;
		this.region = region;
		this.filePath = filePath;
		this.changeName = changeName;
		this.categoryNo = categoryNo;
	}
	
	//마이페이지에서 내가쓴글 보여주기 위한 리스트 생성자 
	public Board(int boardNo, String title, Date createDate, String categoryName, int accNo) {
		super();
		this.boardNo = boardNo;
		this.title = title;
		this.createDate = createDate;
		this.categoryName = categoryName;
		this.accNo = accNo;
	}
	
	//관리자 자유게시판 글관리위한 생성자
	public Board(int boardNo, String boardWriter, int categoryNo, String title, int count, Date createDate, int liked,
			int reportCount, int rpCount, String status) {
		super();
		this.boardNo = boardNo;
		this.boardWriter = boardWriter;
		this.categoryNo = categoryNo;
		this.title = title;
		this.count = count;
		this.createDate = createDate;
		this.liked = liked;
		this.reportCount = reportCount;
		this.rpCount = rpCount;
		this.status = status;
	}

	//마이페이지용 카테고리 이름 게터세터 
	public String getCategoryName() {
		return categoryName;
	}
	
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	
	
	public int getAccNo() {
		return accNo;
	}

	public void setAccNo(int accNo) {
		this.accNo = accNo;
	}

	//사건필드 게터세터
	public int getRef_pno() {
		return ref_pno;
	}


	public void setRef_pno(int ref_pno) {
		this.ref_pno = ref_pno;
	}
	
	public String getInsuranceType() {
		return insuranceType;
	}
	
	public void setInsuranceType(String insuranceType) {
		this.insuranceType = insuranceType;
	}
	
	public String getRegion() {
		return region;
	}
	
	public void setRegion(String region) {
		this.region = region;
	}
	
	//파일패스 게터세터
	
	public String getFilePath() {
		return filePath;
	}
	
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	//변경된 첨부파일 이름 게터세터
	
	public String getChangeName() {
		return changeName;
	}
	
	public void setChangeName(String changeName) {
		this.changeName = changeName;
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
