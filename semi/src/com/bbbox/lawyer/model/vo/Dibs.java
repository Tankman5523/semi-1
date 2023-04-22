package com.bbbox.lawyer.model.vo;

//찜하기 기능
public class Dibs {
	
	private int refUno; //참조 
	private int refLno;
	
	
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
