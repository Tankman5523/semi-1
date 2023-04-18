package com.bbbox.board.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.Properties;

import com.bbbox.board.model.vo.Board;
import com.bbbox.common.JDBCTemplate;

public class BoardDao {
	
	Properties prop = new Properties();
	
	public BoardDao() {
		String filePath = BoardDao.class.getResource("/sql/board/board-mapper.xml").getPath();
		
		try {
			prop.loadFromXML(new FileInputStream(filePath));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	//등록된 게시글 조회
	public ArrayList<Board> selectBoardList(Connection conn) {
		
		ArrayList<Board> list = new ArrayList<>();
		
		ResultSet rset = null;
		Statement stmt = null;
		
		String sql = prop.getProperty("selectBoardList");
		
		try {
			stmt = conn.createStatement();

			rset = stmt.executeQuery(sql);
			
			while(rset.next()) {
				list.add(new Board(rset.getInt("BOARD_NO"),
								   rset.getString("USER_ID"),
								   rset.getString("TITLE"),
								   rset.getInt("COUNT"),
								   rset.getDate("CREATE_DATE"),
								   rset.getInt("LIKED"),
								   rset.getInt("RP_COUNT")));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}
		
		return list;
	}

	//게시판 조회수 증가
	public int increaseBoardCount(Connection conn, int boardNo) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("increaseBoardCount");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);			
		}
		
		return result;
	}
	

	//특정 게시글 한개 조회
	public Board selectBoard(Connection conn, int boardNo) {
		
		Board b = null;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectBoard");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				b = new Board(rset.getInt("BOARD_NO"),
							  rset.getString("USER_ID"),
							  rset.getString("TITLE"),
							  rset.getString("CONTENT"),
							  rset.getInt("COUNT"),
							  rset.getDate("CREATE_DATE"),
							  rset.getInt("LIKED"),
							  rset.getInt("RP_COUNT"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		System.out.println("안뇽");
		
		
		return b;
	}

	//좋아요 증가 메소드
	public int insertLiked(Connection conn, int boardNo) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("insertLiked");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, boardNo);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);			
		}
		
		return result;
	}

}
