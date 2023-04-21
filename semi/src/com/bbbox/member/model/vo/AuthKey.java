package com.bbbox.member.model.vo;

public class AuthKey {

	private String using;
	private String chord;
	
	
	public AuthKey() {
		super();
	}

	public AuthKey(String using, String chord) {
		super();
		this.using = using;
		this.chord = chord;
	}

	public String getUsing() {
		return using;
	}

	public String getChord() {
		return chord;
	}

	@Override
	public String toString() {
		return "Authenticatior [using=" + using + ", chord=" + chord + "]";
	}
	
	
	
}