package com.bbbox.lawyer.model.vo;

public class Dibs {
	
	private int refUno; //참조 회원번호
	private int refLno; //참조 변호사번호
	
	
	public Dibs() {
		super();
	}
	
	public Dibs(int refUno, int refLno) {
		super();
		this.refUno = refUno;
		this.refLno = refLno;
	}
	
	public int getRefUno() {
		return refUno;
	}
	public void setRefUno(int refUno) {
		this.refUno = refUno;
	}
	public int getRefLno() {
		return refLno;
	}
	public void setRefLno(int refLno) {
		this.refLno = refLno;
	}
	
	@Override
	public String toString() {
		return "Dibs [refUno=" + refUno + ", refLno=" + refLno + "]";
	}

}
