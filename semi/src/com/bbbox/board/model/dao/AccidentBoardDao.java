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

import com.bbbox.board.model.vo.Attachment;
import com.bbbox.board.model.vo.Board;
import com.bbbox.common.JDBCTemplate;
import com.bbbox.common.model.vo.PageInfo;

public class AccidentBoardDao {

	private Properties prop = new Properties();
		
		public AccidentBoardDao() { 
			String filePath = AccidentBoardDao.class.getResource("/sql/board/accidentBoard-mapper.xml").getPath();
			try {
				prop.loadFromXML(new FileInputStream(filePath));
				
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		}
	
	//제보영상게시판 '게시글+사건정보' 읽어오기
	public ArrayList<Board> selectAccidentBoardList(Connection conn, PageInfo pi) {
		ArrayList<Board> blist = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectAccidentBoardList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			
			int startRow=(pi.getCurrentPage()-1)*pi.getBoardLimit()+1;
			int endRow=(startRow+pi.getBoardLimit())-1;
			
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				blist.add(new Board(rset.getInt("BOARD_NO")
								   ,rset.getString("USER_ID")
								   ,rset.getString("TITLE")
								   ,rset.getInt("COUNT")
								   ,rset.getDate("CREATE_DATE")
								   ,rset.getInt("REF_PNO")
								   ,rset.getString("INSURANCE_TYPE")
								   ,rset.getString("REGION")
								   ,rset.getString("PATH")));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return blist;
	}
	
	/*
	//제보영상게시판 '첨부파일(동영상)' 읽어오기
	public ArrayList<Attachment> selectAccidentAttachmentList(Connection conn) {
		ArrayList<Attachment> alist = new ArrayList<Attachment>();
		Statement stmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectAccidentAttachmentList");
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			
			while(rset.next()) {
				Attachment at = new Attachment();
				at.setRefBno(rset.getInt("REF_BNO"));
				at.setOriginName(rset.getString("ORIGIN_NAME"));
				at.setChangeName(rset.getString("CHANGE_NAME"));
				at.setFilePath(rset.getString("FILE_PATH"));
				alist.add(at);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}
		return alist;
	}
	*/

	public int selectBoardListCount(Connection conn) {
		
		int listCount = 0;
		ResultSet rset=null;
		Statement stmt = null;
		String sql = prop.getProperty("selectBoardListCount");
		
		try {
			stmt= conn.createStatement();
			rset=stmt.executeQuery(sql);
			
			if(rset.next()) {
				listCount=rset.getInt("COUNT");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(stmt);
		}
		return listCount;
	}

	public ArrayList<Board> selectResolvedBoardList(Connection conn, PageInfo pi) {
		ArrayList<Board> blist = new ArrayList<Board>();
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("selectResolvedBoardList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			int startRow=(pi.getCurrentPage()-1)*pi.getBoardLimit()+1;
			int endRow=(startRow+pi.getBoardLimit())-1;
			
			pstmt.setInt(1, startRow);
			pstmt.setInt(2, endRow);
			
			rset=pstmt.executeQuery();
			
			while(rset.next()) {
				blist.add(new Board(rset.getInt("BOARD_NO")
								   ,rset.getString("USER_ID")
								   ,rset.getString("TITLE")
								   ,rset.getInt("COUNT")
								   ,rset.getDate("CREATE_DATE")
								   ,rset.getInt("REF_PNO")
								   ,rset.getString("INSURANCE_TYPE")
								   ,rset.getString("REGION")
								   ,rset.getString("PATH")));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return blist;
	}
	
}
