package com.bbbox.board.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.bbbox.board.model.dao.BoardDao;
import com.bbbox.board.model.vo.Attachment;
import com.bbbox.board.model.vo.Board;
import com.bbbox.common.JDBCTemplate;

public class BoardService {
	
	//등록된 게시글리스트 조회
	public ArrayList<Board> selectBoardList() {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new BoardDao().selectBoardList(conn);
		
		JDBCTemplate.close(conn);
		
		return list;
	}
	
	//게시판 조회수 증가
	public int increaseBoardCount(int boardNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().increaseBoardCount(conn, boardNo);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);			
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	//특정 게시글 한개 조회
	public Board selectBoard(int boardNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		Board b = new BoardDao().selectBoard(conn, boardNo);
		
		JDBCTemplate.close(conn);
		
		return b;
	}

	//좋아요 개수 증가 메소드
	public int insertLiked(int boardNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new BoardDao().insertLiked(conn, boardNo);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);			
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	//게시글 작성 메소드
	public int insertBoard(Board b, Attachment at) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int result1 = new BoardDao().insertBoard(conn, b);
		
		int result2 = 0;
		
		if(at != null) {
			result2 = new BoardDao().insertAttachment(conn, at);
		}else {
			result2 = 1;
		}
		
		if(result1>0 && result2>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result1*result2;
	}

	//게시글안의 첨부파일 조회
	public Attachment selectAttachment(int boardNo) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		Attachment at = new BoardDao().selectAttachment(conn, boardNo);
		
		JDBCTemplate.close(conn);
		
		return at;
	}

}
