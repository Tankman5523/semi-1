package com.bbbox.lawyer.model.vo;

public class PartCategory {
	
	private int partNo; //분야 번호
	private String partName; //분야 이름
	
	
	public PartCategory() {
		super();
	}
	
	public PartCategory(int partNo, String partName) {
		super();
		this.partNo = partNo;
		this.partName = partName;
	}
	public int getPartNo() {
		return partNo;
	}
	public void setPartNo(int partNo) {
		this.partNo = partNo;
	}
	public String getPartName() {
		return partName;
	}
	public void setPartName(String partName) {
		this.partName = partName;
	}
	
	@Override
	public String toString() {
		return "PartCategory [partNo=" + partNo + ", partName=" + partName + "]";
	}
	
}
