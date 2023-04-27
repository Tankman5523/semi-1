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
import com.bbbox.board.model.vo.AccidentReview;
import com.bbbox.board.model.vo.Attachment;
import com.bbbox.board.model.vo.Board;
import com.bbbox.board.model.vo.Reply;
import com.bbbox.board.model.vo.Search;
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
	public ArrayList<Board> selectAccidentBoardList(Connection conn, PageInfo pi, String sort) {
		ArrayList<Board> blist = new ArrayList<>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = null;
		if(sort==null||sort.equals("date")) {
			sql = prop.getProperty("selectAccidentBoardList");
		}else if(sort.equals("recommend")) {
			sql = prop.getProperty("sortByLiked");
		}else if(sort.equals("view")) {
			sql = prop.getProperty("sortByCount");
		}
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
								   ,rset.getString("PATH")
								   ,rset.getString("CHANGE_NAME")
								   ,rset.getInt("CATEGORY_NO")));
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
								   ,rset.getString("PATH")
								   ,rset.getString("CHANGE_NAME")
								   ,rset.getInt("CATEGORY_NO")));
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

	public ArrayList<Board> searchAccidentBoard(Connection conn, String searchFilter, String region, int partType, String insuranceType,
			String keyword, int categoryNo, PageInfo pi) {
		
		ArrayList<Board> list = new ArrayList<Board>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = null;
		
		//검색필터가 제목일때
		if(searchFilter.equals("title")||searchFilter.equals("")) {
			sql = prop.getProperty("searchAccidentBoardByTitle");
		}else {
		//검색필터가 작성자일때
			sql = prop.getProperty("searchAccidentBoardByWriter");
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
			pstmt.setInt(5, categoryNo);
			pstmt.setInt(6, startRow);
			pstmt.setInt(7, endRow);
			
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
						   ,rset.getString("PATH")
						   ,rset.getString("CHANGE_NAME")));
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
				b.setCategoryNo(rset.getInt("CATEGORY_NO"));
				b.setContent(rset.getString("CONTENT"));
				b.setCount(rset.getInt("COUNT"));
				b.setCreateDate(rset.getDate("CREATE_DATE"));
				b.setLiked(rset.getInt("LIKED"));
				b.setReportCount(rset.getInt("REPORT_COUNT"));
				b.setRpCount(rset.getInt("RP_COUNT"));
				//파일경로
				b.setFilePath(rset.getString("PATH"));
				b.setChangeName(rset.getString("CHANGE_NAME"));
				
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
									,rset.getString("USER_ID")
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

	public int updateAccidentBoard(Connection conn, Board b) {
		
		int result=0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateAccidentBoard");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b.getTitle());
			pstmt.setString(2, b.getContent());
			pstmt.setInt(3, b.getBoardNo());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}
	
	public int updateAccidentInfo(Connection conn, Accident ac) {
		
		int result=0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateAccidentInfo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, ac.getRefPno());
			pstmt.setString(2, ac.getInsuranceType());
			pstmt.setString(3, ac.getRegion());
			pstmt.setInt(4, ac.getAccRateMe());
			pstmt.setInt(5, ac.getAccRateYou());
			pstmt.setInt(6, ac.getRefBno());
			
			result=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	public int updateAccidentAttachment(Connection conn, Attachment at) {
		
		int result=0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateAccidentAttachment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, at.getOriginName());
			pstmt.setString(2, at.getChangeName());
			pstmt.setString(3, at.getFilePath());
			pstmt.setInt(4, at.getRefBno());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	public int selectResolvedBoardListCount(Connection conn) {
		int listCount = 0;
		ResultSet rset=null;
		Statement stmt = null;
		String sql = prop.getProperty("selectResolvedBoardListCount");
		
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

	public Board resolvedBoardSelectDetail(Connection conn, int bno) {
		Board b = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("resolvedBoardSelectDetail");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				b = new Board();
				b.setBoardNo(rset.getInt("BOARD_NO"));
				b.setBoardWriter(rset.getString("USER_ID"));
				b.setTitle(rset.getString("TITLE"));
				b.setCategoryNo(rset.getInt("CATEGORY_NO"));
				b.setContent(rset.getString("CONTENT"));
				b.setCount(rset.getInt("COUNT"));
				b.setCreateDate(rset.getDate("CREATE_DATE"));
				b.setLiked(rset.getInt("LIKED"));
				b.setReportCount(rset.getInt("REPORT_COUNT"));
				b.setRpCount(rset.getInt("RP_COUNT"));
				//파일경로
				b.setFilePath(rset.getString("PATH"));
				b.setChangeName(rset.getString("CHANGE_NAME"));
				
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

	public Accident resolvedAccidentSelectDetail(Connection conn, int bno) {

		Accident ac = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("resolvedAccidentSelectDetail");
		
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

	public ArrayList<Reply> resolvedReplySelectDetail(Connection conn, int bno) {
		ArrayList<Reply> rplist = new ArrayList<Reply>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("resolvedReplySelectDetail");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				rplist.add(new Reply(rset.getInt("RP_NO")
									,rset.getString("USER_ID")
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

	public AccidentReview resolvedBoardReviewSelectDetail(Connection conn, int accNo) {
		
		AccidentReview ar= null;
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("resolvedBoardReviewSelectDetail");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, accNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				ar = new AccidentReview(rset.getInt("AR_NO")
									   ,rset.getInt("REF_ACCNO")
									   ,rset.getInt("CORRECT_RATE_ME")
									   ,rset.getInt("CORRECT_RATE_YOU") 
									   ,rset.getString("CONTENT")
									   ,rset.getString("USER_NAME"));
				ar.setLawNo(rset.getInt("LAW_NO"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return ar;
	}

	public int insertAccidentReview(Connection conn, AccidentReview ar) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertAccidentReview");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, ar.getRefAccNo());
			pstmt.setInt(2, ar.getLawNo());
			pstmt.setInt(3, ar.getCorrectRateMe());
			pstmt.setInt(4, ar.getCorrectRateYou());
			pstmt.setString(5, ar.getContent());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	public int selectLawNoByUno(Connection conn, int uno) {
		
		int lawNo=0;
		PreparedStatement pstmt = null; 
		ResultSet rset = null;
		String sql = prop.getProperty("selectLawNoByUno");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, uno);
			
			rset = pstmt.executeQuery();
			if(rset.next()) {
				lawNo=rset.getInt("LAW_NO");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return lawNo;
	}

	public int updateBoardCategory(Connection conn, int bno) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateBoardCategory");
		
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

	public int updateSolve(Connection conn, int accNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateSolve");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, accNo);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	public AccidentReview selectAccidentReview(Connection conn, int arNo) {

		AccidentReview ar = null;
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("selectAccidentReview");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, arNo);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				ar = new AccidentReview();
				ar.setArNo(arNo);
				ar.setContent(rset.getString("CONTENT"));
				ar.setCorrectRateMe(rset.getInt("CORRECT_RATE_ME"));
				ar.setCorrectRateYou(rset.getInt("CORRECT_RATE_YOU"));
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return ar;
	}

	public Attachment selectAttachment(Connection conn, int bno) {
		
		Attachment at = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectAttachment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			rset = pstmt.executeQuery();
					
			if(rset.next()) {
				at = new Attachment();
				at.setChangeName(rset.getString("CHANGE_NAME"));
				at.setFilePath(rset.getString("FILE_PATH"));
				at.setOriginName(rset.getString("ORIGIN_NAME"));
				at.setRefBno(bno);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return at;
	}

	public int updateAccidentReview(Connection conn, AccidentReview ar) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateAccidentReview");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, ar.getContent());
			pstmt.setInt(2, ar.getCorrectRateMe());
			pstmt.setInt(3, ar.getCorrectRateYou());
			pstmt.setInt(4, ar.getArNo());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	public int deleteAccidentReview(Connection conn, int arNo) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteAccidentReview");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, arNo);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	public int returnBoardCategory(Connection conn, int bno) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("returnBoardCategory");
		
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

	public int returnSolve(Connection conn, int accNo) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("returnSolve");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, accNo);
			
			result= pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	public int selectAccNo(Connection conn, int bno) {
		int accNo = 0;
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("selectAccNo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				accNo = rset.getInt("ACC_NO");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return accNo;
	}

	public int searchedListCount(Connection conn, Search s) {
		int listCount = 0;
		ResultSet rset=null;
		PreparedStatement pstmt = null;
		String sql = null; //prop.getProperty("searchedListCount");
		
		if(s.getSearchFilter().equals("title")||s.getSearchFilter().equals("")) {
			sql = prop.getProperty("searchedListCountByTitle");
		}else {
		//검색필터가 작성자일때
			sql = prop.getProperty("searchedListCountByWriter");
		}
		
		try {
			pstmt= conn.prepareStatement(sql);
			
			if(s.getRegion().equals("")) {
				pstmt.setString(1, "%"+s.getRegion()+"%");
			}else {
				pstmt.setString(1, s.getRegion());
			}
			if(s.getPartType()!=0) {
				pstmt.setInt(2, s.getPartType());
			}else {
				pstmt.setString(2, "%"+""+"%");
			}
			if(s.getInsuranceType().equals("")) {
				pstmt.setString(3, "%"+s.getInsuranceType()+"%");
			}else {
			pstmt.setString(3, s.getInsuranceType());
			}
			pstmt.setString(4, "%"+s.getKeyword()+"%");
			
			
			rset=pstmt.executeQuery();
			
			if(rset.next()) {
				listCount=rset.getInt("COUNT");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		return listCount;
	}

	
}
