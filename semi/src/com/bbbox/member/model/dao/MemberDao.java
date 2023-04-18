package com.bbbox.member.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Properties;

import com.bbbox.common.JDBCTemplate;
import com.bbbox.member.model.vo.Member;

public class MemberDao {
	
	private Properties prop = new Properties();
	
	public MemberDao() {
		String filePath = MemberDao.class.getResource("/sql/member/member_mapper.xml").getPath();
		
		try {
			prop.loadFromXML(new FileInputStream(filePath));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public Member loginMember(Connection conn, String userId, String userPwd) {
		
		ResultSet rset = null;
		
		Member loginUser = null;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("loginMember");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, userId);
			pstmt.setString(2, userPwd);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				loginUser = new Member(rset.getInt("USER_NO"),
									   rset.getString("USER_ID"),
									   rset.getString("USER_PWD"),
									   rset.getString("USER_NAME"),
									   rset.getString("PHONE"),
									   rset.getString("EMAIL"),
									   rset.getString("ADDRESS"),
									   rset.getDate("ENROLL_DATE"),
									   rset.getString("STATUS"),
									   rset.getString("ADMIN"),
									   rset.getString("LAWYER"));		
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return loginUser;
	}

	public int insertMember(Connection conn, Member insertMember) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("insertMember");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, insertMember.getUserId());
			pstmt.setString(2, insertMember.getUserPwd());
			pstmt.setString(3, insertMember.getUserName());
			pstmt.setString(4, insertMember.getEmail());
			pstmt.setString(5, insertMember.getPhone());
			pstmt.setString(6, insertMember.getAddress());
			
			result = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}

		return result;
	}

	//아이디 중복확인 메소드
	public int MemberIdCheck(Connection conn, String checkId) {

		int count = 0;
		
		PreparedStatement pstmt = null;
		
		ResultSet rset =  null;
		
		String sql = prop.getProperty("MemberIdCheck");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, checkId);
			
			rset =pstmt.executeQuery();
			
			if(rset.next()) {
				count = rset.getInt("COUNT");
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return count;
	}
	
	//이메일 중복확인 메소드
	public int selectEmail(Connection conn, String testEmail) {
		
		int count =0;
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("selectEmail");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, testEmail);
			
			rset=pstmt.executeQuery();
			
			if(rset.next()) {
				count = rset.getInt("COUNT");
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		return count;
	}

}
