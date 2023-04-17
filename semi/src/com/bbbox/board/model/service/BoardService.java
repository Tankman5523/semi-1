package com.bbbox.board.model.service;

import java.util.ArrayList;

import com.bbbox.board.model.vo.Board;

public class BoardService {

	public ArrayList<Board> selectBoardList() {
		
		Connection conn = JDBCTemplate.getConnection();
		
		return null;
	}

}
