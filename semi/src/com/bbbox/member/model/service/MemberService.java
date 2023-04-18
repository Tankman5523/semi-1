package com.bbbox.member.model.service;

import java.sql.Connection;

import com.bbbox.common.JDBCTemplate;
import com.bbbox.member.model.dao.MemberDao;
import com.bbbox.member.model.vo.Member;

public class MemberService {
	
	//회원 로그인 메소드	
	public Member loginMember(String userId, String userPwd) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		Member loginUser = new MemberDao().loginMember(conn, userId, userPwd);
		
		JDBCTemplate.close(conn);
		
		return loginUser;
	}
	
	//회원가입 메소드 
	public int insertMember(Member insertMember) {

		Connection conn = JDBCTemplate.getConnection();
		
		int result = new MemberDao().insertMember(conn, insertMember);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
			
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}
	
	//아이디 중복확인
	public int MemberIdCheck(String checkId) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int count = new MemberDao().MemberIdCheck(conn, checkId);
		
		JDBCTemplate.close(conn);
		
		return count;
	}
	
	//이메일 중복 확인
	public int selectEmail(String testEmail) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int count = new MemberDao().selectEmail(conn, testEmail);
		
		JDBCTemplate.close(conn);
		
		return count;
	}

}
