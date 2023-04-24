package com.bbbox.lawyer.model.vo;

public class LawAttachment {

	private int fileNo;
	private String refUno;
	private String originName;
	private String changeName;
	private String filePath;
	private String status;
	
	
	
	public LawAttachment() {
		super();
	}

	public LawAttachment(int fileNo, String refUno, String originName, String changeName, String filePath, String status) {
		super();
		this.fileNo = fileNo;
		this.refUno = refUno;
		this.originName = originName;
		this.changeName = changeName;
		this.filePath = filePath;
		this.status = status;
	}

	public int getFileNo() {
		return fileNo;
	}

	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}

	public String getRefUno() {
		return refUno;
	}

	public void setRefUno(String refUno) {
		this.refUno = refUno;
	}

	public String getOriginName() {
		return originName;
	}

	public void setOriginName(String originName) {
		this.originName = originName;
	}

	public String getChangeName() {
		return changeName;
	}

	public void setChangeName(String changeName) {
		this.changeName = changeName;
	}

	public String getFilePath() {
		return filePath;
	}

	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	@Override
	public String toString() {
		return "LawAttachment [fileNo=" + fileNo + ", refLno=" + refUno + ", originName=" + originName + ", changeName="
				+ changeName + ", filePath=" + filePath + ", status=" + status + "]";
	}
	
	
	
}
