package com.bbbox.board.model.vo;

public class BoardCategory {
 /*
  	CATEGORY_NO	NUMBER
	CATEGORY_NAME	VARCHAR2(30 BYTE)
  */
	private int categoryNo;
	private String categoryName;
	
	
	
	public BoardCategory() {
		super();
	}
	
	public BoardCategory(int categoryNo, String categoryName) {
		super();
		this.categoryNo = categoryNo;
		this.categoryName = categoryName;
	}
	
	
	
	public int getCategoryNo() {
		return categoryNo;
	}
	public void setCategoryNo(int categoryNo) {
		this.categoryNo = categoryNo;
	}
	public String getCategoryName() {
		return categoryName;
	}
	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}
	
	
	
	@Override
	public String toString() {
		return "BoardCategory [categoryNo=" + categoryNo + ", categoryName=" + categoryName + "]";
	}
	
	
}
