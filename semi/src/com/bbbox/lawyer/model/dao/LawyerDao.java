package com.bbbox.lawyer.model.dao;

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
import com.bbbox.common.JDBCTemplate;
import com.bbbox.lawyer.model.vo.Counsel;
import com.bbbox.lawyer.model.vo.LawAttachment;
import com.bbbox.lawyer.model.vo.LawReview;
import com.bbbox.lawyer.model.vo.Lawyer;
import com.bbbox.lawyer.model.vo.PartCategory;

public class LawyerDao {
	
	private Properties prop = new Properties();
	
	public LawyerDao() {
		String filePath = LawyerDao.class.getResource("/sql/lawyer/lawyer-mapper.xml").getPath();
		
		try {
			prop.loadFromXML(new FileInputStream(filePath));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

	//전체 변호사 리스트 조회
	public ArrayList<Lawyer> selectList(Connection conn) {
		
		ArrayList<Lawyer> list = new ArrayList<>();
		
		Statement stmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectList");
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			
			while(rset.next()) {
				list.add(new Lawyer(rset.getInt("LAW_NO"),
									rset.getString("USER_NAME"),
									rset.getString("PART_NAME"),
									rset.getString("COMPANY_NAME"),
									rset.getString("COMPANY_ADDRESS"),
									rset.getString("LAW_IMG")));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}
		
		return list;
	}

	//전체 변호사 분야 조회
	public ArrayList<PartCategory> selectPart(Connection conn) {
		
		ArrayList<PartCategory> list = new ArrayList<>();
		
		Statement stmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectPart");
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			
			while(rset.next()) {
				list.add(new PartCategory(rset.getInt("PART_NO"),
									rset.getString("PART_NAME")));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}
		
		return list;
	}
	
	//조건으로 검색한 변호사 리스트 조회
	public ArrayList<Lawyer> searchList(Connection conn, String nameKey, String cateKey, String localKey) {
		
		ArrayList<Lawyer> lawList = new ArrayList<>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("searchList");
		
		try {
			pstmt = conn.prepareStatement(sql);
		
			//이름 값
			if(nameKey.equals("")) {
				pstmt.setString(1, "%%");
			}else {
				pstmt.setString(1, "%"+nameKey+"%");
			}
			
			//분야 값
			if(cateKey.equals("전체")) {
				pstmt.setString(2, "%%");
			}else {
				pstmt.setString(2, "%"+cateKey+"%");
			}
			
			//지역 값
			if(localKey.equals("전체")) {
				pstmt.setString(3, "%%");
			}else {
				pstmt.setString(3, "%"+localKey+"%");
			}
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				lawList.add(new Lawyer(rset.getInt("LAW_NO"),
									rset.getString("USER_NAME"),
									rset.getString("PART_NAME"),
									rset.getString("COMPANY_NAME"),
									rset.getString("COMPANY_ADDRESS"),
									rset.getString("LAW_IMG")));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return lawList;
	}

	//선택된 변호사의 상세정보
	public Lawyer selectLawyer(Connection conn, int lno) {
		
		Lawyer law = null;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectLawyer");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, lno);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				law = new Lawyer(rset.getInt("LAW_NO"),
								 rset.getString("USER_NAME"),
								 rset.getString("PART_NAME"),
								 rset.getString("EXAM"),
								 rset.getInt("EXAM_SESSION"),
								 rset.getInt("PASS_DATE"),
								 rset.getString("COMPANY_NAME"),
								 rset.getString("COMPANY_ADDRESS"),
								 rset.getString("COMPANY_PN"),
								 rset.getString("LAW_COMMENT"),
								 rset.getString("CAREER"),
								 rset.getString("LAW_IMG"));
			}
					
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
	
		return law;
	}
	
	//현재 찜한 여부 체크
	public int dibsCheck(Connection conn, int lawNo, int userNo) {
		
		int count = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rset =  null;
		String sql = prop.getProperty("dibsCheck");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, lawNo);
			pstmt.setInt(2, userNo);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				count = rset.getInt("COUNT");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return count;
	}

	//찜하기 상태 변경 (찜하기 등록 or 찜하기 해제)
	public int dibsUpdate(Connection conn, String heart, int lawNo, int userNo) {
		
		int count = 0;
		
		PreparedStatement pstmt = null;
		String sql = "";
		if(heart.equals("emptyHeart")) { //찜한 상태가 아니었다면 찜하기 등록
			sql = prop.getProperty("insertDibs");
		}else { //찜한 상태였다면 찜하기 삭제
			sql = prop.getProperty("deleteDibs");
		}
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, lawNo);
			pstmt.setInt(2, userNo);
			
