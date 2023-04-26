package com.bbbox.qaboard.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import com.bbbox.common.JDBCTemplate;
import com.bbbox.qaboard.model.vo.Question;

public class QuestionDao {
	
	Properties prop = new Properties();
	
	public QuestionDao() {
		String filePath = QuestionDao.class.getResource("/sql/board/questionBoard-mapper.xml").getPath();
		
		try {
			prop.loadFromXML(new FileInputStream(filePath));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public int selectQuestionBoardCount(Connection conn) {

		ResultSet rset = null;
		
		Statement stmt = null;
	
		int listCount = 0;
		
		String sql = prop.getProperty("selectQuestionBoardCount");
		
		try {
			stmt = conn.createStatement();
			
			rset = stmt.executeQuery(sql);
			
			while(rset.next()) {
				listCount = rset.getInt("COUNT");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}
		
		return listCount;
	}
	
	//문의글 리스트 조회 메소드 
	public ArrayList<Question> selectQuestionBoardList(Connection conn) {
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("selectQuestionBoardList");
		
		ArrayList <Question> qList = new ArrayList<>();
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				qList.add(new Question(rset.getInt("QNO"),
									   rset.getString("USER_ID"),
									   rset.getString("TITLE"),
									   rset.getDate("CREATE_DATE"),
									   rset.getString("OPEN")));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return qList;
	}

	public int insertQuestion(Connection conn, int userNo, String title, String content, String open) {
		
		int result = 0; 
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("insertQuestion");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, userNo);
			pstmt.setString(2, title);
			pstmt.setString(3, content);
			pstmt.setString(4, open);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//1대1문의글 조회 메소드 
	public Question selectQuestion(Connection conn, int qno, int userNo) {
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		Question qa = new Question();
		
		String sql = prop.getProperty("selectQuestion");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, qno);
			pstmt.setInt(2, userNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				qa= new Question(rset.getInt("QNO"),
								 rset.getString("USER_ID"),
								 rset.getString("TITLE"),
								 rset.getString("CONTENT"),
								 rset.getString("ANSWER"),
								 rset.getDate("CREATE_DATE"),
								 rset.getString("OPEN"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
			
		}
		
		
		return qa;
	}

}
