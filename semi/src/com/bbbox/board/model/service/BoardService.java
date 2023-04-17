package com.bbbox.board.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.bbbox.board.model.dao.BoardDao;
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

}
