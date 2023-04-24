package com.bbbox.lawyer.model.vo;

public class Lawyer {

	//편의상 refUno,refPno 자료형을 String으로 변경
	private int lawNo; //변호사 번호
	private String refUno; //참조 회원번호
	private String refPno; //분야 번호
	private String exam; //출신 시험
	private int examSession; //시험 회차
	private int passDate; //합격년도
	private String companyName; //사무소 이름
	private String companyAddress; //사무소 주소
	private String companyPn; //사무소 전화번호
	private String lawComment; //한줄 소개
	private String career; //경력
	
	//변호사 이미지 경로+(변경된)파일명 담을 필드 생성
	private String lawImg;
	
	public Lawyer() {
		super();
	}
	
	//분야별 변호사 리스트 조회 (상담폼 카테고리용)
	public Lawyer(int lawNo, String refUno) {
		super();
		this.lawNo = lawNo;
		this.refUno = refUno;
	}

	//변호사 전체 리스트 조회용
	public Lawyer(int lawNo, String refUno, String refPno, String companyName, String companyAddress, String lawImg) {
		super();
		this.lawNo = lawNo;
		this.refUno = refUno;
		this.refPno = refPno;
		this.companyName = companyName;
		this.companyAddress = companyAddress;
		this.lawImg = lawImg;
	}

	//변호사 신청 매개변수 생성자 
	public Lawyer(String refUno, String refPno, String exam, int examSession, int passDate, 
			String companyAddress ,String companyName, String companyPn, String lawComment, String career) {
		super();
		this.refUno = refUno;
		this.refPno = refPno;
		this.exam = exam;
		this.examSession = examSession;
		this.passDate = passDate;
		this.companyName = companyName;
		this.companyAddress = companyAddress;
		this.companyPn = companyPn;
		this.lawComment = lawComment;
		this.career = career;
	}

	public Lawyer(int lawNo, String refUno, String refPno, String exam, int examSession, int passDate,
			String companyName, String companyAddress, String companyPn, String lawComment, String career, String lawImg) {
		super();
		this.lawNo = lawNo;
		this.refUno = refUno;
		this.refPno = refPno;
		this.exam = exam;
		this.examSession = examSession;
		this.passDate = passDate;
		this.companyName = companyName;
		this.companyAddress = companyAddress;
		this.companyPn = companyPn;
		this.lawComment = lawComment;
		this.career = career;
		this.lawImg = lawImg;
	}
	
	public int getLawNo() {
		return lawNo;
	}
	public void setLawNo(int lawNo) {
		this.lawNo = lawNo;
	}
	public String getRefUno() {
		return refUno;
	}
	public void setRefUno(String refUno) {
		this.refUno = refUno;
	}
	public String getRefPno() {
		return refPno;
	}
	public void setRefPno(String refPno) {
		this.refPno = refPno;
	}
	public String getExam() {
		return exam;
	}
	public void setExam(String exam) {
		this.exam = exam;
	}
	public int getExamSession() {
		return examSession;
	}
	public void setExamSession(int examSession) {
		this.examSession = examSession;
	}
	public int getPassDate() {
		return passDate;
	}
	public void setPassDate(int passDate) {
		this.passDate = passDate;
	}
	public String getCompanyName() {
		return companyName;
	}
	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}
	public String getCompanyAddress() {
		return companyAddress;
	}
	public void setCompanyAddress(String companyAddress) {
		this.companyAddress = companyAddress;
	}
	public String getCompanyPn() {
		return companyPn;
	}
	public void setCompanyPn(String companyPn) {
		this.companyPn = companyPn;
	}
	public String getLawComment() {
		return lawComment;
	}
	public void setLawComment(String lawComment) {
		this.lawComment = lawComment;
	}
	public String getCareer() {
		return career;
	}
	public void setCareer(String career) {
		this.career = career;
	}

	public String getLawImg() {
		return lawImg;
	}

	public void setLawImg(String lawImg) {
		this.lawImg = lawImg;
	}
	
	@Override
	public String toString() {
		return "Lawyer [lawNo=" + lawNo + ", refUno=" + refUno + ", refPno=" + refPno + ", exam=" + exam
				+ ", examSession=" + examSession + ", passDate=" + passDate + ", companyName=" + companyName
				+ ", companyAddress=" + companyAddress + ", companyPn=" + companyPn + ", lawComment=" + lawComment
				+ ", career=" + career + "]";
	}
	
}
