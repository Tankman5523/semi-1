package com.bbbox.manager.service;

import java.io.File;
import java.sql.Connection;
import java.util.ArrayList;

import com.bbbox.board.model.dao.AccidentBoardDao;
import com.bbbox.board.model.dao.BoardDao;
import com.bbbox.board.model.vo.Attachment;
import com.bbbox.board.model.vo.Board;
import com.bbbox.board.model.vo.Reply;
import com.bbbox.common.JDBCTemplate;
import com.bbbox.common.model.vo.PageInfo;
import com.bbbox.manager.dao.ManagerDao;

public class ManagerService {

	public ArrayList<Board> selectAllAccidentBoard(PageInfo pi, String sort) {
		
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Board> blist = new ManagerDao().selectAllAccidentBoard(conn,pi,sort);
		
		JDBCTemplate.close(conn);
		
		return blist;
	}

	public ArrayList<Board> selectAllResolvedBoard(PageInfo pi, String sort) {
		Connection conn = JDBCTemplate.getConnection();
		ArrayList<Board> blist = new ManagerDao().selectAllResolvedBoard(conn,pi,sort);
		
		JDBCTemplate.close(conn);
		
		return blist;
	}

	public int boardStatusOn(int bno) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new ManagerDao().boardStatusOn(conn,bno);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	public int boardStatusOff(int bno) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result = new ManagerDao().boardStatusOff(conn,bno);
		
		if(result>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		
		JDBCTemplate.close(conn);
		
		return result;
	}

	public int accidentBoardDelete(int bno, Attachment at) {
		Connection conn = JDBCTemplate.getConnection();
		
		int result4 = 1; //리플없으면 넘어감
		ArrayList<Reply> rlist = new BoardDao().selectRpList(conn, bno);
		if(rlist.size()!=0) {
			new ManagerDao().accidentReplyDelete(conn,bno);
		}
		
		int result3 = 1; //첨부파일 없으면 넘어감
		if(at!=null) {
			result3 = new ManagerDao().accidentAttachmentDelete(conn,bno);
		}
		
		int result2 = new ManagerDao().accidentInfoDelete(conn,bno);
		int result = new ManagerDao().accidentBoardDelete(conn,bno);
		
		if(result>0 && result2>0 && result3>0 && result4>0) {
			JDBCTemplate.commit(conn);
		}else {
			JDBCTemplate.rollback(conn);
		}
		JDBCTemplate.close(conn);
		
		return result*result2*result3*result4;
	}

	//자유게시판 게시글 총 갯수
	public int freeBoardCount(int[] cArr) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		int count = new ManagerDao().freeBoardCount(conn, cArr);
		
		JDBCTemplate.close(conn);
		
		return count;
	}

	//자유게시판 게시글 리스트조회
	public ArrayList<Board> selectFreeBoardList(PageInfo pi, int[] cArr) {
		
		Connection conn = JDBCTemplate.getConnection();
		
		ArrayList<Board> list = new ManagerDao().selectFreeBoardList(conn, pi, cArr);
		
		JDBCTemplate.close(conn);
		
		return list;
	}
	
	
	
}
