package com.bbbox.member.model.dao;

import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Properties;

import com.bbbox.board.model.vo.Accident;
import com.bbbox.board.model.vo.AccidentReview;
import com.bbbox.board.model.vo.Board;
import com.bbbox.board.model.vo.Reply;
import com.bbbox.common.JDBCTemplate;
import com.bbbox.lawyer.model.vo.Counsel;
import com.bbbox.lawyer.model.vo.LawAttachment;
import com.bbbox.lawyer.model.vo.LawReview;
import com.bbbox.lawyer.model.vo.Lawyer;
import com.bbbox.member.model.vo.Member;
import com.bbbox.qaboard.model.vo.Question;

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
			pstmt.setString(4, insertMember.getPhone());
			pstmt.setString(5, insertMember.getEmail());
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
	public Member selectEmail(Connection conn, String testEmail) {
		
		Member m = null;
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("selectEmail");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, testEmail);
			
			rset=pstmt.executeQuery();
			
			if(rset.next()) {
				m = new Member(rset.getString("USER_ID"),
							   rset.getString("USER_PWD"));
			}
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return m;
	}
	
	//회원정보 수정 메소드 
	public int updateMember(Connection conn, Member m) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("updateMember");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1,m.getUserPwd());
			pstmt.setString(2, m.getUserName());
			pstmt.setString(3, m.getPhone());
			pstmt.setString(4, m.getEmail());
			pstmt.setString(5, m.getAddress());
			pstmt.setString(6, m.getUserId());
			
			result = pstmt.executeUpdate();
		
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}
	
	//비밀번호 변경 메소드
	public int updatePwd(Connection conn, String email, String tempPwd) {

		int result = 0;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("updatePwd");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, tempPwd);
			pstmt.setString(2, email);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}
	
	//회원 탈퇴 메소드 
	public int deleteMember(Connection conn, int userNo) {
		
		int result = 0 ;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("deleteMember");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, userNo);
			
			result = pstmt.executeUpdate();
			
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		
		return result;
	}
	
	//프로필 사진 등록 
	public int insertProfile(Connection conn, LawAttachment lat) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("insertProfile");
		
		try {
			pstmt=conn.prepareStatement(sql);
			
			pstmt.setInt(1, Integer.parseInt(lat.getRefUno()));
			pstmt.setString(2, lat.getOriginName());
			pstmt.setString(3, lat.getChangeName());
			pstmt.setString(4, lat.getFilePath());
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}
	
	//변호사 회원 신청 메소드
	public int insertApply(Connection conn, Lawyer applyla) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("insertApply");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, Integer.parseInt(applyla.getRefUno()));
			pstmt.setInt(2, Integer.parseInt(applyla.getRefPno()));
			pstmt.setString(3, applyla.getExam());
			pstmt.setInt(4, applyla.getExamSession());
			pstmt.setInt(5, applyla.getPassDate());
			pstmt.setString(6, applyla.getCompanyName());
			pstmt.setString(7, applyla.getCompanyAddress());
			pstmt.setString(8, applyla.getCompanyPn());
			pstmt.setString(9, applyla.getLawComment());
			pstmt.setString(10, applyla.getCareer());
			
			result = pstmt.executeUpdate();

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}
	
	//변호사 회원 신청 유저의 상태값 변경 메소드  
	public int updateLawyerGrant(Connection conn, Lawyer applyla) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("updateLawyerGrant");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, Integer.parseInt(applyla.getRefUno()));
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}
	
	//변호사 회원 권한 유무 조회 메소드  
	public String selectLawyerGrant(Connection conn, int userNo) {
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("selectLawyerGrant");	
		
		String lawyer ="";
		
		try {
			pstmt =conn.prepareStatement(sql);
			
			pstmt.setInt(1, userNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				lawyer = rset.getString("LAWYER");
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return lawyer;
	}
	
	
	//찜한 변호사 목록 조회하는 메소드
	public ArrayList<Lawyer> selectDibsLawyer(Connection conn, int userNo) {

		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("selectDibsLawyer");
		
		ArrayList<Lawyer> lawList = new ArrayList<>();

		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, userNo);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				lawList.add(new Lawyer(rset.getInt("LAW_NO"),
									   rset.getString("USER_NAME")));
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
	
	//내가 쓴 게시글 조회 
	public ArrayList<Board> selectBoardList(Connection conn, int userNo) {
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("selectBoardList");
		
		ArrayList<Board> boardList = new ArrayList<>();
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, userNo);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				boardList.add(new Board(rset.getInt("BOARD_NO"),
										rset.getString("TITLE"),
										rset.getDate("CREATE_DATE"),
										rset.getString("CATEGORY_NAME")));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		
		return boardList;
	}

	//내가 쓴 댓글 조회 
	public ArrayList<Reply> selectReplyList(Connection conn, int userNo) {
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("selectReplyList");
		
		ArrayList<Reply> replyList = new ArrayList<>();
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, userNo);
			
			rset=pstmt.executeQuery();
			
			while(rset.next()) {
				replyList.add(new Reply(rset.getInt("RP_NO"),
										rset.getInt("REF_BNO"),
										rset.getString("RP_CONTENT"),
										rset.getDate("RP_CREATE_DATE"),
										rset.getString("CATEGORY"),
										rset.getString("BOARD_STATUS")));
			}
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return replyList;
	}
	
	// 내 상담 신청 내역 조회하는 메소드 
	public ArrayList<Counsel> selectCounselList(Connection conn, int userNo) {
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("selectCounselList");
		
		ArrayList<Counsel> cList = new ArrayList<>();
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, userNo);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				cList.add(new Counsel(rset.getInt("CS_NO"),
									  rset.getString("CS_TITLE"),
									  rset.getDate("CREATE_DATE"),
									  rset.getString("CS_ANSWER"),
									  rset.getString("ACCEPT")));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return cList;
	}
	
	//변호사 리뷰 (일반회원) 리스트 조회 메소드 	
	public ArrayList<LawReview> selectLawReviewList(Connection conn, int userNo) {
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("selectLawReviewList");
		
		ArrayList<LawReview> lawRev = new ArrayList<>();
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, userNo);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				lawRev.add(new LawReview(rset.getInt("REVIEW_NO"),
										 rset.getInt("REF_ANO"),
										 rset.getString("REVIEW_CONTENT"),
										 rset.getString("STAR")));
				
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
 		}finally {
 			JDBCTemplate.close(rset);
 			JDBCTemplate.close(pstmt);
 			
 		}
		
		return lawRev;
	}

	
	public ArrayList<AccidentReview> selectAccidentReviewList(Connection conn, int userNo) {
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("selectAccidentReviewList");
		
		ArrayList<AccidentReview> accRev = new ArrayList<>();
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, userNo);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				accRev.add(new AccidentReview(rset.getInt("AR_NO"),
											  rset.getInt("LAW_NO"),
											  rset.getString("CONTENT")));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return accRev;
	}

	public ArrayList<Accident> selectAccidentList(Connection conn, int userNo) {
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("selectAccidentList");
		
		ArrayList<Accident> accident = new ArrayList<>();
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, userNo);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()){
				accident.add(new Accident(rset.getInt("ACC_NO"),
											  rset.getInt("REF_BNO"),
											  rset.getInt("REF_LNO"),
											  rset.getString("PART_NAME"),
											  rset.getString("TITLE"),
											  rset.getString("SOLVE")));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return accident;
	}

	//나에게 온 상담내역 조회하는 메소드 (변호사)
	public ArrayList<Counsel> selectCounselListLaw(Connection conn, int userNo) {

		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("selectCounselListLaw");
		
		ArrayList<Counsel> cListLaw = new ArrayList<>();
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, userNo);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				cListLaw.add(new Counsel(rset.getInt("CS_NO"),
									  rset.getString("CS_TITLE"),
									  rset.getDate("CREATE_DATE"),
									  rset.getString("CS_ANSWER"),
									  rset.getString("ACCEPT")));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		return cListLaw;
	}

	//1대1 문의글 조회 메소드 
	public ArrayList<Question> selectQuestionList(Connection conn, int userNo) {

		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("selectQuestionList");
		
		ArrayList<Question> qList = new ArrayList<>();
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, userNo);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				
				qList.add(new Question(rset.getInt("QNO"),
									   rset.getString("TITLE"),
									   rset.getString("CATEGORY_NAME"),
									   rset.getDate("CREATE_DATE")));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
		}
		
		
		
		return qList;
	}

	//변호사 신청 회원 정보 조회(관리자)
	public Member selectMemberInfo(Connection conn, int userNo) {
		
		ResultSet rset = null;
		
		PreparedStatement pstmt = null;
		
		Member applyMem = null;
		
		String sql = prop.getProperty("selectMemberInfo");

		try {
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setInt(1, userNo);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				
				applyMem = new Member(rset.getInt("USER_NO"),
									  rset.getString("USER_ID"),
									  rset.getString("USER_NAME"),
									  rset.getString("PHONE"),
									  rset.getString("EMAIL"),
									  rset.getString("ADDRESS"));
				
				
			}
					
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(rset);
			JDBCTemplate.close(pstmt);
			
		}
		
		return applyMem;
	}

	public int acceptLawyer(Connection conn, int uno, int resultNum) {
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		String sql = "";
		
		if(resultNum > 0){
			sql = prop.getProperty("acceptLawyer"); //승인 
		}else { //거절 
			sql = prop.getProperty("refuseLawyer"); //거절
		}
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setInt(1, uno);
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}

	//변호사 회원정보 수정 메소드
	public int updateLawyer(Connection conn, Lawyer l) {
		
		int result = 0 ;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("updateLawyer");
		
		try {
			pstmt = conn.prepareStatement(sql);
		
			pstmt.setString(1, l.getCompanyName());
			pstmt.setString(2, l.getCompanyAddress());
			pstmt.setString(3, l.getCompanyPn());
			pstmt.setString(4, l.getLawComment());
			pstmt.setString(5, l.getCareer());
			pstmt.setString(6, l.getRefUno());
			
			result=pstmt.executeUpdate();
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result;
	}
	//변호사 사진 업데이트 	
	public int updateProfile(Connection conn, LawAttachment lat) {

		int result2 = 0;
		
		PreparedStatement pstmt = null;
		
		String sql = prop.getProperty("updateProfile");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, lat.getOriginName());
			pstmt.setString(2, lat.getChangeName());
			pstmt.setString(3, lat.getFilePath());
			pstmt.setString(4, lat.getRefUno());
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			JDBCTemplate.close(pstmt);
		}
		
		return result2;
	}
	
	

}
