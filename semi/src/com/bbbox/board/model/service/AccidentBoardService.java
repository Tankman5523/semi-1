package com.bbbox.board.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.bbbox.board.model.dao.AccidentBoardDao;
import com.bbbox.board.model.vo.Accident;
import com.bbbox.board.model.vo.AccidentReview;
import com.bbbox.board.model.vo.Attachment;
import com.bbbox.board.model.vo.Board;
import com.bbbox.board.model.vo.Reply;
import com.bbbox.common.JDBCTemplate;
import com.bbbox.common.model.vo.PageInfo;

public class AccidentBoardService {

	//제보영상게시판 '게시글' 읽어오기
	public ArrayList<Board> selectAccidentBoardList(PageInfo pi) {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Board> blist = new AccidentBoardDao().selectAccidentBoardList(conn,pi);
		
		JDBCTemplate.close(conn);
		
		return blist;
	}
	/*
	//제보영상게시판 '첨부파일(동영상)' 읽어오기
	public ArrayList<Attachment> selectAccidentAttachmentList() {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Attachment> alist = new AccidentBoardDao().selectAccidentAttachmentList(conn);
		
		JDBCTemplate.close(conn);
		
		return alist;
	}*/
	public int selectBoardListCount() {
		Connection conn = JDBCTemplate.getConnection();
		
		int listCount = new AccidentBoardDao().selectBoardListCount(conn);
		
		JDBCTemplate.close(conn);
		
		return listCount;
	}
	public ArrayList<Board> selectResolvedBoardList(PageInfo pi) {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Board> blist = new AccidentBoardDao().selectResolvedBoardList(conn,pi);
		
		JDBCTemplate.close(conn);
		
		return blist;
	}
	public int insertAccidentBoard(Board b) {
		//커밋하지말고 정보만 넣어두기
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new AccidentBoardDao().insertAccidentBoard(conn,b);
		
		if(result==0) {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		
		return result;
	}
	public int selectRefBoardNo() {
		//참조할 글번호가져오는 메소드
		Connection conn = JDBCTemplate.getConnection();
		int result = new AccidentBoardDao().selectRefBoardNo(conn);
		
		JDBCTemplate.close(conn);
		
		return result;
	}
	public int insertAccidentInfo(Accident ac) {
		
		Connection conn = JDBCTemplate.getConnection();
		int result = new AccidentBoardDao().insertAccidentInfo(conn,ac); 
		
		if(result==0) {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}
	public int insertAccidentAttachment(Attachment at) {
		
		Connection conn = JDBCTemplate.getConnection();
		int result = new AccidentBoardDao().insertAccidentAttachment(conn,at);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}
	public ArrayList<Board> searchAccidentBoard(String searchFilter, String region, int partType, String insuranceType, String keyword, int categoryNo, PageInfo pi) {
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new AccidentBoardDao().searchAccidentBoard(conn,searchFilter,region,partType,insuranceType,keyword,categoryNo,pi);
		
		JDBCTemplate.close(conn);
		
		return list;
	}
	public Board accidentBoardSelectDetail(int bno) {

		Connection conn = JDBCTemplate.getConnection();
		
		Board b = new AccidentBoardDao().accidentBoardSelectDetail(conn,bno);
		
		JDBCTemplate.close(conn);
		
		return b;
	}
	
	public Accident accidentSelectDetail(int bno) {
		Connection conn = JDBCTemplate.getConnection();
		
		Accident ac = new AccidentBoardDao().accidentSelectDetail(conn,bno);
		
		JDBCTemplate.close(conn);
		
		return ac;
	}
	public ArrayList<Reply> accidentReplySelectDetail(int bno) {
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Reply> rplist = new AccidentBoardDao().accidentReplySelectDetail(conn,bno);
		
		JDBCTemplate.close(conn);
		
		return rplist;
	}
	public int deleteAccidentBoard(int bno) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new AccidentBoardDao().deleteAccidentBoard(conn,bno);
		
		int result2=0;
		int result3=0;
		
		result2 = new AccidentBoardDao().deleteAccident(conn,bno);
		result3 = new AccidentBoardDao().deleteAccidentAttachment(conn,bno);
		
		if(result>0&&result2>0&&result3>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		return result*result2*result3;
	}
	public int updateAccidentBoard(Board b, Accident ac) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new AccidentBoardDao().updateAccidentBoard(conn,b);
		int result2 = new AccidentBoardDao().updateAccidentInfo(conn,ac);
		
		System.out.println(result);
		System.out.println(result2);
		
		if(result>0&&result2>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		return result*result2;
	}
	public int updateAccidentAttachment(Attachment at) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new AccidentBoardDao().updateAccidentAttachment(conn,at);		
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		return result;
	}
	
	public int selectResolvedBoardListCount() {
		Connection conn =JDBCTemplate.getConnection();
		
		int result = new AccidentBoardDao().selectResolvedBoardListCount(conn);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}
	public Board resolvedBoardSelectDetail(int bno) {
		Connection conn = JDBCTemplate.getConnection();
		
		Board b = new AccidentBoardDao().resolvedBoardSelectDetail(conn,bno);
		
		JDBCTemplate.close(conn);
		
		return b;
	}
	public Accident resolvedAccidentSelectDetail(int bno) {
		Connection conn = JDBCTemplate.getConnection();
		
		Accident ac = new AccidentBoardDao().resolvedAccidentSelectDetail(conn,bno);
		
		JDBCTemplate.close(conn);
		
		return ac;
	}
	public ArrayList<Reply> resolvedReplySelectDetail(int bno) {
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Reply> rplist = new AccidentBoardDao().resolvedReplySelectDetail(conn,bno);
		
		JDBCTemplate.close(conn);
		
		return rplist;
	}
	public AccidentReview resolvedBoardReviewSelectDetail(int accNo) {
		Connection conn = JDBCTemplate.getConnection();
		
		AccidentReview ar = new AccidentBoardDao().resolvedBoardReviewSelectDetail(conn,accNo);
		
		JDBCTemplate.close(conn);
		
		return ar;
	}
	public int insertAccidentReview(AccidentReview ar) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new AccidentBoardDao().insertAccidentReview(conn,ar);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}
	public int selectLawNoByUno(int uno) {
		Connection conn = JDBCTemplate.getConnection();
		
		int lawNo = new AccidentBoardDao().selectLawNoByUno(conn,uno);
		
		JDBCTemplate.close(conn);
		
		return lawNo;
	}
	public int shiftBoard(int bno, int accNo) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new AccidentBoardDao().updateBoardCategory(conn,bno);
		
