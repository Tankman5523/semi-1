package com.bbbox.board.model.vo;
	
	//ACCI_REVIEW
public class AccidentReview {
	private int arNo;//	AR_NO	NUMBER
	private int refAccNo;//	REF_ACCNO	NUMBER
	private int lawNo;//	LAW_NO	NUMBER
	private int correctRateMe;//	CORRECT_RATE_ME	NUMBER
	private int correctRateYou;//	CORRECT_RATE_YOU	NUMBER
	private String content;//	CONTENT	VARCHAR2(400 BYTE)
	private String status;//	STATUS	VARCHAR2(1 BYTE)
	
	//변호사 이름
	private String lawName;

	public AccidentReview() {
		super();
	}
	
	//조회구문용 생성자
	public AccidentReview(int arNo, int refAccNo, int correctRateMe, int correctRateYou, String content,
			String lawName) {
		super();
		this.arNo = arNo;
		this.refAccNo = refAccNo;
		this.correctRateMe = correctRateMe;
		this.correctRateYou = correctRateYou;
		this.content = content;
		this.lawName = lawName;
	}
	
	public AccidentReview(int arNo, int refAccNo, int lawNo, int correctRateMe, int correctRateYou, String content,
			String status, String lawName) {
		super();
		this.arNo = arNo;
		this.refAccNo = refAccNo;
		this.lawNo = lawNo;
		this.correctRateMe = correctRateMe;
		this.correctRateYou = correctRateYou;
		this.content = content;
		this.status = status;
		this.lawName = lawName;
	}

	public int getArNo() {
		return arNo;
	}

	public void setArNo(int arNo) {
		this.arNo = arNo;
	}

	public int getRefAccNo() {
		return refAccNo;
	}

	public void setRefAccNo(int refAccNo) {
		this.refAccNo = refAccNo;
	}

	public int getLawNo() {
		return lawNo;
	}

	public void setLawNo(int lawNo) {
		this.lawNo = lawNo;
	}

	public int getCorrectRateMe() {
		return correctRateMe;
	}

	public void setCorrectRateMe(int correctRateMe) {
		this.correctRateMe = correctRateMe;
	}

	public int getCorrectRateYou() {
		return correctRateYou;
	}

	public void setCorrectRateYou(int correctRateYou) {
		this.correctRateYou = correctRateYou;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getLawName() {
		return lawName;
	}

	public void setLawName(String lawName) {
		this.lawName = lawName;
	}

	@Override
	public String toString() {
		return "AccidentReview [arNo=" + arNo + ", refAccNo=" + refAccNo + ", lawNo=" + lawNo + ", correctRateMe="
				+ correctRateMe + ", correctRateYou=" + correctRateYou + ", content=" + content + ", status=" + status
				+ ", lawName=" + lawName + "]";
	}
	
	
}
