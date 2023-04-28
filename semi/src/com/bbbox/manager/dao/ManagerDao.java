package com.bbbox.manager.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.bbbox.board.model.vo.Attachment;
import com.bbbox.board.model.vo.Board;
import com.bbbox.board.model.vo.Reply;
import com.bbbox.common.JDBCTemplate;
import com.bbbox.common.model.vo.PageInfo;
import com.bbbox.lawyer.model.vo.Lawyer;
import com.bbbox.member.model.vo.Member;



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

	public int accidentReviewDelete(Connection conn, int accNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("accidentReviewDelete");
		
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

	public ArrayList<Attachment> selectAttachmentForManage(Connection conn, int bno) {
		ArrayList<Attachment> alist = new ArrayList<Attachment>();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectAttachmentForManage");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			rset = pstmt.executeQuery();
					
			while(rset.next()) {
				Attachment at = new Attachment();
				
				at.setChangeName(rset.getString("CHANGE_NAME"));
				at.setFilePath(rset.getString("FILE_PATH"));
				at.setOriginName(rset.getString("ORIGIN_NAME"));
				at.setRefBno(bno);
				
				alist.add(at);
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		return alist;
	}
	//있는지 확인만 할거라서 객체 하나만 가져오기
	public Reply selectRpListForManage(Connection conn, int bno) {
		Reply rp = null;
			
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("selectRpList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				rp = new Reply(rset.getInt("RP_NO"),
								   rset.getString("USER_ID"),
								   rset.getString("CONTENT"),
								   rset.getString("CREATE_DATE"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return rp;
	}
	
	//변호사신청 조회 리스트 
	public ArrayList<Member> selectApplyLaw(Connection conn) {

		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		ArrayList <Member> applyLaw  = new ArrayList<>();
		
		String sql = prop.getProperty("selectApplyLaw");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				
				applyLaw.add(new Member(rset.getInt("LAW_NO"),
										rset.getInt("REF_UNO"),
										rset.getString("USER_NAME"),
										rset.getString("USER_ID"),
										rset.getDate("ENROLL_DATE"),
										rset.getString("LAWYER")));		
				
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return applyLaw;
	}
	
	//전체 회원 조회 메소드 
		public ArrayList<Member> selectAllMember(Connection conn) {
			
			ResultSet rset = null;
			
			PreparedStatement pstmt = null;
			
			ArrayList <Member> memberList = new ArrayList<>();
			
			String sql = prop.getProperty("selectAllMember");
			
			try {
				pstmt = conn.prepareStatement(sql);
				
				rset = pstmt.executeQuery();
				
				while(rset.next()) {
					
					memberList.add(new Member (rset.getInt("USER_NO"),
											   rset.getString("USER_ID"),
											   rset.getString("USER_NAME"),
											   rset.getString("LAWYER"),
											   rset.getDate("ENROLL_DATE"),
											   rset.getString("STATUS"),
											   rset.getInt("게시글수"),
											   rset.getInt("댓글수")));
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				JDBCTemplate.close(rset);
				JDBCTemplate.close(pstmt);
				
			}
			
			return memberList;
		}
		
		//탈퇴 회원 조회 메소드 
		public ArrayList<Member> selectDeleteMember(Connection conn) {
			ResultSet rset = null;
			
			PreparedStatement pstmt = null;
			
			ArrayList <Member> deleteMemList = new ArrayList<>();
			
			String sql = prop.getProperty("selectDeleteMember");
			
			try {
				pstmt = conn.prepareStatement(sql);
				
				rset = pstmt.executeQuery();
				
				while(rset.next()) {
					
					deleteMemList.add(new Member (rset.getInt("USER_NO"),
											   rset.getString("USER_ID"),
											   rset.getString("USER_NAME"),
											   rset.getString("LAWYER"),
											   rset.getDate("ENROLL_DATE"),
											   rset.getString("STATUS")));
				}
				
			} catch (SQLException e) {
				e.printStackTrace();
			}finally {
				JDBCTemplate.close(rset);
				JDBCTemplate.close(pstmt);
				
			}
			
			return deleteMemList;
		}
	
}