			count = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return count;
	}

	//상담신청 내용 등록
	public int insertCounsel(Connection conn, Counsel c) {

		int count = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertCounsel");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(c.getRefLno()));
			pstmt.setInt(2, Integer.parseInt(c.getCsWriter()));
			pstmt.setString(3, c.getCsTitle());
			pstmt.setString(4, c.getCsContent());
			
			count = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return count;
	}

	//선택된 분야의 변호사 번호/이름 리스트 조회 (상담신청 폼)
	public ArrayList<Lawyer> lawOptionChange(Connection conn, String partName) {
		
		ArrayList<Lawyer> lawList = new ArrayList<>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("partOptionChange");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, partName);
			rset =  pstmt.executeQuery();
			
			while(rset.next()) {
				lawList.add(new Lawyer(rset.getInt("LAW_NO"),
									   rset.getString("USER_NAME")));
			};
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return lawList;
	}

	//선택된 변호사의 분야 조회 (상담신청 폼)
	public PartCategory partOptionChange(Connection conn, String lawNo) {
		
		PartCategory part = null;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("lawOptionChange");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(lawNo));
			rset =  pstmt.executeQuery();
			
			if(rset.next()) {
				part = new PartCategory(rset.getInt("PART_NO"),
						   rset.getString("PART_NAME"));
			};
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return part;
	}

	//해당 변호사 리뷰 조회
	public ArrayList<LawReview> selectReviewList(Connection conn, int lno) {
		ArrayList<LawReview> rList = new ArrayList<>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectReviewList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, lno);
			rset =  pstmt.executeQuery();
			
			while(rset.next()) {
				rList.add(new LawReview(rset.getInt("REVIEW_NO"),
										rset.getInt("REF_ANO"),
										rset.getString("REVIEW_CONTENT"),
										rset.getString("STAR"),
										rset.getInt("USER_NO"),
										rset.getString("USER_ID")));
			};
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return rList;
	}

	//리뷰 작성 등록
	public int insertReview(Connection conn, int accNo, String star, String content) {
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("insertReview");
		System.out.println(accNo+","+star+","+content);
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, accNo);
			pstmt.setString(2, content);
			pstmt.setString(3, star);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			JDBCTemplate.close(pstmt);
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//상담 정보 조회
	public Counsel selectCounsel(Connection conn, int cno) {
		
		Counsel c = new Counsel();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectCounsel");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				c = new Counsel(rset.getInt("CS_NO"),
								rset.getString("REF_LNO"),
								rset.getString("CS_TITLE"),
								rset.getString("CS_CONTENT"),
								rset.getString("CS_ANSWER"),
								rset.getString("ACCEPT"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return c;
	}

	//상담 내용 수정
	public int updateCounsel(Connection conn, int cno, String title, String content) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("updateCounsel");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, content);
			pstmt.setInt(3, cno);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			JDBCTemplate.close(pstmt);
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//상담내역 삭제
	public int deleteCounsel(Connection conn, int cno) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteCounsel");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cno);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			JDBCTemplate.close(pstmt);
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//리뷰내역 삭제
	public int deleteReview(Connection conn, int reNo) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteReview");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reNo);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			JDBCTemplate.close(pstmt);
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//상담정보 조회 (변호사용)
	public Counsel selectCounselLaw(Connection conn, int cno) {
		
		Counsel c = new Counsel();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectCounselLaw");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, cno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				c = new Counsel(rset.getInt("CS_NO"),
								rset.getString("REF_LNO"),
								rset.getString("USER_ID"),
								rset.getString("CS_TITLE"),
								rset.getString("CS_CONTENT"),
								rset.getString("CS_ANSWER"),
								rset.getString("ACCEPT"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return c;
	}

	//상담 답변 등록 (변호사)
	public int updateAnswer(Connection conn, String aResult, String answer, int csNo) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = "";
		
		if(aResult.equals("accept")) { //수락답변
			sql = prop.getProperty("updateAnswerAccept");
		}else { //거절답변
			sql = prop.getProperty("updateAnswerDecline");
		}
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, answer);
			pstmt.setInt(2, csNo);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			JDBCTemplate.close(pstmt);
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//상담 수락 여부 (회원용)
	public int updateAccept(Connection conn, int csNo, String aResult) {
		
		int result = 0;
		PreparedStatement pstmt = null;
		String sql = "";
		
		if(aResult.equals("accept")) { //수락답변
			sql = prop.getProperty("updateAcceptAccept");
		}else { //거절답변
			sql = prop.getProperty("updateAcceptDecline");
		}
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, csNo);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			JDBCTemplate.close(pstmt);
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//상담 번호로 상담 정보 조회 (변호사리뷰용)
	public Accident selectAccident(Connection conn, int accNo) {
		
		Accident ac = null;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectAccident");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, accNo);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				ac = new Accident(rset.getInt("ACC_NO"),
								  rset.getInt("REF_LNO"),
								  rset.getString("TITLE"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
	
		return ac;
	}

	//리뷰 상세보기
	public LawReview selectReview(Connection conn, int reNo) {
		LawReview re = null;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectReview");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, reNo);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				re = new LawReview(rset.getInt("REVIEW_NO"),
								   rset.getInt("REF_ANO"),
								   rset.getString("REVIEW_CONTENT"),
								   rset.getString("STAR"),
								   rset.getInt("USER_NO"),
								   rset.getString("USER_ID"));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
	
		return re;
	}
	
	//변호사 신청 내용 조회
	public Lawyer selectApply(Connection conn, int userNo) {
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;

		Lawyer apply = null;
		
		String sql = prop.getProperty("selectApply");
		

		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, userNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				
				apply= new Lawyer(rset.getInt("LAW_NO"),
								   rset.getString("PART_NAME"),
								   rset.getString("EXAM"),
								   rset.getInt("EXAM_SESSION"),
								   rset.getInt("PASS_DATE"),
								   rset.getString("COMPANY_NAME"),
								   rset.getString("COMPANY_ADDRESS"),
								   rset.getString("COMPANY_PN"),
								   rset.getString("LAW_COMMENT"),
								   rset.getString("CAREER"));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		
		return apply;
	}
	
	
	//변호사 사진 조회 
	public String selectLawAttachment(Connection conn, int userNo) {
	
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("selectLawAttachment");
		
		String lat = "";
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, userNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				
				lat = rset.getString("LAW_IMG");
			
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return lat;
		
	}

	/* ================================== 관리자용 ===================================== */
	
	//변호사 리스트 조회 (관리자용)
	public ArrayList<Lawyer> manageSelectLawList(Connection conn) {

		ArrayList<Lawyer> list = new ArrayList<>();
		
		Statement stmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("manageSelectLawList");
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			
			while(rset.next()) {
				list.add(new Lawyer(rset.getInt("LAW_NO"),
									rset.getString("USER_NAME"),
									rset.getString("PART_NAME"),
									rset.getString("COMPANY_ADDRESS"),
									rset.getInt("해결영상수"),
									rset.getInt("상담매칭수"),
									rset.getDouble("리뷰평점"),
									rset.getString("LAWYER")));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}
		
		return list;
	}

	//조건으로 검색한 변호사 리스트 조회 (관리자용)
	public ArrayList<Lawyer> manageSearchLawList(Connection conn, String nameKey, String cateKey, String localKey, String sort) {

		ArrayList<Lawyer> lawList = new ArrayList<>();
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = "";
		if(sort == null) {
			sql = prop.getProperty("manageSearchLawList");
		} else if(sort.equals("solvedAccCount")) {
			sql = prop.getProperty("manageSearchLawListSolved");
		}else if(sort.equals("counselMatchCount")) {
			sql = prop.getProperty("manageSearchLawListMatch");
		}else {
			sql = prop.getProperty("manageSearchLawListAverage");
		}
		
		try {
			pstmt = conn.prepareStatement(sql);
		
			//이름 값
			if(nameKey.equals("")) {
				pstmt.setString(1, "%%");
			}else {
				pstmt.setString(1, "%"+nameKey+"%");
			}
			
			//분야 값
			if(cateKey.equals("전체")) {
				pstmt.setString(2, "%%");
			}else {
				pstmt.setString(2, "%"+cateKey+"%");
			}
			
			//지역 값
			if(localKey.equals("전체")) {
				pstmt.setString(3, "%%");
			}else {
				pstmt.setString(3, "%"+localKey+"%");
			}
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				lawList.add(new Lawyer(rset.getInt("LAW_NO"),
									   rset.getString("USER_NAME"),
								   	   rset.getString("PART_NAME"),
									   rset.getString("COMPANY_ADDRESS"),
									   rset.getInt("해결영상수"),
									   rset.getInt("상담매칭수"),
									   rset.getDouble("리뷰평점"),
									   rset.getString("LAWYER")));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return lawList;
	}

	//변호사 권한 변경 (관리자용)
	public int manageLawLawyer(Connection conn, int lno, String button) {

		int result = 0;
		PreparedStatement pstmt = null;
		String sql = "";
		
		if(button.equals("ON")) { //변호사 권한을 'N'으로
			sql = prop.getProperty("manageLawLawyerN");
		}else { //"OFF"일 경우 변호사 권한을 'Y'으로
			sql = prop.getProperty("manageLawLawyerY");
		}
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, lno);
			
			result = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			JDBCTemplate.close(pstmt);
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//상담 리스트 조회 (관리자용)
	public ArrayList<Counsel> selectCounselList(Connection conn) {

		ArrayList<Counsel> cList = new ArrayList<>();
		
		Statement stmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectCounselList");
		
		try {
			stmt = conn.createStatement();
			rset = stmt.executeQuery(sql);
			
			while(rset.next()) {
				cList.add(new Counsel(rset.getInt("CS_NO"),
									  rset.getString("LAW_NAME"),
									  rset.getString("USER_ID"),
									  rset.getString("CS_TITLE"),
									  rset.getString("CS_CONTENT"),
									  rset.getDate("CREATE_DATE"),
									  rset.getString("CS_ANSWER"),
									  rset.getString("ACCEPT"),
									  rset.getString("STATUS")));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(stmt);
		}
		
		return cList;
	}

	//변호사 번호로 회원번호 조회 (관리자용)
	public int selectUserNo(Connection conn, int lno) {

		int userNo = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String sql = prop.getProperty("selectUserNo");

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, lno);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				userNo = rset.getInt("REF_UNO");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return userNo;
	}
}
