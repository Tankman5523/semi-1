package com.bbbox.board.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.bbbox.board.model.dao.AccidentBoardDao;
import com.bbbox.board.model.vo.Accident;
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
		
		return null;
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
	public ArrayList<Board> searchByTitle(String searchFilter, String region, int partType, String insuranceType, String keyword, PageInfo pi) {
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new AccidentBoardDao().searchByTitle(conn,searchFilter,region,partType,insuranceType,keyword,pi);
		
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

	
	
	
	
}
