package com.bbbox.liked.model.vo;

public class Dislike {
	
	private int refUno;
	private int refBno;
	
	
	public Dislike() {
		super();
	}

	public Dislike(int refUno, int refBno) {
		super();
		this.refUno = refUno;
		this.refBno = refBno;
	}
	
	
	public int getRefUno() {
		return refUno;
	}

	public void setRefUno(int refUno) {
		this.refUno = refUno;
	}

	public int getRefBno() {
		return refBno;
	}

	public void setRefBno(int refBno) {
		this.refBno = refBno;
	}
	
	
	@Override
	public String toString() {
		return "Dislike [refUno=" + refUno + ", refBno=" + refBno + "]";
	}
	
	
	
}
