package com.bbbox.lawyer.model.vo;

public class LawReview {
	
	private int reviewNo; //변호사리뷰 번호
	private int refAno; //참조 제보번호
	private String reviewContent; //리뷰내용
	private int star; //별점
	private String status; //상태값
	
	
	public LawReview() {
		super();
	}
	
	//리뷰 조회용 (status 제외)
	public LawReview(int reviewNo, int refAno, String reviewContent, int star) {
		super();
		this.reviewNo = reviewNo;
		this.refAno = refAno;
		this.reviewContent = reviewContent;
		this.star = star;
	}

	public LawReview(int reviewNo, int refAno, String reviewContent, int star, String status) {
		super();
		this.reviewNo = reviewNo;
		this.refAno = refAno;
		this.reviewContent = reviewContent;
		this.star = star;
		this.status = status;
	}
	
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public int getRefAno() {
		return refAno;
	}
	public void setRefAno(int refAno) {
		this.refAno = refAno;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public int getStar() {
		return star;
	}
	public void setStar(int star) {
		this.star = star;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	@Override
	public String toString() {
		return "LawReview [reviewNo=" + reviewNo + ", refAno=" + refAno + ", reviewContent=" + reviewContent + ", star="
				+ star + ", status=" + status + "]";
	}
	
}
