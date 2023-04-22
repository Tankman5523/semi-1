package com.bbbox.board.model.vo;

public class Accident {
	private int accNo;//	ACC_NO	NUMBER
	private int refBno;//	REF_BNO	NUMBER
	private int refLno;//	REF_LNO	NUMBER
	private int refPno;//	REF_PNO	NUMBER
	private String insuranceType;//	INSURANCE_TYPE	VARCHAR2(15 BYTE)
	private String region;//	REGION VARCHAR2(10 BYTE)
	private int accRateMe;//	ACC_RATE_ME	NUMBER
	private int accRateYou;//	ACC_RATE_YOU	NUMBER
	private String solve;//	SOLVE	VARCHAR2(1 BYTE)
	
	
	public Accident() {
		super();
	}

	public Accident(int accNo, int refBno, int refLno, int refPno, String insuranceType, String region, int accRateMe,
			int accRateYou, String solve) {
		super();
		this.accNo = accNo;
		this.refBno = refBno;
		this.refLno = refLno;
		this.refPno = refPno;
		this.insuranceType = insuranceType;
		this.region = region;
		this.accRateMe = accRateMe;
		this.accRateYou = accRateYou;
		this.solve = solve;
	}

	public Accident(int accNo,int refPno, int refLno, String insuranceType, String region, int accRateMe,
			int accRateYou, String solve) {
		super();
		this.accNo = accNo;
		this.refPno = refPno;
		this.refLno = refLno;
		this.insuranceType = insuranceType;
		this.region = region;
		this.accRateMe = accRateMe;
		this.accRateYou = accRateYou;
		this.solve = solve;
	}

	public int getAccNo() {
		return accNo;
	}

	public void setAccNo(int accNo) {
		this.accNo = accNo;
	}

	public int getRefBno() {
		return refBno;
	}

	public void setRefBno(int refBno) {
		this.refBno = refBno;
	}

	public int getRefLno() {
		return refLno;
	}

	public void setRefLno(int refLno) {
		this.refLno = refLno;
	}

	public int getRefPno() {
		return refPno;
	}

	public void setRefPno(int refPno) {
		this.refPno = refPno;
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

	public int getAccRateMe() {
		return accRateMe;
	}

	public void setAccRateMe(int accRateMe) {
		this.accRateMe = accRateMe;
	}

	public int getAccRateYou() {
		return accRateYou;
	}

	public void setAccRateYou(int accRateYou) {
		this.accRateYou = accRateYou;
	}

	public String getSolve() {
		return solve;
	}

	public void setSolve(String solve) {
		this.solve = solve;
	}

	@Override
	public String toString() {
		return "Accident [accNo=" + accNo + ", refBno=" + refBno + ", refLno=" + refLno + ", refPno=" + refPno
				+ ", insuranceType=" + insuranceType + ", region=" + region + ", accRateMe=" + accRateMe
				+ ", accRateYou=" + accRateYou + ", solve=" + solve + "]";
	}
	
	
}
