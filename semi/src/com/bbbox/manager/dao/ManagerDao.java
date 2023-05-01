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

import com.bbbox.board.model.vo.AccidentReview;
import com.bbbox.board.model.vo.Attachment;
import com.bbbox.board.model.vo.Board;
import com.bbbox.board.model.vo.Reply;
import com.bbbox.common.JDBCTemplate;
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
	//사건 게시판 전부 조회
	public ArrayList<Board> selectAllAccidentBoard(Connection conn, String sort) {
		
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
			
			pstmt.setInt(1, categoryNo);			
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

	public ArrayList<Board> selectAllResolvedBoard(Connection conn, String sort) {
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
			
			pstmt.setInt(1, categoryNo);
			
			
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
	//게시판 글 게시
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
	
	
	//게시판 글 게시 끝
	
	//제보게시판 글 회수
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

	
	//사건게시글 삭제
	public int boardDelete(Connection conn, int bno) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("boardDelete");
		
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
	
	
	
	//사건정보 삭제
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
	//사건 첨부파일 삭제
	public int attachmentDelete(Connection conn, int bno) {
		
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
	//사건 리플 삭제
	public int replyDelete(Connection conn, int bno) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("replyDelete");
		
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
	//사건리뷰 삭제
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


	//첨부파일 전부 조회

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
		
		String sql = prop.getProperty("selectRpListForManage");
		
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
	
	//제보영상게시판 검색 조회
	public ArrayList<Board> searchAccidentBoard(Connection conn, String searchFilter, String region, int partType,
			String insuranceType, String keyword, int categoryNo) {
		ArrayList<Board> blist = new ArrayList<Board>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = null;
		
		//검색필터가 제목일때
		if(searchFilter.equals("title")||searchFilter.equals("")) {
			sql = prop.getProperty("searchAccidentBoardByTitleForManage");
		}else {
		//검색필터가 작성자일때
			sql = prop.getProperty("searchAccidentBoardByWriterForManage");
		}
		
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
			
			rset = pstmt.executeQuery();
			
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
				if(categoryNo==4) {
				b.setCategoryName(rset.getString("USER_NAME"));	
				}
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
		
	//자유게시판 게시글 총 갯수
		public int freeBoardCount(Connection conn, int[] cArr) {
			
			int count = 0;
			
			PreparedStatement pstmt = null;
			ResultSet rset = null;
			
			String sql = prop.getProperty("freeBoardCount");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cArr[0]);
			pstmt.setInt(2, cArr[1]);
			
			rset = pstmt.executeQuery();
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

		
		
	//자유게시판 게시글 리스트조회
	public ArrayList<Board> selectFreeBoardList(Connection conn, int[] cArr) {
		
		ArrayList<Board> list = new ArrayList<Board>();
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("selectFreeBoardList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, cArr[0]);
			pstmt.setInt(2, cArr[1]);
			
			rset=pstmt.executeQuery();
			//BOARD_NO, USER_ID, CATEGORY_NO, TITLE, COUNT, CREATE_DATE, LIKED, REPORT_COUNT, RP_COUNT, B.STATUS
			while(rset.next()) {
				list.add(new Board(rset.getInt("BOARD_NO"),
								   rset.getString("USER_ID"),
								   rset.getInt("CATEGORY_NO"),
								   rset.getString("TITLE"),
								   rset.getInt("COUNT"),
								   rset.getDate("CREATE_DATE"),
								   rset.getInt("LIKED"),
								   rset.getInt("REPORT_COUNT"),
								   rset.getInt("RP_COUNT"),
								   rset.getString("STATUS")));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return list;
	}

	//자유게시판 게시글 정렬 조회
	public ArrayList<Board> selectFreeBoardList(Connection conn, int[] cArr, String sort) {

		ArrayList<Board> list = new ArrayList<Board>();
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		
		String sql = "";
		if(sort.equals("liked")) {
			sql = prop.getProperty("likedFreeBoardList");
		}else if(sort.equals("report")) {
			sql = prop.getProperty("reportFreeBoardList");
		}else if(sort.equals("count")) {
			sql = prop.getProperty("countFreeBoardList");
		}else if(sort.equals("reply")) {
			sql = prop.getProperty("replyFreeBoardList");
		}
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, cArr[0]);
			pstmt.setInt(2, cArr[1]);
			
			rset=pstmt.executeQuery();
			//BOARD_NO, USER_ID, CATEGORY_NO, TITLE, COUNT, CREATE_DATE, LIKED, REPORT_COUNT, RP_COUNT, B.STATUS
			while(rset.next()) {
				list.add(new Board(rset.getInt("BOARD_NO"),
								   rset.getString("USER_ID"),
								   rset.getInt("CATEGORY_NO"),
								   rset.getString("TITLE"),
								   rset.getInt("COUNT"),
								   rset.getDate("CREATE_DATE"),
								   rset.getInt("LIKED"),
								   rset.getInt("REPORT_COUNT"),
								   rset.getInt("RP_COUNT"),
								   rset.getString("STATUS")));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return list;
	}

	
	//자유게시판 해당 게시글 첨부파일 있는지 여부 조회
	public Attachment selectAt(Connection conn, int bno) {
		
		Attachment at = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectAt");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				at = new Attachment(rset.getInt("FILE_NO"),
									rset.getString("CHANGE_NAME"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		
		return at;
	}
	
	
	//삭제할 게시글 정보 조회
	public Board selectBoard(Connection conn, int bno) {
		Board b = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String sql = prop.getProperty("selectBoard");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, bno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				b = new Board();
				b.setCategoryNo(rset.getInt("CATEGORY_NO"));
				b.setLiked(rset.getInt("LIKED"));
				b.setReportCount(rset.getInt("REPORT_COUNT"));
				b.setRpCount(rset.getInt("RP_COUNT"));
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		
		return b;
	}

	//자유게시판 해당 게시글 첨부파일 삭제
	public int freeBoardAtDelete(Connection conn, int bno) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("freeBoardAtDelete");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//해당 게시글 관련 댓글 삭제
	public int freeBoardRpDelete(Connection conn, int bno) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("freeBoardRpDelete");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//해당 게시글 관련 추천 삭제
	public int freeBoardLikedDelete(Connection conn, int bno) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("freeBoardLikedDelete");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//해당 게시글 관련 신고 삭제
	public int freeBoardReportDelete(Connection conn, int bno) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("freeBoardReportDelete");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//최종 - 해당게시글 영구 삭제
	public int freeBoardDelete(Connection conn, int bno) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("freeBoardDelete");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, bno);
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//공지사항 게시글리스트 조회
	public ArrayList<Board> selectFreeBoardNoticeList(Connection conn) {
		
		ArrayList<Board> list = new ArrayList<Board>();
		ResultSet rset = null;
		Statement stmt = null;
		
		String sql = prop.getProperty("selectFreeBoardNoticeList");
		
		try {
			stmt = conn.createStatement();

			rset=stmt.executeQuery(sql);
			
			while(rset.next()) {
				list.add(new Board(rset.getInt("BOARD_NO"),
								   rset.getString("USER_ID"),
								   rset.getInt("CATEGORY_NO"),
								   rset.getString("TITLE"),
								   rset.getInt("COUNT"),
								   rset.getDate("CREATE_DATE"),
								   rset.getInt("LIKED"),
								   rset.getInt("REPORT_COUNT"),
								   rset.getInt("RP_COUNT"),
								   rset.getString("STATUS")));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}
		
		return list;
	}

	//삭제대기 게시글 리스트 조회
	public ArrayList<Board> selectFreeDWBoardList(Connection conn, int[] cArr) {
		
		ArrayList<Board> list = new ArrayList<Board>();
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("selectFreeDWBoardList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cArr[0]);
			pstmt.setInt(2, cArr[1]);
			
			rset= pstmt.executeQuery();
			
			while(rset.next()) {
				list.add(new Board(rset.getInt("BOARD_NO"),
								   rset.getString("USER_ID"),
								   rset.getInt("CATEGORY_NO"),
								   rset.getString("TITLE"),
								   rset.getInt("COUNT"),
								   rset.getDate("CREATE_DATE"),
								   rset.getInt("LIKED"),
								   rset.getInt("REPORT_COUNT"),
								   rset.getInt("RP_COUNT"),
								   rset.getString("STATUS")));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return list;
	}

	//정렬에 의한 삭제대기리스트 조회
	public ArrayList<Board> selectFreeDWBoardList(Connection conn, int[] cArr, String sort) {
		
		ArrayList<Board> list = new ArrayList<Board>();
		ResultSet rset = null;
		PreparedStatement pstmt = null;
		
		String sql = "";
		if(sort.equals("recent")) {
			sql = prop.getProperty("recentDeldList");
		}else if(sort.equals("old")) {
			sql = prop.getProperty("oldDelList");
		}
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, cArr[0]);
			pstmt.setInt(2, cArr[1]);
			
			rset=pstmt.executeQuery();
			//BOARD_NO, USER_ID, CATEGORY_NO, TITLE, COUNT, CREATE_DATE, LIKED, REPORT_COUNT, RP_COUNT, B.STATUS
			while(rset.next()) {
				list.add(new Board(rset.getInt("BOARD_NO"),
								   rset.getString("USER_ID"),
								   rset.getInt("CATEGORY_NO"),
								   rset.getString("TITLE"),
								   rset.getInt("COUNT"),
								   rset.getDate("CREATE_DATE"),
								   rset.getInt("LIKED"),
								   rset.getInt("REPORT_COUNT"),
								   rset.getInt("RP_COUNT"),
								   rset.getString("STATUS")));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return list;
	}
	
	
	public AccidentReview selectAccidentReviewForManage(Connection conn, int accNo) {
		AccidentReview ar = null;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectAccidentReviewForManage");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, accNo);
			
			rset = pstmt.executeQuery();
					
			while(rset.next()) {
				ar = new AccidentReview();
				
				ar.setArNo(rset.getInt("AR_NO"));
				//대충 있는지만 확인
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