		int result2 = new AccidentBoardDao().updateSolve(conn,accNo);
		
		if(result>0&&result2>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		return result*result2;
	}
	public ArrayList<Board> resolvedBoardSearch(String searchFilter, String region, int partType,
			String insuranceType, String keyword, int categoryNo, PageInfo pi) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new AccidentBoardDao().searchAccidentBoard(conn, searchFilter, region, partType, insuranceType, keyword, categoryNo, pi);
		
		JDBCTemplate.close(conn);
		
		return list;
	}
	public AccidentReview selectAccidentReview(int arNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		AccidentReview ar = new AccidentBoardDao().selectAccidentReview(conn,arNo);
		
		JDBCTemplate.close(conn);
		
		return ar;
	}
	public Attachment selectAttachment(int bno) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		Attachment at = new AccidentBoardDao().selectAttachment(conn,bno);
		
		JDBCTemplate.close(conn);
		
		return at;
	}
	public int updateAccidentReview(AccidentReview ar) {

		Connection conn = JDBCTemplate.getConnection();
		
		int result = new AccidentBoardDao().updateAccidentReview(conn,ar);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		return result;
	}
	public int deleteAccidentReview(int arNo) {

		Connection conn = JDBCTemplate.getConnection();
		
		int result = new AccidentBoardDao().deleteAccidentReview(conn,arNo);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		return result;
	}
	public int returnBoard(int bno, int accNo) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new AccidentBoardDao().returnBoardCategory(conn,bno);
		int result2 = new AccidentBoardDao().returnSolve(conn,accNo); 
		
		if(result>0 && result2>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		return result;
	}

	
	
	
	
}
