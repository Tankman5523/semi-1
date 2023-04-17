package com.bbbox.board.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.bbbox.board.model.dao.AccidentBoardDao;
import com.bbbox.board.model.vo.Attachment;
import com.bbbox.board.model.vo.Board;
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
	
}
