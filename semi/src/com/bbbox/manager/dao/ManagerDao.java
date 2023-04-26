package com.bbbox.manager.dao;

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
import com.bbbox.common.model.vo.PageInfo;



public class ManagerDao {
	
Properties prop = new Properties();
	
	public ManagerDao() {
		String filePath = ManagerDao.class.getResource("/sql/manager/manager-mapper.xml").getPath();
		
		try {
			prop.loadFromXML(new FileInputStream(filePath));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}

	public ArrayList<Board> selectAllAccidentBoard(Connection conn, PageInfo pi, String sort) {
		
		ArrayList<Board> blist = new ArrayList<Board>();
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int categoryNo = 3;
		
		if(sort==null||sort.equals("date")){
			sql = prop.getProperty("selectAllAccidentBoard");
		}else if(sort.equals("view")){
			sql = prop.getProperty("sortAccidentBoardByCount");
		}else if(sort.equals("dislike")) {
			sql = prop.getProperty("sortAccidentBoardByDislike");
		}else if(sort.equals("recommend")){
			sql = prop.getProperty("sortAccidentBoardByLiked");
		}
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			int startRow=(pi.getCurrentPage()-1)*pi.getBoardLimit()+1;
			int endRow=(startRow+pi.getBoardLimit())-1;
			
			pstmt.setInt(1, categoryNo);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rset=pstmt.executeQuery();
			
			while(rset.next()) {
				Board b=new Board();
				b.setBoardNo(rset.getInt("BOARD_NO"));
				b.setBoardWriter(rset.getString("USER_ID"));
				b.setCategoryNo(rset.getInt("CATEGORY_NO"));
				b.setTitle(rset.getString("TITLE"));
				b.setCount(rset.getInt("COUNT"));
				b.setCreateDate(rset.getDate("CREATE_DATE"));
				b.setRef_pno(rset.getInt("REF_PNO"));
				b.setInsuranceType(rset.getString("INSURANCE_TYPE"));
				b.setRegion(rset.getString("REGION"));
				b.setLiked(rset.getInt("LIKED"));
				b.setReportCount(rset.getInt("REPORT_COUNT"));
				b.setStatus(rset.getString("STATUS"));
				b.setChangeName(rset.getString("PART_NAME"));
				blist.add(b);
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

	public ArrayList<Board> selectAllResolvedBoard(Connection conn, PageInfo pi, String sort) {
		ArrayList<Board> blist = new ArrayList<Board>();
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = null;
		int categoryNo = 4;
		
		if(sort==null||sort.equals("date")){
			sql = prop.getProperty("selectAllAccidentBoard");
		}else if(sort.equals("view")){
			sql = prop.getProperty("sortAccidentBoardByCount");
		}else if(sort.equals("dislike")) {
			sql = prop.getProperty("sortAccidentBoardByDislike");
		}else if(sort.equals("recommend")){
			sql = prop.getProperty("sortAccidentBoardByLiked");
		}
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			int startRow=(pi.getCurrentPage()-1)*pi.getBoardLimit()+1;
			int endRow=(startRow+pi.getBoardLimit())-1;
			
			pstmt.setInt(1, categoryNo);
			pstmt.setInt(2, startRow);
			pstmt.setInt(3, endRow);
			
			rset=pstmt.executeQuery();
			
			while(rset.next()) {
				Board b=new Board();
				b.setBoardNo(rset.getInt("BOARD_NO"));
				b.setBoardWriter(rset.getString("USER_ID"));
				b.setCategoryNo(rset.getInt("CATEGORY_NO"));
				b.setTitle(rset.getString("TITLE"));
				b.setCount(rset.getInt("COUNT"));
				b.setCreateDate(rset.getDate("CREATE_DATE"));
				b.setRef_pno(rset.getInt("REF_PNO"));
				b.setInsuranceType(rset.getString("INSURANCE_TYPE"));
				b.setRegion(rset.getString("REGION"));
				b.setLiked(rset.getInt("LIKED"));
				b.setReportCount(rset.getInt("REPORT_COUNT"));
				b.setStatus(rset.getString("STATUS"));
				b.setChangeName(rset.getString("PART_NAME"));
				b.setCategoryName(rset.getString("USER_NAME")); // 담당변호사 이름 
				blist.add(b);
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

	public int boardStatusOn(Connection conn, int bno) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("boardStatusOn");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	public int boardStatusOff(Connection conn, int bno) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("boardStatusOff");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	public int accidentBoardDelete(Connection conn, int bno) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("accidentBoardDelete");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	public int accidentInfoDelete(Connection conn, int bno) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("accidentInfoDelete");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	public int accidentAttachmentDelete(Connection conn, int bno) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("accidentAttachmentDelete");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	public int accidentReplyDelete(Connection conn, int bno) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("accidentReplyDelete");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}
	
	
	
	
	
}
