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

import com.bbbox.board.model.vo.Accident;
import com.bbbox.board.model.vo.Attachment;
import com.bbbox.board.model.vo.Board;
import com.bbbox.board.model.vo.Reply;
import com.bbbox.common.JDBCTemplate;
import com.bbbox.common.model.vo.PageInfo;
import com.sun.corba.se.spi.orbutil.fsm.Guard.Result;

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
	
	/* --필요없음
	 * 
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
	
	//페이징을 위한 게시물 카운팅
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
	
	//게시글 파트 DB에 입력
	public int insertAccidentBoard(Connection conn, Board b) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertAccidentBoard");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, b.getBoardWriter());
			pstmt.setString(2, b.getTitle());
			pstmt.setString(3, b.getContent());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return result;
	}
	//게시글 번호 가져오기
	public int selectRefBoardNo(Connection conn) {
		
		int refBno = 0;
		Statement stmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectRefBoardNo");
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			
			if(rset.next()) {
				refBno = rset.getInt("LAST_NUMBER")-1;
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}
		return refBno;
	}
	//사고정보 파트 DB에 입력
	public int insertAccidentInfo(Connection conn, Accident ac) {
		
		int result=0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertAccidentInfo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, ac.getRefBno());
			pstmt.setInt(2, ac.getRefPno());
			pstmt.setString(3, ac.getInsuranceType());
			pstmt.setString(4, ac.getRegion());
			pstmt.setInt(5, ac.getAccRateMe());
			pstmt.setInt(6, ac.getAccRateYou());
			
			result=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}
	
	//첨부파일 DB에 입력
	public int insertAccidentAttachment(Connection conn, Attachment at) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertAccidentAttachment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, at.getRefBno());
			pstmt.setString(2, at.getOriginName());
			pstmt.setString(3, at.getChangeName());
			pstmt.setString(4, at.getFilePath());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	public ArrayList<Board> searchByTitle(Connection conn, String searchFilter, String region, int partType, String insuranceType,
			String keyword, PageInfo pi) {
		
		ArrayList<Board> list = new ArrayList<Board>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = null;
		
		//검색필터가 제목일때
		if(searchFilter.equals("제목")||searchFilter.equals("")) {
			sql = prop.getProperty("searchByTitle");
		}else {
		//검색필터가 작성자일때
			sql = prop.getProperty("searchByWriter");
		}
		
		int startRow=(pi.getCurrentPage()-1)*pi.getBoardLimit()+1;
		int endRow=(startRow+pi.getBoardLimit())-1;
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			if(region.equals("")) {
				pstmt.setString(1, "%"+region+"%");
			}else {
				pstmt.setString(1, region);
			}
			if(partType!=0) {
				pstmt.setInt(2, partType);
			}else {
				pstmt.setString(2, "%"+""+"%");
			}
			if(insuranceType.equals("")) {
				pstmt.setString(3, "%"+insuranceType+"%");
			}else {
			pstmt.setString(3, insuranceType);
			}
			pstmt.setString(4, "%"+keyword+"%");
			pstmt.setInt(5, startRow);
			pstmt.setInt(6, endRow);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(new Board(rset.getInt("BOARD_NO")
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
		
		return list;
	}
/*
	public ArrayList<Board> searchByWriter(Connection conn, String region, int partType, String insuranceType,
			String keyword, PageInfo pi) {
		ArrayList<Board> list = new ArrayList<Board>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("searchByWriter");
		
		int startRow=(pi.getCurrentPage()-1)*pi.getBoardLimit()+1;
		int endRow=(startRow+pi.getBoardLimit())-1;
			
		try {
			pstmt = conn.prepareStatement(sql);
			if(region.equals("")) {
				pstmt.setString(1, "%"+region+"%");
			}else {
				pstmt.setString(1, region);
			}
			
			if(partType!=0) {
				pstmt.setInt(2, partType);
			}else {
				pstmt.setString(2, "%"+""+"%");
			}
			if(insuranceType.equals("")) {
				pstmt.setString(3, "%"+insuranceType+"%");
			}else {
			pstmt.setString(3, insuranceType);
			}
			pstmt.setString(4, "%"+keyword+"%");
			pstmt.setInt(5, startRow);
			pstmt.setInt(6, endRow);
			
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(new Board(rset.getInt("BOARD_NO")
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
		
		return list;
	}
	*/

	public Board accidentBoardSelectDetail(Connection conn, int bno) {

		Board b = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("accidentBoardSelectDetail");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				b = new Board();
				b.setBoardNo(rset.getInt("BOARD_NO"));
				b.setBoardWriter(rset.getString("USER_ID"));
				b.setTitle(rset.getString("TITLE"));
				b.setContent(rset.getString("CONTENT"));
				b.setCount(rset.getInt("COUNT"));
				b.setCreateDate(rset.getDate("CREATE_DATE"));
				b.setLiked(rset.getInt("LIKED"));
				b.setReportCount(rset.getInt("REPORT_COUNT"));
				b.setRpCount(rset.getInt("RP_COUNT"));
				//파일경로
				b.setFilePath(rset.getString("PATH"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return b;
	}

	public Accident accidentSelectDetail(Connection conn, int bno) {
		
		Accident ac = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("accidentSelectDetail");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				
				ac= new Accident(rset.getInt("ACC_NO")
					           , rset.getInt("REF_PNO")
					           , rset.getInt("REF_LNO")
					           , rset.getString("INSURANCE_TYPE")
					           , rset.getString("REGION")
					           , rset.getInt("ACC_RATE_ME")
					           , rset.getInt("ACC_RATE_YOU")
					           , rset.getString("SOLVE"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return ac;
	}

	public ArrayList<Reply> accidentReplySelectDetail(Connection conn, int bno) {

		ArrayList<Reply> rplist = new ArrayList<Reply>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("accidentReplySelectDetail");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				rplist.add(new Reply(rset.getInt("RP_NO")
									,rset.getString("")
									,rset.getString("CONTENT")
									,rset.getString("CREATE_DATE")));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return rplist;
	}

	public int deleteAccidentBoard(Connection conn, int bno) {
		
		int result=0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteAccidentBoard");
		
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

	public int deleteAccident(Connection conn, int bno) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteAccident");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			result=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	public int deleteAccidentAttachment(Connection conn, int bno) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteAccidentAttachment");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			result=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}
}
