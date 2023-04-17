package com.bbbox.board.model.service;

import java.sql.Connection;
import java.util.ArrayList;

import com.bbbox.board.model.dao.BoardDao;
import com.bbbox.board.model.vo.Board;
import com.bbbox.common.JDBCTemplate;

public class BoardService {

	public ArrayList<Board> selectBoardList() {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new BoardDao().selectBoardList(conn);
		
		JDBCTemplate.close(conn);
		
		return list;
	}

}
